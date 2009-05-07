From: Wincent Colaiuta <win@wincent.com>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 8 May 2009 01:18:32 +0200
Message-ID: <FC9BF880-D69F-4A56-B9FA-EF5BDBF73437@wincent.com>
References: <86prekfv7z.fsf@blue.stonehenge.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri May 08 01:18:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2CrU-0000wO-OW
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbZEGXSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 19:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZEGXSh
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:18:37 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43707 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZEGXSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 19:18:36 -0400
Received: from cuzco.lan (92.pool85-53-13.dynamic.orange.es [85.53.13.92])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n47NIXwk024128
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 7 May 2009 19:18:35 -0400
In-Reply-To: <86prekfv7z.fsf@blue.stonehenge.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118537>

El 7/5/2009, a las 23:40, Randal L. Schwartz escribi=F3:

> For the past few years, within any given 12 hour period, at least
> one person on #git would come up with the use case with which I'm
> really familiar (having needed it many times myself):
>
>  I have a workdir tracking a remote.
>  I may or may not have made local edits... I can't remember.
>  I may or may not have made local commits... I can't remember.
>  But the upstream might now have changed... please update me *safely*=
=2E
>
> Seriously, this comes up, a lot.  Typically, from a cron job updater,
> but often just "what can I do to make sure I'm up to date".
>
> So, what I need is a command, likely an option to "git merge" that =20
> says "do
> everything that a git merge would do except abort if it would have =20
> been a
> merge commit".  In other words, abort if the workdir is dirty or is =20
> not a
> fast-forward update to the upstream.  Bonus if it exits non-zero if
> something went wrong.
>
> Please don't tell me "use these three commands in this script".
> I want a *command* I can tell people in #git.

"git status"?

# On branch master
# Your branch is ahead of 'origin/master' by 46 commits.
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working =20
directory)
#
#       modified:   foo
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       bar
