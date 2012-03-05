From: Jakub Narebski <jnareb@gmail.com>
Subject: =?iso-8859-15?q?Re:_Bug:_pull_--rebase_with_=E9_in_name?=
Date: Mon, 05 Mar 2012 04:36:48 -0800 (PST)
Message-ID: <m3aa3vteat.fsf@localhost.localdomain>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
	<20120305102657.GB29061@sigill.intra.peff.net>
	<87399nqqog.fsf@thomas.inf.ethz.ch>
	<F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
	<20120305115815.GA4550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Haber?= <rene@habr.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 13:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4X9r-0007X8-TA
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 13:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946Ab2CEMgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 07:36:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44480 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756923Ab2CEMgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 07:36:50 -0500
Received: by eaaq12 with SMTP id q12so1361227eaa.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 04:36:49 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.14.207 as permitted sender) client-ip=10.213.14.207;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.14.207 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.14.207])
        by 10.213.14.207 with SMTP id h15mr2029958eba.296.1330951009441 (num_hops = 1);
        Mon, 05 Mar 2012 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=arf5G01TlAY+SfoW8tWewX5OwCuM85od3lTGnWvWrQY=;
        b=n0YPqQfg+cvy351U0NE2bwwpbOYf3wdOHiQ+Xn0avHhV6PrtzS3NWIvfoi4AKphmFA
         rBGQtXxpmfYo2mrh98rVTLHc7EHZryobkMYeoCWmdljyNxtYg7XRWjret5GY5xCm029T
         wbzLTWlYYuTA+rl/nQ1d3TQh9sjrjdfqNPupvbULHW0bRRBM079P246mfQyaIoOlt4ji
         NCHqi3zrqYe60FBrEk3W/IJ7Eu2xR321kyD1Ej8R/aZfe6922CjKJki/AKOhTinTK49Q
         YmG2Ns7lv1niSB47EQCTRGLcbchUVQEyZogrFPUV5mY8i+qz1Q5KkUOHmYYpSs/278I3
         S8Nw==
Received: by 10.213.14.207 with SMTP id h15mr1531759eba.296.1330951009299;
        Mon, 05 Mar 2012 04:36:49 -0800 (PST)
Received: from localhost.localdomain (abwg221.neoplus.adsl.tpnet.pl. [83.8.230.221])
        by mx.google.com with ESMTPS id y14sm61208795eef.10.2012.03.05.04.36.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 04:36:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q25Cai0f009780;
	Mon, 5 Mar 2012 13:36:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q25Cahj2009777;
	Mon, 5 Mar 2012 13:36:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120305115815.GA4550@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192231>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 05, 2012 at 12:42:14PM +0100, Ren=E9 Haber wrote:
>=20
> > I'm running git 1.7.9.2 from Fink Project on MacOS X 10.6.
> > The gitconfig in hex is attached.
>=20
> Hmm, looks like pretty standard utf8:
>=20
>   0000020: 6d65 203d 2052 656e c3a9 2048 6162 6572  me =3D Ren.. Habe=
r
>=20
> and the same thing I used in my tests. I tried repeating the test wit=
h
> v1.7.9.2 on OS X (although my test box is 10.7), and couldn't replica=
te
> it.
>=20
> Can you show us the commit that causes the problem, as printed by "gi=
t
> cat-file commit $commit | xxd"? I just want to double-check that ther=
e
> are no odd bytes there.
>=20
> Also, what happens if you do:
>=20
>   sh -c '
>     . /sw/lib/git-core/git-sh-setup
>      get_author_ident_from_commit $commit
>   '
>=20
> (my theory is that this is the underlying problem in the rebase, and
> should show the bug; by narrowing it down, it should make testing a l=
ot
> simpler).

Hmmm... one place where I have read about this strange "Ren=E9" -> "Ren=
e'"
conversion is when terminal (console) cannot display unicode, and tries
to show it using ASCII:

  http://stackoverflow.com/a/9430419/46058

But it should not matter if we are writing to file, isn't it?

--=20
Jakub Nar=EAbski
