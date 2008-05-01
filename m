From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 18:20:16 +0300
Message-ID: <4819DFB0.5030401@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <20080501150958.GA11145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 17:21:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jraap-0000rv-H7
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbYEAPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYEAPUT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:20:19 -0400
Received: from smtp101.biz.mail.re2.yahoo.com ([68.142.229.215]:23381 "HELO
	smtp101.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753182AbYEAPUS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 11:20:18 -0400
Received: (qmail 43438 invoked from network); 1 May 2008 15:20:16 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp101.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 15:20:16 -0000
X-YMail-OSG: GsytyUkVM1nEL25exY.HbpH3JKpO.ilJ1nTQZHNt6lEKvUFhQRtWZ4CXBeSYS0JTfqAgtJwwY5IMBK3bqby1DM9Yt0ijc3fQFDGTWzWytJZMeZ68ud0kCIhGmNe9ZH7CdNqIZxfVBSx5w7pphC6eR6ai
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080501150958.GA11145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80917>


Jeff King wrote:
> My two cents:
>
> 1. I think he is overly obsessed with renaming. He seems concerned that
> somebody will show up, make a big renaming patch, and then break your
> system. Guess what? They can also show up, make a big code change patch,
> and then break your system. In either case you have to review the
> changes before accepting them, and it is up to the version control
> system to show you the changes in a way you can understand
I think he was more concerned that merges will break after such a change.

Ittay

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
