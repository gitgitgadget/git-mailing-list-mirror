Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B3C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A506135C
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFJWIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:08:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhFJWIn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jun 2021 18:08:43 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5A2260400;
        Thu, 10 Jun 2021 22:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623362775;
        bh=HdV+V7KWgp2U/L4xMowGnpMW1Ee+qA/8ZcY71DMtQbQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jMcBrqxIaBq8LQOYBSCX+EbWHnDcGzEsmvquYB29eIhwVbRUNR7ToIOARnrTpGEm3
         kzb7yOCTeeyJoCg4WEis5Y4E8+A1CHMRw/pFbK4TjHj+ukmsCaHqXAs1gQtjAiDucJ
         Iwno7dAr0qAmuGE2dJHD7Jx7CpCtX/JAlckZBYrTfrvAxbz5S1ElyF1K3vnHo+RQjb
         0fSoRfqxIqQASCQ+T6FsASzc5eVGZNnANBuIs8Afbg6wUnPdTr39XbQtexErv3asmM
         8wx9o8zu9pr421L2GOoH5WdCTg6FZiKsPbpfpm4/0UIrbp67mRgZ0slF7EtNuU/oVH
         Y/xaZGpcXoY70CFXr/0xpmF1+EwAc0iDvR1YSD37Z37Kq3yg8tubv3X/JuCIwMGvAK
         6TsO3n6oIjXRJyhUKvVSUfRjuFneERzLcFr2Wh7/VzNhFjEE5ONBo/0mHgV+fG14TB
         yi99YmyaFKvM7sCNCX5x/lh8sXq1P7DkJQzgNZevNwSilnA+6ZQ
Date:   Thu, 10 Jun 2021 22:06:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Message-ID: <YMKM0lVYjblbkK/I@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL8X7PepIggpKlSl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTgKnL0dKPCzIVKe"
Content-Disposition: inline
In-Reply-To: <YL8X7PepIggpKlSl@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hTgKnL0dKPCzIVKe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-08 at 07:10:36, Jeff King wrote:
> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget=
 wrote:
>=20
> > If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> > pronouns, then we can avoid this congitive load on the reader.
> >=20
> > Using singular "they" is also incredibly efficient. Choosing a gendered
> > pronoun is usually arbitrary between "he" or "she". Using constructs
> > such as "he or she", "s/he", or "(s)he" are more complicated than
> > singular "they".
>=20
> In general, I do like the efficiency and readability of singular "they".
> As a native speaker, I have no problem reading it, and I have little
> sense that most of my native-speaker acquaintances would, either.

I agree.  I'm very much in favor of singular "they".

> I _do_ worry that it would be jarring or difficult to read for
> non-native speakers (or perhaps native speakers who aren't in my circle
> of acquaintances). There have been a few comments to that effect on the
> list, but it's hard to consider that data and not anecdotes.

I have heard these arguments, and as a someone who speaks two other
languages, I'm sympathetic to the argument that this is a little tricky.
For me, personally, I liken it to the French "on" (one), which can be
used in many, but not all, places that "nous" (we) is used, to reflect
the first-person plural, but with some slightly different shades of
meaning.  This is a tricky part of the language and it's a hard one to
get right, but it's also extremely commonly used, so it's nearly
obligatory to be comfortable with it in order to be reasonably
conversant in French.

Similarly, singular "they" is extremely common in informal written
English (e.g., texts and tweets) and nearly ubiquitous in spoken
English, where people use it routinely without thinking[0].  So while I am
in favor of making things easier for non-native speakers, this is so
common in actual usage that it's practically unavoidable and it's a
feature of the language that almost every speaker will be exposed to and
they will need to be comfortable with it to function effectively.

Given this context, I'm comfortable with adopting this change.

> One thing that gives me some comfort is your research here:
>=20
> > Perhaps due to similar reasons, official style guides have changed their
> > stance on singuler "they" in recent years. For example, the APA style
> > guide changed their official recommendation in 2019 [1]. The MLA
> > handbook also references helpful ways to use singular "they" [2]. While
> > not fully endorsing it, the Chicago Manual of Style has removed its
> > blanket ban on singular "they" [3] (the previous recommendation was to
> > only use "it" as a singular non-gendered pronoun).
> >=20
> > [1] https://apastyle.apa.org/blog/singular-they
> > [2] https://style.mla.org/using-singular-they/
> > [3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun=
-they
>=20
> I don't know to what degree those style guidelines take into account
> non-native speakers. But they at least provide a sense that this style
> is in wide-ish use. And probably growing use, as well, considering that
> they have changed recently. So even if it may be surprising to some
> readers at first, I hope it may become less so as time goes on and
> projects (like ours) make it more commonplace.

I agree that this is becoming more common, not less, and that it is
gaining acceptance by many authorities.

> So I think this is a reasonable style suggestion to put in our
> guidelines.

I agree with this as well.

[0] I have noticed this to be true of non-native but fluent colleagues,
for example.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--hTgKnL0dKPCzIVKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMKM0QAKCRB8DEliiIei
gaa/AQClulP6nOxpO2tHoyNkStncmGwlgbXt5jMcRdvYEioAVgEA80k50hZ0Ed9i
f552hCesHmI3YKQyhxmPe6rJUREk6A0=
=oyHX
-----END PGP SIGNATURE-----

--hTgKnL0dKPCzIVKe--
