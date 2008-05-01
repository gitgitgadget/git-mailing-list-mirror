From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 18:30:46 +0300
Message-ID: <4819E226.6000404@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com> <20080501152035.GB11145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 17:32:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JralF-0005Mn-86
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbYEAPas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYEAPar
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:30:47 -0400
Received: from smtp107.biz.mail.re2.yahoo.com ([206.190.52.176]:40812 "HELO
	smtp107.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752631AbYEAPar (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 11:30:47 -0400
Received: (qmail 14256 invoked from network); 1 May 2008 15:30:45 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp107.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 15:30:45 -0000
X-YMail-OSG: FMqiyngVM1nYySdfw22ssZnH3lc3lBcitedFcHMP85D8CeqpqGg7soJ2mqY4O6r7pprqU_fKw.iJ._DN61KJzl_YNc5gE8SrfHJ_0dyTMHCo7PDL_k3OJdbDOSZQrY56tN1mvIE77c4p4qJx0L8C6xM2
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080501152035.GB11145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80923>

Jeff King wrote:
> Of course it doesn't work here. You have two files, one containing
> "hello\n" and one containing "hello\nworld\n". Their similarity is 50%,
> which is not enough to consider it a rename. And I would argue that's
> reasonable, since the files have only one line in common. The problem is
> that you are using a toy example (which is why my example used
> /usr/share/dict/words, which has enough content to definitively call it
> a rename).
>
>   
Well, I would have expected git to notice that the file was renamed in 
one commit and keep tracking changes afterwards.

Also, as I wrote in another post, this happened to me with real files of 
a real source tree, and with very small changes (and sometimes not at 
all) to these files.

Ittay

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
