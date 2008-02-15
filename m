From: Paul Gardiner <osronline@glidos.net>
Subject: Re: Clean up after git-filter-branch
Date: Fri, 15 Feb 2008 10:03:35 +0000
Message-ID: <47B56377.3070608@glidos.net>
References: <47B55536.1010900@glidos.net> <47B55C72.5000105@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: osronline@glidos.net, git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 11:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPxQa-0002Qq-EU
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 11:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYBOKDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 05:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756763AbYBOKDq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 05:03:46 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:51668
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752268AbYBOKDp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 05:03:45 -0500
X-Trace: 41316630/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.7
X-SBRS: None
X-RemoteIP: 62.241.163.7
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGzytEc+8aMH/2dsb2JhbACudA
X-IP-Direction: IN
Received: from blaster.systems.pipex.net ([62.241.163.7])
  by smtp.pipex.tiscali.co.uk with ESMTP; 15 Feb 2008 10:03:41 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by blaster.systems.pipex.net (Postfix) with ESMTP id 8DBB1E0000B5;
	Fri, 15 Feb 2008 10:03:36 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <47B55C72.5000105@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73950>

Adam Piatyszek wrote:
> * Paul Gardiner [15 II 2008 10:02]:
>> What's the simplest clean up command after a git-filter-branch --all
>> to remove all the branches in refs/original, so that you can do
>> another git-filter-branch?
> 
> % rm -rf refs/original        ???

:-) Great thanks. I didn't realise that all the branch specific info
were in these files. That's neat.

P.
