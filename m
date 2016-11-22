Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17F61FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbcKVQJW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 11:09:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:49339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbcKVQJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 11:09:21 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1c7qzU13ff-007RDz; Tue, 22
 Nov 2016 17:09:11 +0100
Date:   Tue, 22 Nov 2016 17:09:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
In-Reply-To: <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611221706470.3746@virtualbox>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>        <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de> <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N9IUZLBZ/1f3LdKRihbgOu4TvYLJSDTc5DNWPQSCzc4cFhxxUIS
 FEmMgK30WhhlbpUdelC0zc4HTBNiahzWnu8Zsdk/GaWRFboaXrbFMPDEHvkTBA82uMcrbZO
 qB82yGQziOPSf2YIbmmV4ZRb3VwY8W0X3XCKompe98eZpdxZnDcx0epSSv0r0ibr+pdDWFM
 m0FzMp6IQ/if2n8s5wgTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KmXWgJbg6/E=:9f1EzPZk3KGjowZM9ydUbn
 R/Py+9CDQqMPsDhSKSpfeI0M7dzp/Z0PjRWBN5Nx4rGXQzP5R0IRHvXDvdJfGHWIzQ2/73XpP
 nA9JN/GB08xDl8DbPUI8O2cSDfdrT5rCQarBc+W/9kpYV0zjKOTfAUbRs0Mp6BJ6yR4ekV1qJ
 yz0Y0v8v6QpuVjJWwZfYDDA3uaSCLMnZk+Y0jrYjtXEw8mhBNvCdfqqufZ1AcZJ1G9sb+iYZk
 827RMmznusYKJvWFuB3L2G+ddDuNxKeTClKfKOxNT2i180Eh4kENkXJCzsAQzRQqxjXPHTYvU
 VM8jcQ5a1G9JX9sdeB6RdzBx2/0Mi7p+wYZDf0g584Y0N/PWexj8WaJOe0joEfo7x3XhajjjX
 Jbrhh4jJ/PLyjo/qfvXCH76+X1yaq8w4eRxo8OJx3GXJSOXuEvchDIzSb1EWSNPewst9UsVJq
 4g1gpLx0j9EC2O9RnDOTFtoQy33zDXum+3i8pn/XdaW5sz8/L73xyNQYWLMjLSTQ/L9OVA0kh
 6LrmtbM8iTyJgIH4cen3PjmbBq1Wn7uWQ8ZwDbSXZOV/BoGvg70gqtjHv9k1eWP78yg0BaTmq
 tXBO3ra5lRfFu8rA7kN6GX2T/HHp4c8MVI1s4Lyrzdy0+UUBzLJ9A16GqvIercCF8Gwl1dw66
 cyKCUlq0aTf/OPjnmrP6w1grDNea4/EdpmrrDTqyjodCLmhxw8iStIJ+QQYf+/UxUzDVlBxDn
 FnuF19rLFPLiAL39nzR1uU7oFea1nu1KDWUAI6qkWG9vlw3bxVCGNYAV70KkQraok8pwNHh4J
 ynxUSiD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Nov 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> > index 29e91d8..202ac07 100755
> > --- a/t/t0030-stripspace.sh
> > +++ b/t/t0030-stripspace.sh
> > @@ -432,6 +432,13 @@ test_expect_success '-c with changed comment char' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_failure '-c with comment char defined in .git/config' '
> > +	test_config core.commentchar = &&
> > +	printf "= foo\n" >expect &&
> > +	printf "foo" | git stripspace -c >actual &&
> 
> We'd want "\n" on this printf to match the one before as well,

True.

> The analysis of the log message in [2/3] is wrong and needs
> updating, though.

Thanks for following up on that, and for fixing the commit message.

> > +test_expect_failure 'rebase -i respects core.commentchar=auto' '
> > +	test_config core.commentchar auto &&
> > +	write_script copy-edit-script.sh <<-\EOF &&
> > +	cp "$1" edit-script
> > +	EOF
> > +	test_set_editor "$(pwd)/copy-edit-script.sh" &&
> > +	test_when_finished "git rebase --abort || :" &&
> > +	git rebase -i HEAD^ &&
> > +	grep "^#" edit-script &&
> 
> This was added for debugging that was forgotten?

No, this was me trying to ensure that the comment character '#' *is* used.
As opposed to somehow testing any edit script that contains no commented
lines whatsoever.

But if you don't care, I won't, either.

Ciao,
Dscho
