From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 20:44:23 +0100
Message-ID: <20070219194423.GJ786@cip.informatik.uni-erlangen.de>
References: <20070219073526.GA26531@cip.informatik.uni-erlangen.de> <20070219081010.GC30030@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 20:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJER5-0006Oo-B4
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 20:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXBSTo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbXBSTo0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 14:44:26 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:35514 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932597AbXBSToZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 14:44:25 -0500
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id D1D033F382; Mon, 19 Feb 2007 20:44:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070219081010.GC30030@spearce.org>
User-Agent: Mutt/1.5.11-2006-07-11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40140>

Hallo Shawn,

>   $ ssh 131.188.30.59 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db
>   $ git remote add origin 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro.git
>   $ git push origin master:master
>   $ git fetch

thank you a lot. I just got home where I have internet connectivity with
my laptop and tried your tips. That was by the way exactly I was looking
for. Thank you a lot. However, I got a little problem. Here is the output:

        (thinkpad) [~/work/astro] ssh 131.188.30.59 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db
        (thinkpad) [~/work/astro] git remote add origin 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro.git
        (thinkpad) [~/work/astro] git push origin master:master
        updating 'refs/heads/master'
        from 0000000000000000000000000000000000000000
        to   7a04a7eb87797c4a5e8a6c4892d68862f202b2e2
        Generating pack...
        Done counting 30 objects.
        Deltifying 30 objects.
        100% (30/30) done
        Writing 30 objects.
        100% (30/30) done
        Total 30 (delta 7), reused 0 (delta 0)
        Unpacking 30 objects
        refs/heads/master: 0000000000000000000000000000000000000000 -> 7a04a7eb87797c4a5e8a6c4892d68862f202b2e2
        (thinkpad) [~/work/astro] git pull
        * refs/remotes/origin/master: storing branch 'master' of 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro
        commit: 7a04a7e
        Warning: No merge candidate found because value of config option
                "branch.master.merge" does not match any remote branch fetched.
        No changes.
        (thinkpad) [~/work/astro] git pull
        Warning: No merge candidate found because value of config option
                "branch.master.merge" does not match any remote branch fetched.
        No changes.

Maybe it is related to the fact that git version 1.4.4.4 is running on
faui00u (131.188.30.59).

        Thomas
