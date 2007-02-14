From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: /etc/gitconfig
Date: Wed, 14 Feb 2007 11:30:09 +0100
Message-ID: <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
References: <200702140909.28369.andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 11:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHHN5-0002jA-Nn
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 11:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbXBNK2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 05:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXBNK2I
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 05:28:08 -0500
Received: from main.gmane.org ([80.91.229.2]:32824 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbXBNK2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 05:28:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHHMi-0000VK-VP
	for git@vger.kernel.org; Wed, 14 Feb 2007 11:27:57 +0100
Received: from p54aa85ed.dip0.t-ipconnect.de ([84.170.133.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 11:27:56 +0100
Received: from siprbaum by p54aa85ed.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 11:27:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aa85ed.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39630>

Andy Parkins <andyparkins@gmail.com> schrieb:
> Hello
>
> With the release of 1.5.0 I added legacyheaders=false and 
> usedelatbaseoffset=true to my repositories.
>
> While doing that though, it felt wrong to be editing every single config.  Is 
> there a justification for having three config files?
>
>  /etc/gitconfig
>  $HOME/.gitconfig
>  $GIT_DIR/config
>
> With /etc/gitconfig coming in at lowest priority?
>
> Andy

I would like this, too. This would allow me to set e.g.
"diff.color = auto" for everyone one a machine. We use git there to only
manage some config files and several simple perl scripts. As it is
mostly myself who does the editing, ~/.gitconfig works for *ME*.

But I'd like to set this globally so that my colluagues which don't have
much clue about git don't need to bother about config settings. And yes,
editing every single repo doesn't seem like an elegant solution. 

-Peter
