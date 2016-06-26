Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B9F1FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 06:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbcFZGtx (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 02:49:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:65399 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbcFZGtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 02:49:52 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M4Gup-1bXtyu0GAN-00rlV4; Sun, 26 Jun 2016 08:49:43
 +0200
Date:	Sun, 26 Jun 2016 08:49:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/10] format-patch: explicitly switch off color when
 writing to files
In-Reply-To: <xmqq1t3mfdpy.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606260847590.12947@virtualbox>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de> <c0fdb78fbb7b19e4b367c50a9c0c570193e98fa3.1466607667.git.johannes.schindelin@gmx.de> <xmqq1t3mfdpy.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u0KkG23DI8x6KKGJ9y09b1i54Ww4wUkf6iFvzrqbh2Z6aNYUUma
 6Yj2ql+CzcRAAJ5BxgP6oCUM+1K7MieLPJJowNvpk96/cqwsplMxpwHpHzS6xfWyzlrOj+Z
 DMViJpMndByORdGijWcZDN83nI1mV7iYiEtX2lkGqJEypqv6wLCELw/jR1kwyREIB17khIs
 n+WKOn+0h9PXnxEPwXabg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:v4+unuvhTVM=:UoK26LFGCxCpri7+kIIp8q
 XJbf8ykEavQ0h5uujK5MIutzpqoxY/NORAlBjj3u0NqGDGQIBWuvxqsugH910CWAZP/xCPoni
 zdNon7n5MDRiotD1yNW2UhbealrMhrw/2cLIZMneP9JpD+3bCHTQfyJT22zeQY4kW6KzKEYCT
 UXvOrNYx9RQ03JqWp+GoPBI3BAEoPFcn5LkOSxCpdhwoldQC7uhoAzOk3sgzvCJ2fsWYI/E99
 bPGf46aNpC5luww94wSQnM7tJ+c2fbvOnAsqVmE6b7G+3SK+S9+bkGlp3+vHX05Z3J50ABUDz
 BFIvXYIDuo/EPsEF4q1Geqp0ZViFceVZMlz3bgA7Lg7rSKRNBDjC1SPDfoFk7OTylKuU85Fex
 SKenNIhHqBAQdBKG5ZQys5Nn/3zYPik5EEFHKcGsZ8IiUvs0Z19ps+pwuHGHkMrMt7c5DbAMU
 HgRbgsJalPE6CkyFUHo9Eoh6RCNbk0EVgq8BSiNRY8+/mfE3zyhF1d8REytviE7IXHoEreByh
 zYIU9n5r4DYkCwgEUkOy4Tr3n12R93Avhvj5pnZvfnY4Kaq3V+ebIPVLgke28awogNh2c3avV
 JGHp9DgrHypSTk8CredGHQ6Eb0f9yn6WThaspTNAchWmb1GonsgeYqXDmUJ7zCqxX1zbw0BFg
 g87MxpWDD47TPKWODLJZChO6gdse/Sf63fv9/SzzlSLRC4S+IzATDG40x4LkEsrQR6N82troJ
 4Jz0RbyR6SEVbT38CWS30T1IH59fjhZuFcvBssUJ44ASIiv1Q/u7svEgHx49eW9M/NTHLo/Cf
 peCBqWk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 24 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We rely on the auto-detection ("is stdout a terminal?") to determine
> > whether to use color in the output of format-patch or not. That
> > happens to work because we freopen() stdout when redirecting the
> > output to files.
> >
> > However, we are about to fix that work-around, in which case the
> > auto-detection has no chance to guess whether to use color or not.
> >
> > But then, we do not need to guess to begin with. As argued in the
> > commit message of 7787570c (format-patch: ignore ui.color,
> > 2011-09-13), we do not allow the ui.color setting to affect
> > format-patch's output. The only time, therefore, that we allow color
> > sequences to be written to the output files is when the user specified
> > the --color command-line option explicitly.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> The right fix in the longer term (long after this series lands, that
> is) is probably to update the world view that the codepath from
> want_color_auto() to check_auto_color() has always held.  In their
> world view, when they are asked to make --color=auto decision, the
> output always goes the standard output, and that is why they
> hardcode isatty(1) to decide.  The existing freopen() was a part of
> that world view.

I agree, and I briefly looked into this. It looks a bit more involved than
I am prepared for, what with my real goal being the rebase--helper, not
clean-ups ;-)

> We'd need a workaround like this patch if we want to leave the
> want_color_auto() as-is, and as a workaround I think this is the
> least invasive one, so let's queue it as-is.

Thanks!
Dscho
