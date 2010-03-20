From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_=5BPATCH=5D_=2Emailmap=3A_Entries_for_Alex_Benn=E9e=2C_Desk?=
	=?ISO-8859-1?Q?in_Miller=2C_Vitaly_=22=5FVi=22_Shukela?=
Date: Sat, 20 Mar 2010 18:47:10 +0100
Message-ID: <fabb9a1e1003201047g5b73350ch9e7f1a2533125808@mail.gmail.com>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-1?Q?Alex_Benn=E9e?= <kernel-hacker@bennee.com>,
	Deskin Miller <deskinm@umich.edu>,
	"Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
X-From: git-owner@vger.kernel.org Sat Mar 20 18:47:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt2lu-0002wo-4d
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 18:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab0CTRrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 13:47:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64726 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0CTRra convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 13:47:30 -0400
Received: by pva4 with SMTP id 4so2082199pva.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5O4BzrgOKOCS1/UeO3TaGBZj79pdDJhuRiF7oTvI+QU=;
        b=jvNwgH35Ji/nFrVwK2xqG6mfKii5k5Daxc0vA/MIjw5V1+JCBuAEs9BH8VDHSDshJ5
         f8RAwrIf1a3ROKVSWkUAcoUABlRxLUk0jPnfH3UKbFs86PThlEUd8vlQj8kd4HzaUX7E
         G4x1ae0SE4EN0vyBaN0C2BFwP8xY56EZfdvkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y5L1jXLam40w66UsWkK0S+jbxgXB1Kvf57W0hWhFof4xXxd0pSsXeqw14vvaLsayGU
         EJV58mY21SFxY+SRujv7n9KZMlVvMGVoquEKHDeomx/IHjkebnq+W56cUlOwvFwjDYkh
         izy+XQa6akfwpzhc6zn0yeWfJbxaLOhyX/rzA=
Received: by 10.143.25.38 with SMTP id c38mr356719wfj.251.1269107250097; Sat, 
	20 Mar 2010 10:47:30 -0700 (PDT)
In-Reply-To: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142729>

Heya,

[+those who are affected by this]

On Fri, Mar 19, 2010 at 12:02, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> With the current .mailmap, git shortlog shows the following for these=
:
>
> =A0 =A011 =A0Deskin Miller
> =A0 =A0 3 =A0Vitaly \"_Vi\" Shukela
> =A0 =A0 1 =A0Alex Bennee
> =A0 =A0 1 =A0Alex Benn=E9e
> =A0 =A0 1 =A0Deskin Miler
> =A0 =A0 1 =A0Vitaly _Vi Shukela
>
> Add (e-mail based qualified) entries to .mailmap to get:
>
> =A0 =A012 =A0Deskin Miller
> =A0 =A0 4 =A0Vitaly "_Vi" Shukela
> =A0 =A0 2 =A0Alex Benn=E9e
>
> The Shukela spelling is based on the version used consistently in the=
 s-o-b
> lines of all his patches.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Sparked by the recent discussion on uuid etc. I did a few (manual) ch=
ecks.
> There seem to be 4 remaining "problematic" cases (Elrond, jidanni,
> Kirill, Twiinz) but 3 are unique, and I don't think we strictly requi=
re
> full names. Kirill may be one of several other Kirills.
>
> http://repo.or.cz/w/git/mjg.git/commit/cd13e44f33c1f6bc9ec11903c30411=
99c9c464ee
>
> (branch typo-fixes) in case of encoding problems
>
> =A0.mailmap | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 975e675..c507309 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -5,6 +5,7 @@
> =A0# same person appearing not to be so.
> =A0#
>
> +Alex Benn=E9e <kernel-hacker@bennee.com>
> =A0Alexander Gavrilov <angavrilov@gmail.com>
> =A0Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> =A0Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> @@ -15,6 +16,7 @@ Daniel Barkalow <barkalow@iabervon.org>
> =A0David D. Kilzer <ddkilzer@kilzer.net>
> =A0David K=E5gedal <davidk@lysator.liu.se>
> =A0David S. Miller <davem@davemloft.net>
> +Deskin Miller <deskinm@umich.edu>
> =A0Dirk S=FCsserott <newsletter@dirk.my1.cc>
> =A0Fredrik Kuivinen <freku045@student.liu.se>
> =A0H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
> @@ -59,6 +61,7 @@ Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freibur=
g.de>
> =A0Uwe Kleine-K=F6nig <uzeisberger@io.fsforth.de>
> =A0Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
> =A0Ville Skytt=E4 <scop@xemacs.org>
> +Vitaly "_Vi" Shukela <public_vi@tut.by>
> =A0William Pursell <bill.pursell@gmail.com>
> =A0YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> =A0anonymous <linux@horizon.com>
> --
> 1.7.0.2.358.g30511
