From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn doesn't fetch anything
Date: Thu, 5 Feb 2009 04:36:38 +0100
Message-ID: <20090205033638.GD28280@atjola.homenet>
References: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Harry Vangberg <ichverstehe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 04:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUv48-0004PP-OV
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 04:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825AbZBEDgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 22:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbZBEDgr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 22:36:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:48637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757804AbZBEDgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 22:36:46 -0500
Received: (qmail invoked by alias); 05 Feb 2009 03:36:43 -0000
Received: from i577BA503.versanet.de (EHLO atjola.local) [87.123.165.3]
  by mail.gmx.net (mp057) with SMTP; 05 Feb 2009 04:36:43 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+VZORMZkGVDJsysLJyg3e0dNJ1acmpu8/J16Zw/x
	GTN32ZwJME88t+
Content-Disposition: inline
In-Reply-To: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108495>

On 2009.02.05 00:49:10 +0100, Harry Vangberg wrote:
> I've been told that it is supposed to tell me a lot about fetched
> revisions, but there's nothing. And the directory is completely empty
> except for .git - here's my config:
>=20
> $ cd plantool/
> $ cat .git/config
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D true
>         bare =3D false
>         logallrefupdates =3D true
>         ignorecase =3D true
> [svn-remote "svn"]
>         url =3D https://svn.turntool.com/svn/turntool/plantool
>         fetch =3D trunk:refs/remotes/trunk
>         branches =3D plantool/branches/*:refs/remotes/*
>         tags =3D plantool/tags/*:refs/remotes/

Hm, the branches and tags config looks weird to me. Is the path to them
really ".../turntool/plantool/plantool/branches"?

Bj=F6rn
