From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui disagrees with git status
Date: Mon, 10 May 2010 14:39:26 -0700
Message-ID: <20100510213926.GA7156@spearce.org>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bill Winspur <bwinspur@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 23:39:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBahM-0000wD-0J
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab0EJVja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 17:39:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60042 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab0EJVj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:39:28 -0400
Received: by pxi5 with SMTP id 5so1867889pxi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:39:28 -0700 (PDT)
Received: by 10.115.101.22 with SMTP id d22mr3660324wam.136.1273527568211;
        Mon, 10 May 2010 14:39:28 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id g30sm29054312wag.16.2010.05.10.14.39.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 14:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146858>

Bill Winspur <bwinspur@gmail.com> wrote:
> #
> # Untracked files:
> #=A0=A0 (use "git add <file>..." to include in what will be committed=
)
> #
> #=A0=A0=A0 .metadata/
> bwinspur@elm:~/ca.wydv.workspaces/008-leaning-group/git-lrng-wksp$
> =3D=3D=3D=3D=3D
>=20
> which is what I expected: my project folders are tracked, and
> .metadata/ is untracked.
>=20
> - now I bring up git gui and it shows all the files under .metadata/ =
as
> unstaged changes, which conflicts with git status, and may be due to =
a
> git-gui bug

Its more a feature.

git-gui shows all untracked files, recursively expanding any
directories which contain untracked files.  git status collapses
them up.  If you don't want to track a directory, maybe you should
configure it in one of the many gitignore locations so neither git
status nor git gui shows it.

--=20
Shawn.
