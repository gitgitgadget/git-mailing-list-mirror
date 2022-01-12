Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA82C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 15:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354507AbiALPRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:17:25 -0500
Received: from mout.web.de ([217.72.192.78]:40565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354499AbiALPRP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 10:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642000618;
        bh=MZCKh8rSOtoz4Fhtpw3LRf6uz1Qy6KcPQ24DtUtppNg=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=VNDUCx8zND8VXs/63u440YubeXxE9AuuGztiVq7h+Bbnh9F5c4Cv2PlyZrqX6sTTI
         2nTe+fl5efhNVohR21xmMTlK3VYkiMzXPP1kmUwTaDGSwyNXfUkePsQKZtRWviC21z
         xqOrEgsudbq3xVTnY1rEwmhcLTLeueu+NH/LNGno=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvrs-1myDQ82HoI-00RLaw; Wed, 12
 Jan 2022 16:16:58 +0100
Date:   Wed, 12 Jan 2022 16:16:57 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] docs: correct documentation about eol attribute
Message-ID: <20220112151657.4yy7q6pk54v4w2eh@tb-raspi4>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220111021507.531736-3-sandals@crustytoothpaste.net>
 <20220111183003.g4fch5d2f47it2hg@tb-raspi4>
 <Yd4Hb/bxvJZkJP7P@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4Hb/bxvJZkJP7P@camp.crustytoothpaste.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:kNedG9ZiMVffkKCEsQHUMXluKd3PQp1QOw9+6W5+uPz7hpmktV2
 ojvUObNfGU0XlL/1Zvk8N22kGOmAWmSOaDyodzxcIDVxGcHFiOLAnc2hP+HMMJjKwzX3wLj
 hSjzPoP5MiuYwsBakpEyoth3AFfYX9TA+H2njT3r0jeLVshpS0Ftu9cV5zM6KSMYp0jijJ5
 fyMabpKRShBMr2f6e0F8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ued+a8Mdz5Y=:oFhUHmFClzOVnaDw4cJ+9L
 zGHfsdfmSdO5Et6ChUQ+uh7NHlGopnudzix0Tn8/nvo/d1K3tH79ak4km+q6OfNqVkwACzgqE
 YjWWQbZofav5SLacO+KQSFyiCvKr+b2IyhNRGxz8K9w1W9Tv2TzLOxj2WYSwSBbswrQSzNN/b
 ePlshaxbx36eeT5mNiQuyA603MVyt+hr1ncJlG2aviozjkmdfrAOcJcqp8WGNuIlMiFP9BfwR
 T17lCW96cCoZBZLNmw9U6orBGTZiHTBB4eynSZphjfYKowOPPdR1JljrWx4vkHT22vMa42ynX
 SkOHL5WqqRvYvB7AJzkVh2qG0OcW7yMAhomAWfSkQyN1ELCrENk88zY9feXXGQPUG4a6SzRht
 Tpl/Xzt6t40XEDv2L8iaTQlHmsPTuM2KrQzg+k56lrEF9ztlvcSicBDJN4Yrt/lJvu+RMrUdt
 kBYBkOxVfJlSNY8bGtWxK8NGkK4QnAlh3fjSNynBZ28VeuEW3YoL6KHnAQ1QpvhEyemVNkJ1C
 Ss/sWlmMIlgGULMx6ioEw9ivH3kLu4dVDp+aMox9dub55xOL/mHqfREupgeR0ggy7xEnBOxoZ
 T88VqhoEOLedDjzW1wSC+660lo6l39OrE2TVHCTeRqTPIhgFf1eV+OfYeK042/8f0Bq651sZe
 NItvVAyXfEkLcJ09UCX+5VHBs6na5dQ+9ugEJUsZx2Dw1W1BzWSNvVF+6khQIvH6vKJdwSO21
 KByLMrD82+O7EmwhJULr6Vw+bWPpaAie2Kaqq41WJBphpJ/RdFCxXH7kpNd2XoqkVTMJ0EhnZ
 m5ZB+I2JkQ6Fj3a/dFwaw/U0yDuqzfBk10apUG8Ysb2p1P0Snb5guAregvzmQDiRKDWTNeR9+
 UXsHLwoiXlEYqm6fcFhspWkbijaNhq0TQ8V4iBxGlO5eo637VLGkYEdrN+X8bzusHp341r9ts
 uyweYoigRTi42qrhqCezGHddPqXfxoovv5s4N3AO4sIMrIRSOuIAPknhrgXmmCKxmKNbnj2lg
 lkKBAv6thm76liatyryNdmIx3Ow2Dy9WwPBW1SOHHfHIjsJFgT06hF6j0EVJC5u6jiRg0LNrH
 iQngKT8rK81dQY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 10:40:47PM +0000, brian m. carlson wrote:
> On 2022-01-11 at 18:30:03, Torsten B??gershausen wrote:
> > Hej Brian,
> > thanks for digging into this.
> >
> > Could you be so kind to send the stackoverflow issue ?
> > (You can send it to me only)
>
> I'll just post it here publicly, since I think there's value to folks
> seeing what questions users have:

Thanks - Please see the comments inline, as usual.

>
> https://stackoverflow.com/questions/70633469/what-is-the-difference-betw=
een-text-auto-and-text-auto-eol-lf/70636508?

To pick up the question here:

  I was reading about the .gitattributes file and the rule to force line e=
ndings
  in some tutorials it's written like
  * text=3Dauto
  and in some others, it's like
  * text=3Dauto eol=3Dlf
  at the first line of the file.

  Are there any differences? what does the first one exactly do? Does it e=
ven force any line endings?
[]

Yes, there are differences.
The line
* text=3Dauto
will make sure that all by-Git-as-text-files-detected files
will be commited with LF into the repo.
CRLF in the working tree will become LF in the repo.

When the files are checkout, the line endings depend on local
git config settings:
core.autocrlf=3Dtrue will give CRLF
core.autocrlf=3Dinput will give LF
When core.autocrlf is false (or unset) git looks at core.eol:
core.eol=3Dcrlf gives CRLF
core.eol=3Dlf gives LF
core.eol unset (or native) will use the the native line endings,
CRLF on Windows, LF everywhere else.
=2D-------------
Let's look at
* text=3Dauto eol=3Dlf

Here Git does not look at any local config variables.
All files will be checkout out with LF, even on Windows.

>
> > On Tue, Jan 11, 2022 at 02:15:07AM +0000, brian m. carlson wrote:
> > >  Note that setting this attribute on paths which
> > > +are in the index with CRLF line endings may make the paths to be
> > > +considered dirty. Adding the path to the index again will normalize=
 the
> > > +line endings in the index.
> >
> > I think that this can be loosened as well. And, beside this, the "dirt=
y"
> > warning about setting attributes could be written as part of the "text=
"
> > attribute as well. I dunno. Here is a possible suggestion:
> >
> >
> >   Note that setting this attribute on paths which are in the index wit=
h CRLF
> >   line endings may make the paths to be considered dirty - unless "tex=
t=3Dauto"
> >   is set. `git ls-files --eol` can be used to check the "line ending s=
tatus".
> >   Adding the path to the index again will normalize the line endings i=
n the index.
>
> I'm not sure that's correct, though.  The problem is if the file is
> detected as text, which it might well be if text=3Dauto is set.  Or am I
> not understanding something correctly?

Which problem are we talking about ?
Files that once had been commited with CRLF into the repo are
now considered dirty?
The "new safer autocrlf-handling" will not try to normalize them
when text=3Dauto is specified.
They keep their existing line endings at checkout or checkin.

I hope this makes sense ?

