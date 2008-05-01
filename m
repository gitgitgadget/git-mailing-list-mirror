From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 17:54:06 +0300
Message-ID: <4819D98E.1040004@tikalk.com>
References: <4819CF50.2020509@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 16:54:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JraBV-0007lN-KG
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 16:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbYEAOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 10:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYEAOyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 10:54:09 -0400
Received: from smtp106.biz.mail.re2.yahoo.com ([206.190.52.175]:48233 "HELO
	smtp106.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752619AbYEAOyI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 10:54:08 -0400
Received: (qmail 29023 invoked from network); 1 May 2008 14:54:06 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp106.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 14:54:06 -0000
X-YMail-OSG: tfb_xfUVM1klHKIjYq3E1rtn4M_S1yFBH4HFtiD7LX4BtMWLpEEiCAxVyROlDJboctIbMC97VLYMb3Y0KySicg7ZMbqieYVNzflvOPw9og.BsLQA1eYqiPEhXzfAOqrrGrcLa2qr1AZ69sYEY7jgLKO9
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <4819CF50.2020509@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80914>

Also, would anyone like to comment on: 
http://www.markshuttleworth.com/archives/123 (Renaming is the killer app 
of distributed version control 
<http://www.markshuttleworth.com/archives/123>)?

Thank you,
Ittay

Ittay Dror wrote:
> Hi,
>
> Say I have a file A, I rename to 'B', commit, then change file B and 
> commit. Does 'git diff -M HEAD^^..' detect that? From what I see now, 
> it will show 'B' as new (all of it with '+' prefix in the output). Am 
> I right?
>
> Thank you,
> Ittay
>

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
