From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows git bash - child processes see system PATH environment
 variable instead of user...
Date: Fri, 19 Feb 2016 12:08:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1602191154190.20796@bonsai2>
References: <CAN2vHUFYqKDDEJpGtxJ9aD+8abe-krnHBy7cm1tMm0+bh5ykBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Edward Marshall <marshallx7a@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:09:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWivw-0001og-0c
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933527AbcBSLJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:09:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:56956 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933479AbcBSLJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:09:04 -0500
Received: from bonsai2 ([89.204.137.103]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1zFf-1ZheNN3g0x-00u3Mx; Fri, 19 Feb 2016 12:09:03
 +0100
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAN2vHUFYqKDDEJpGtxJ9aD+8abe-krnHBy7cm1tMm0+bh5ykBQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:xClR3Ap8wBgNkPFwcsZCWOND9sizSis8rTmNwzYJkVVTxim4Txz
 ghkM8kYTOf1i+sw+ETOuJ5xjXZHWVwg6q4lWelrP4jDevx9pxI1t1BpToet77w3C97rqYiQ
 0G7ks+AUxRVxrmWFPx2K/hM+LDAWzYaFXVu18q56gbk2DKZHyCbWTuRcRDZzXJftrd+zj4k
 wG9YSDTMaxM2RqEcZmoDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T3jfRe8yTdk=:6TnVLAqz4QWkIm1pgFqZ2o
 S9tTQtIkVqYe1K6bfqM6zOtRzV9fjwyomz7H9ImQ5CMmUedK9XswOz5/QGt4kazjkO13nOs0N
 ne+t9jfVIYyokBfHL0AjKz0pF5hnieILjl4FbGmCfFQ6TAxxElQGLYFojvnI1kuxTvWlR5lnF
 pOHQSAYsOG5tBgz6GLRN0tUJQfXARxu/C/kryxVDLX42RtJi/ro+I7ihvQWP/GKhgNrXftXfv
 SgjPmxPmvTtwGgYcLnAxGoUi9kGM8Lk2gPUmkGchqPC3PXRWBui2zOtrTw+0/SG2FeoiF3c/g
 Go76rXt2HHbjx7zs7dwaY5nP7vMUzvGzQL5ObAUEiWtvIYH1KJPgGQ6Db1cuMejaYi3d9m1IU
 dbOqMf+22exkLmko5jGf8CUexXpqOTHegE9Mw2Nc4TJu2g03kRYABikMcePN7uPuji2EcJE/B
 mJy1IkdI2/6VEddaCzzJS8bCR+anBVRdB9TbfzasreU7pWFq9p9Q0EPPr0y+Dh+BsINFh3PWy
 n0LKQzEVoZu1I5uzJAQxmc3PjRUl5tJP6opcJbnrZcoDSmWiIZwuii6K9y2et2sAzEzewu7Ej
 Sj14daXke3Mwzhp+yqNvtmsX90JGZnkpiPMMOWqBNE1IE2foPp67JtfYo+2shNxKHDfEZP+R+
 IlCtR3v6U4KO96rXSg5nxI1HWzffQAzE5jZV537kxCwpYDuXMkzX120LJDaofG/nRhUgDA1sU
 zqchVzXXmSA57H9bdkDhUP1njIEqvSSzUnCEzlPl7ocNDCQiQTNo5gT23pvv/TrvnajTcxSK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286682>

Hi Edward,

On Wed, 17 Feb 2016, Edward Marshall wrote:

> Edward@Edward-PC MINGW64 /f/Work
> $ echo $PATH
> ...(USER PATH)...

I presume this is Git for Windows 2.7.1(2), installed via the default
installer?

And I also assume that you run this in Git Bash?

Can you test whether this also happens in the PortableGit from
https://github.com/git-for-windows/git/releases/latest? (These are
self-extracting .7z archives, just install them somewhere else than your
current installation, it won't touch your Start Menu or desktop icons.)

The Git Bash is available in the portable installation as git-bash.exe in
the top-leve directory.

> Edward@Edward-PC MINGW64 /f/Work
> $ cmd
> Microsoft Windows [Version 6.1.7601]
> Copyright (c) 2009 Microsoft Corporation. All rights reserved.
> 
> F:\Work>echo %PATH%
> echo %PATH%
> ...(SYSTEM PATH)...
> 
> The same is true of any child process (e.g. node.js) - they all see
> SYSTEM PATH now instead of USER PATH.

Are you sure that it is "instead of"? AFAICT both Git CMD and Git Bash
should have the full PATH, i.e. both system and user PATH concatenated.

> Running bash -l from a cmd window, has the problem.

Now, this is interesting. Maybe something funky does happen in some
strange place in the Bash profile.

If you can reproduce this with the portable Git, it would be good to
insert the line "set -x" at the top of %PORTABLEGIT%\etc\profile
(that is the correct file name IIRC, it could also be bash.bash_profile,
but I think the latter is included by the former). Then start bash -l
again, and see whether you can find the place where it sets the PATH.

To be certain, I would also recommend outputting the PATH with which Bash
starts, either by inserting a line "echo $PATH" at the top of the profile
file, or by starting bash without -l option.

> I have no .bashrc or .bash_profile files on either system (no idea
> what these are for but a colleague was trying to help diagnose the
> problem - they ultimately came up empty).

Could be a .profile, too, maybe.

> Unfortunately I don't know what version of git I had before, and older
> versions aren't offered for download so I can't trial and error.

Older versions are still available (we did not remove any) from
https://github.com/git-for-windows/git/releases (and if you look for the
1.x series that was using a completely different Bash/MSYS:
https://github.com/msysgit/msysgit/releases).

Ciao,
Johannes
