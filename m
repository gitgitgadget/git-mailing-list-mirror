From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories?
Date: Sun, 01 Jan 2006 15:42:36 -0500
Message-ID: <43B83EBC.9070905@didntduck.org>
References: <20060101200121.GA20633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 01 21:41:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtA1b-0004G6-3R
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 21:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWAAUlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 15:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAAUlg
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 15:41:36 -0500
Received: from quark.didntduck.org ([69.55.226.66]:41948 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932250AbWAAUlf
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 15:41:35 -0500
Received: from [192.168.1.2] (66-227-170-68.dhcp.aldl.mi.charter.com [66.227.170.68])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id k01KfTS12944;
	Sun, 1 Jan 2006 15:41:29 -0500
User-Agent: Mail/News 1.5 (X11/20051129)
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060101200121.GA20633@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14129>

Olaf Hering wrote:
> How do I get a list of commits in the 'powerpc' tree, which are not part
> of the 'linux-2.6' tree? The git tutorial has a section 'Working with
> Others', but the examples dont work for me. Probably because
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git has
> no info that it is not the "mainline tree".
> All I need is a list of individual commits in that tree, which are not
> (yet) in "mainline". I could get them also from the ozlabs mailing
> lists, for the few patches I need. But it would be better if there is
> some sort of automated way to extract a list of differences between two
> trees.
> 

Pull the powerpc tree into your local repo, then do something like:
git-whatchanged master..powerpc
or
gitk master..powerpc

--
				Brian Gerst
