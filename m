Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66710C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3628121835
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAXjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:39:54 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:58177 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAXjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 19:39:54 -0400
X-Greylist: delayed 1694 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2020 19:39:53 EDT
Received: from [192.168.17.86] (helo=Twilight.zeitlins.org)
        by smtp.tt-solutions.com with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.92)
        (envelope-from <vz-git@zeitlins.org>)
        id 1jUeoi-000205-RT; Sat, 02 May 2020 01:11:36 +0200
Date:   Sat, 2 May 2020 01:11:36 +0200
From:   Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: [PATCH] fetch: allow running as different users in shared repositories
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="434950447-41-1588374696=:62356"
References: nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet <E1jHGdD-00079b-06@smtp.tt-solutions.com> <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Message-Id: <E1jUeoi-000205-RT@smtp.tt-solutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--434950447-41-1588374696=:62356
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Thu, 26 Mar 2020 15:40:47 +0100 (CET) Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

JS> On Thu, 26 Mar 2020, Vadim Zeitlin wrote:
JS> 
JS> > On Wed, 25 Mar 2020 20:04:09 +0100 Johannes Schindelin wrote:
[...]
JS> > JS> That rationale makes sense to me, as does the patch.
JS> >
JS> >  Sorry for a possibly stupid question, but what is the next thing to do
JS> > now? The instructions in Documentation/SubmittingPatches indicate that I
JS> > should wait until the "list forms consensus that [...] your patch is good",
JS> > but it's not quite clear what indicates that a consensus has been reached.
JS> > Is your comment above enough or should I wait for something else? And
JS> > if/when it has been reached, do I really I need to resend the patch to
JS> > the maintainer and cc the list as written in that document? I'm a bit
JS> > surprised by this because I don't see (most) patches being resent to this
JS> > list.
JS> 
JS> My take is that this was waiting for a review, and I provided it (*not*
JS> asking for any changes), and if there are no further reviews, the patch
JS> should make it into the `pu` branch, then `next` and eventually `master`,
JS> at which point it will be slated for the next official `.0` version.
JS> 
JS> It might make sense to ask for it to be trickled down into the `maint`
JS> branch, too, in case a `v2.26.1` is released. I would be in favor of that,
JS> but would not do the asking myself ;-)

 Hello again,

 Sorry to nag, but I'd like to return to this patch[*] because it looks
like it could have fallen through the cracks: there didn't seem to be any
more comments about it, except for Johannes' positive review, but it didn't
get mentioned in any "What's cooking" threads since then neither.

[*] https://public-inbox.org/git/20200319010321.18614-1-vz-git@zeitlins.org/


 So I'd just like to ask directly, hoping that it's not inappropriate:
Junio, do I need to do anything to get this patch accepted or am I just
being too impatient?

 Thanks in advance,
VZ
--434950447-41-1588374696=:62356
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAl6srKgACgkQBupB3k9sHoYNlACfZnQgZGfN1BRnc245I/+doDNC
Jm0AoIz7ognuBWv5R6m2IKmlRDyYjYtO
=vx55
-----END PGP SIGNATURE-----

--434950447-41-1588374696=:62356--
