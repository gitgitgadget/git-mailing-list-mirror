From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: [PATCH 1/2] git-svn: multiple fetch/branches/tags keys are supported
Date: Mon, 19 Dec 2011 22:42:20 -0800
Message-ID: <CA+7g9JyJC77ETez-wrOPRPxdY+0nbwohkR_vP=Tt3bjw-XhHaQ@mail.gmail.com>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
	<20111217100521.GA12610@elie.hsd1.il.comcast.net>
	<CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
	<20111220012236.GB20979@elie.hsd1.il.comcast.net>
	<20111220012350.GC20979@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 07:42:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RctPA-00086L-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 07:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1LTGmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 01:42:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40761 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab1LTGmW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 01:42:22 -0500
Received: by eaaj10 with SMTP id j10so5366349eaa.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 22:42:21 -0800 (PST)
Received: by 10.204.136.220 with SMTP id s28mr167579bkt.59.1324363340893; Mon,
 19 Dec 2011 22:42:20 -0800 (PST)
Received: by 10.204.228.204 with HTTP; Mon, 19 Dec 2011 22:42:20 -0800 (PST)
X-Originating-IP: [66.75.229.176]
In-Reply-To: <20111220012350.GC20979@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187498>

Looks good!  These doc changes will help a lot.

Thanks,
-Nathan

On Mon, Dec 19, 2011 at 5:23 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> From: Nathan Gray <n8gray@n8gray.org>
>
> "git svn" can be configured to use multiple fetch, branches, and tags
> refspecs by passing multiple --branches or --tags options at init tim=
e
> or editing the configuration file later, which can be handy when
> working with messy Subversion repositories. =A0Add a note to the
> configuration section documenting how this works.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =A0Documentation/git-svn.txt | =A0 12 ++++++++++++
> =A01 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 34ee7850..66fd60a4 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -923,6 +923,18 @@ comma-separated list of names within braces. For=
 example:
> =A0 =A0 =A0 =A0tags =3D tags/{1.0,2.0}/src:refs/remotes/tags/*
> =A0------------------------------------------------------------------=
------
>
> +Multiple fetch, branches, and tags keys are supported:
> +
> +--------------------------------------------------------------------=
----
> +[svn-remote "messy-repo"]
> + =A0 =A0 =A0 url =3D http://server.org/svn
> + =A0 =A0 =A0 fetch =3D trunk/project-a:refs/remotes/project-a/trunk
> + =A0 =A0 =A0 fetch =3D branches/demos/june-project-a-demo:refs/remot=
es/project-a/demos/june-demo
> + =A0 =A0 =A0 branches =3D branches/server/*:refs/remotes/project-a/b=
ranches/*
> + =A0 =A0 =A0 branches =3D branches/demos/2011/*:refs/remotes/project=
-a/2011-demos/*
> + =A0 =A0 =A0 tags =3D tags/server/*:refs/remotes/project-a/tags/*
> +--------------------------------------------------------------------=
----
> +
> =A0Note that git-svn keeps track of the highest revision in which a b=
ranch
> =A0or tag has appeared. If the subset of branches or tags is changed =
after
> =A0fetching, then .git/svn/.metadata must be manually edited to remov=
e (or
> --
> 1.7.8
>



--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
