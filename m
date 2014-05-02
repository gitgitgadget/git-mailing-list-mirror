From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 14:13:25 -0500
Message-ID: <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
References: <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:24:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJ47-0006D8-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbaEBTYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 15:24:07 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:47251 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaEBTYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 15:24:06 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so5666618oag.39
        for <git@vger.kernel.org>; Fri, 02 May 2014 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=pziEGMiQP3740PLvgTJM/G+MX1UNvtltveWnLEylJ6Q=;
        b=Q+BjDKfA5sGkwBRs5nlbXxi1Uq6ppNDnpnhKpQuWBlHLM91Ph1vROS+nZ/vOow3A/V
         VYzifSZH8zmm9POhzGcnY5wiBd2jxRS5meRGbYJj2A2lNKfc3L0lDJDf0fkDH4udokY7
         rWIMUqq33NSbigMx11xEe0uXhMBF1WnqpV9wcYhP85BxOrzyheMretrYOz7w9ytC3IS+
         ywyTKakQTvOlg20MdSASyH7TbHiUrCc2hlM9GEPvKzCUYTb8EiNiK5EcJg4TfhSijBrr
         7HdZmesC70q7KRz4ahN/lDpU4+sVuF6Ei/EzomouPB9ey6ieoB/5o90dBu4eUc3EX+D0
         a01w==
X-Received: by 10.60.51.69 with SMTP id i5mr18285763oeo.17.1399058644720;
        Fri, 02 May 2014 12:24:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id vh3sm68725942obb.9.2014.05.02.12.24.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 12:24:03 -0700 (PDT)
In-Reply-To: <20140502190746.GJ28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247957>

W. Trevor King wrote:
> On Fri, May 02, 2014 at 01:55:36PM -0500, Felipe Contreras wrote:
> > W. Trevor King wrote:
> > > On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
> > > > W. Trevor King wrote:
> > > > > My proposed --prompt behavior is for folks who think =E2=80=9C=
I often run
> > > > > this command without thinking it through all the way.  I'm al=
so
> > > > > not used to reading Git's output and using 'reset --hard' wit=
h the
> > > > > reflog to reverse changes.  Instead of trusting me to only sa=
y
> > > > > what I mean or leaving me to recover from mistakes, please te=
ll me
> > > > > what's about to change and let me opt out if I've changed my
> > > > > mind.=E2=80=9D
> > > >=20
> > > > Unfortunately those folks by definition wouldn't know about the
> > > > --prompt option.
> > >=20
> > > But once such folks are identified, you just have to convince the=
m
> > > (once) to set the pull.prompt config.  That's a lot easier than
> > > convincing them (for every pull) to set the appropriate ff flag.
> >=20
> > It wouldn't matter if by the default non-fast-forward merges are
> > rejected.
>=20
> It would matter if you didn't want them making non-fast-forward merge=
s
> (e.g. for explicitly-merged topic branches).

It would matter almost exactly zero. And just as they can do pull.promo=
t
=3D true, they can do pull.mode =3D fetch-only.

--=20
=46elipe Contreras