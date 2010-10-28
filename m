From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path not
 in the working tree.
Date: Thu, 28 Oct 2010 16:01:45 +0200
Message-ID: <AANLkTikLOU6HYzDD79eDfPnicQ8X1jTkLGAikAoy3YG-@mail.gmail.com>
References: <loom.20101028T150254-457@post.gmane.org> <AANLkTimbOZwHDez6iAN828AoiqL+EvAV92-WqvhP6ZpP@mail.gmail.com>
 <AANLkTi=QODz+Gf9hwrdu6b900CzuO-BBnF2zmLWOGFpy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: misfire@debugon.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Todd Wells <ttopwells@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 16:02:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBT3W-00012p-08
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 16:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275Ab0J1OCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 10:02:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54980 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab0J1OCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 10:02:06 -0400
Received: by qyk10 with SMTP id 10so2172885qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 07:02:06 -0700 (PDT)
Received: by 10.229.228.76 with SMTP id jd12mr4965978qcb.291.1288274525966;
 Thu, 28 Oct 2010 07:02:05 -0700 (PDT)
Received: by 10.229.80.210 with HTTP; Thu, 28 Oct 2010 07:01:45 -0700 (PDT)
In-Reply-To: <AANLkTi=QODz+Gf9hwrdu6b900CzuO-BBnF2zmLWOGFpy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160179>

Please, don't top post, it's difficult to follow a "reversed" conversat=
ion.

On Thu, Oct 28, 2010 at 3:54 PM, Todd Wells <ttopwells@gmail.com> wrote=
:
> Thanks all of you for your speedy responses.
> git log -g does indeed show my previous commits, for example:
>
> Reflog: HEAD@{0} (Todd Wells <ttopwells@gmail.com>)
> Reflog message: commit: convert mason template to use
> ProjectService.getAllGroups()
> Author: Todd Wells <ttopwells@gmail.com>
> Date: =A0 Thu Oct 28 05:54:22 2010 -0700
> =A0=A0 =A0convert mason template to use ProjectService.getAllGroups()
> commit b80ed79669c56669f05175db9eb9eba4a5fb296e
> // ...etc
>
>
> But I'm not quite sure now if I should do=A0=A0'git reset --hard your=
branch@{1}'
> or 'git reset HEAD@{0}' or something else.

HEAD@{0} =3D HEAD

so for sure it is not what you want.

You should first examine the commit history with "git log" or better wi=
th gitk:

gitk HEAD@{1}

or

gitk HEAD@{2}

and when you are sure:

git reset --hard HEAD@{n}

(Note that all local changes in the worktree will be lost).

HTH,
Santi
