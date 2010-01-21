From: Andre Loker <loker@gmx.de>
Subject: Re: Error when cloning gc'ed repository
Date: Thu, 21 Jan 2010 17:02:35 +0100
Message-ID: <hj9tr4$5vi$1@ger.gmane.org>
References: <hj6ms0$vcg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 17:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzVE-0001rQ-UI
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0AUQDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677Ab0AUQDT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:03:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:32856 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab0AUQDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:03:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXzUw-0001hm-GQ
	for git@vger.kernel.org; Thu, 21 Jan 2010 17:03:06 +0100
Received: from p5dca2137.dip0.t-ipconnect.de ([93.202.33.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:03:06 +0100
Received: from loker by p5dca2137.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:03:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5dca2137.dip0.t-ipconnect.de
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <hj6ms0$vcg$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137660>

Andre Loker wrote:
> Hi,
> 
> $ git clone git@theserver:the/repository.git
> Initialized empty Git repository in /e/Temp/dr/.git/
> remote: Counting objects: 1396, done.
> remote: Compressing objects: 100% (654/654), done.
> fatal: The remote end hung up unexpectedly
> fatal: early EOFs:  47% (657/1396)
> fatal: index-pack failed

To answer the question myself: it seems that it is a problem with 
openssh under cygwin 1.7.1. I found a similar problem here:

http://www.mail-archive.com/cygwin@cygwin.com/msg103749.html

The proposed workaround is to use plink instead of openssh. I tried it 
and so far it seems to work. It's not as nice as openssh, but at least 
it's a workaround until the issue is solved.

Kind Regards,
Andre
