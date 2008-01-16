From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: git-svn: Internal error during fetch of mono repository
Date: Wed, 16 Jan 2008 16:59:28 +0530
Message-ID: <87d4s2qa93.fsf@hariville.hurrynot.org>
References: <478DDEED.8050906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 12:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF6YR-0007RZ-C1
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 12:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbYAPLfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 06:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYAPLfG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 06:35:06 -0500
Received: from main.gmane.org ([80.91.229.2]:45975 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbYAPLfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 06:35:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JF6Xu-0008Oa-5J
	for git@vger.kernel.org; Wed, 16 Jan 2008 11:35:02 +0000
Received: from 59.92.130.177 ([59.92.130.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 11:35:02 +0000
Received: from harinath by 59.92.130.177 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 11:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.130.177
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:y3XDPJ6sHGywxbW3KbP8Ndy2SC8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70654>

Hi,

Mark Junker <mjscod@web.de> writes:

> I got an internal error during fetch of the mono repository. I attach
> both the messages produces by the git-fetch and the .git/config.
>
> My git version is 1.5.3.7. The svn version is 1.4.6.
>
> Any idea?
>
> Regards,
> Mark
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [svn-remote "svn"]
> 	url = svn://anonsvn.mono-project.com/source
> 	fetch = trunk:refs/remotes/trunk
> 	branches = branches/*:refs/remotes/*
> 	tags = tags/*:refs/remotes/tags/*
> Index mismatch: 9291cf59c6f5894845fba03df4784872b52ab75b != 5f732c31a4bb780618de031375ea6f319760cea6
> rereading ce0cc5a032fa7b1926128df5bb751bf00303e0b8
> Found possible branch point: svn://anonsvn.mono-project.com/source/trunk/debugger => svn://anonsvn.mono-project.com/source/tags/MONO_DEBUGGER_0_10, 45924
> Initializing parent: tags/MONO_DEBUGGER_0_10@45924
> Found branch parent: (tags/MONO_DEBUGGER_0_10) d8c5b5d8412e4bfe4064858a0d94258b770903dd
> Index mismatch: 5f732c31a4bb780618de031375ea6f319760cea6 != 9291cf59c6f5894845fba03df4784872b52ab75b
> rereading d8c5b5d8412e4bfe4064858a0d94258b770903dd
> Following parent with do_switch
> Internal error: Can't find a temporary directory at /opt/local/bin/git-svn line 3227

It's probably an issue with anonsvn.mono-project.com: maybe run out of
space on /tmp.  I remember someone else complaining about it on #mono
this morning.

- Hari
