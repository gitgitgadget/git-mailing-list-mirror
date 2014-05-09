From: William Giokas <1007380@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 9 May 2014 02:28:20 -0500
Message-ID: <20140509072820.GD9051@wst420>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
 <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Cc: felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 09:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WifER-0004DU-An
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbaEIH2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:28:31 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50595 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbaEIH2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:28:31 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so4396374oac.39
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/9xyze0oUDqOX9Pj0llzyvDo36d5rCZg43T0wHHU/8c=;
        b=MRBFSRRKqnbBl5GImkFYcfAi5z+uTeTIh7ObdMcbgw667JgGNYggtTAY6UW19tWsW8
         QzszcN3SC7SKuMcCTotdeNb6I3+LuFpbMPrwm8kOFEIDYd/gd7OBcC/mzbfsmf2jWPVW
         F6uhNtMW33/VPV9Tn+GacRrgVegK5v6rrZgjrGWmI9FyaG+2S2mRTuK1Z9ngKeqT7o5r
         PMMHOorUavviK+a53W7KAgb40CVxpjPxh3q5BoHPirVuYIPyB48iqBNNGkVt17cjMdto
         /bHh63/hZMVS3gvzVL0/ZbFhWCG4tJVZXhYMnlBoBXFsharraq8CO5qTYr1oX3MDV4bY
         pPoQ==
X-Received: by 10.182.144.161 with SMTP id sn1mr903075obb.82.1399620510789;
        Fri, 09 May 2014 00:28:30 -0700 (PDT)
Received: from localhost (cpe-173-175-117-154.satx.res.rr.com. [173.175.117.154])
        by mx.google.com with ESMTPSA id pz8sm1687912obc.11.2014.05.09.00.28.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 00:28:30 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: git@vger.kernel.org, felipe.contreras@gmail.com
Content-Disposition: inline
In-Reply-To: <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248523>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 02:18:54AM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > On Thu, May 08, 2014 at 11:36:29PM -0500, Felipe Contreras wrote:
> > > William Giokas wrote:
> > > > E401: Multi-line imports seems like something that would just be
> > > > changing one line
> > >=20
> > > Yes, and make the code very annoying.
> >=20
> > It's 1 extra line in git-remote-hg, and 4 lines in git-remote-bzr.
>=20
> Ah, it refers to the '^import *' not '^from x import'. That's fine then.

Yeah. In fact, for the mercurial stuff the `from mercurial import changegro=
up`
line should be on the same line as the other `from mercurial import ...`
line.

Thanks,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbIOUAAoJEGkCBthzzQnPhPIP/0uVwLRU6+Dr3U0CGz5vqb+T
rp+f8K4fNwS9zJkXZvUoVGI8/3lBfwqxQS6owp6qxfi34yxZTdBucYF58oSR22Fn
vmhQ2zeXirOwgYjVyiFSSozauP5e11vFzoO/uEoDNgT12MhoeKgV8nyByszgOTjn
nluaTAMVEnMlErc6Qfeo5bgvM7nmAyTAeqevpXuaEuMDKANVGIz6d1/lnafsWGLg
KwMmfa2woBVJtdbeUdYlLZlxtjAIvZCsyslDy7nl6IXkGEETYz8W2v0I6pRHThZA
F2Rsso8szA6/K9R9Q1mWsMeZvRVtJbtjvIdKTGQfyctTkXzDIZO7Hw8n7hlKHNaL
KVK/Q4S3Pk6g8fkDRXUJf8Bfwe9IdD8wVQ6xmDKUWj/ycWLBm/Y42eCdIyY357EU
rOCMxs55ZVwGIBRWYQ2SxkUcYsD/DtIZ7jVThVGgtdzNeFsugEqPkyBUXTbKVniB
/aQPj/F9yQpmKQoTb9XZrnLeF77/DtPQAerakaUvo74R/xOQUJDJ9aiEjcR9H6p3
vyroH74DG3KljsFVc/jO+1c4mc84v8lJB2dY49ZQALCiby8QjEZPTRLj8mTV+/xQ
VVcYI6xYguXEOMBs21Z2fVNOCw0ho78XjGAq+2MfM7Gzk/gU3BT9v7Yq1idFgMb8
tijVjo4WF3gKMxWMGHNa
=heqB
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
