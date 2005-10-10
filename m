From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 23:00:08 +0200
Message-ID: <20051010210007.GJ8383MdfPADPa@greensroom.kotnet.org>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
 <7vvf0542fs.fsf@assigned-by-dhcp.cox.net> <864q7pdvcn.fsf@blue.stonehenge.com>
 <7vll113yjs.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 23:00:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4kr-0008Dx-RK
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVJJVAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVJJVAN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:00:13 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:23746 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1751235AbVJJVAL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 17:00:11 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IO5006QNX08B0@smtp16.wxs.nl> for git@vger.kernel.org; Mon,
 10 Oct 2005 23:00:08 +0200 (CEST)
Received: (qmail 2915 invoked by uid 500); Mon, 10 Oct 2005 21:00:08 +0000
In-reply-to: <7vll113yjs.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>,
 "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9935>

On Mon, Oct 10, 2005 at 01:30:15PM -0700, Junio C Hamano wrote:
> Removing from the tip of non-current branch:
> 
> $ git update-ref mybranch mybranch^
> 

I think you mean 

$ git-update-ref refs/heads/mybranch mybranch^

Which reminds me... try this:

bash-3.00$ git-init-db 
defaulting to local storage area
bash-3.00$ touch a
bash-3.00$ git-update-index --add a
bash-3.00$ git commit -m 'a'
Committing initial tree 496d6428b9cf92981dc9495211e6e1120fb6f2ba
bash-3.00$ touch b
bash-3.00$ git-update-index --add b
bash-3.00$ git commit -m 'b'
bash-3.00$ git checkout -b branch
bash-3.00$ git-update-ref master master^
bash-3.00$ git checkout master
bash-3.00$ git-status
#
# Updated but not checked in:
#   (will commit)
#
#       deleted:  b
#

(Hint: there are now two masters)

skimo
