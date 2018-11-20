Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18D91F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 10:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKTV1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 16:27:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:39879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeKTV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 16:27:15 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbMb0-1fiX7g0nSU-00kxka; Tue, 20
 Nov 2018 11:58:34 +0100
Date:   Tue, 20 Nov 2018 11:58:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase: validate -C<n> and --whitespace=<mode>
 parameters early
In-Reply-To: <874lcd1bub.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet>
References: <pull.76.git.gitgitgadget@gmail.com> <pull.76.v2.git.gitgitgadget@gmail.com> <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com> <874lcd1bub.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-318642104-1542711517=:41"
X-Provags-ID: V03:K1:LvStoa/2radK7Tt4SmouxzYTdf2/0XlO/C9KNvC7QN1TGyY3CUf
 g00HnIKNBIdNVGnhKS472SKPeXuwhN9bAJHFRkiICSf52lJdzFQyiQnsOQzBuN3fFnXrrqY
 b/yAAYOgKfDO/jR4pknt2CZEEFIBDz+llh7ehBx769gByzy1z+hv6WOrRsOEKkCytYobxiH
 54SDR7zvZ7pg3+Lx9DCVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BcoHIw7KV6Q=:5GIC2cddhyA4WmBV2sz6tJ
 bG1WHaOJbLHsRJuq6CcTuA5l66aBqUGmxoTOSzRJkV5pkhdxUR5DWTOLfoLPy7tfc2MtxfVv3
 DEwX27OkPhVzCM5HSq2J0xKM9sKjXhxriFqhdWqG9AJo/iqvIBQeIy0S4LVNq08pRBfjktCNW
 Pogqj/PpXLaNWmlGqBnTrR+9vO/mDd38A9w/d9T/cixT1lyEGmH62I/XPGjD0gE89m9mdg5jY
 uWxXRku97VWPzZpZy+JMfHeiP4etmWr3ONGKNC/dat+H7M5qgyv0U8ciZ2mVG9YgU6HTy8RQz
 mmPs4c+Tk0iCOr4Y4oFGFzTWp57rv5jZ6+Ccn1x3oAUcWXUh4ENJv7+POpyed5NseYQuu7ikY
 PsFtVgYj8IMJVnQNqSagpyVMmobY/vCUolSCx4Mky6MHymHwRpxt7de1zebFuz+NuphOwsktH
 ObX5B0nKYpS9EkOvJYuxYElxndgrRLQZ1NBJ/TOBNefYt6s1i/mhGVQnryCCxa6gttm3EbDmn
 oM8bmg1lSBupIVq0aNcMm/wnZB5w8Uw9909u5mMzQ9q9YYywpU98tjMUPgLGZL6JbTu9U/cZJ
 CFboFmGEVo0KGgsqBOC0sqBWktShqJwCellr8EQcGkeav4lxRG0ULIfnF5YpCsa/3fBOKDFW8
 RjYfzaKnXTsgRyJVSH8mjvavnysyq9cFQ+N37PudBp8YZNMyzXvZLNhMctCUH12JfAvt23tS7
 IyWnGo3VIdbKwKTB/3Zam1IZLW8eh45eIalIaznRDGZuutVx17Tv8P5hDKuc9pKtGpY81DWfL
 /sMityKPRlJMFvfxhT8gAUQQIOjSgdk9YKc5eoByyRg7KINczixG9UXGf1Jjupv6FjqkXNHfg
 R12iH7kyLsSLv4EsibHQJYf+q97tSsLqCej0U4lAgO7D69NdMZahB8AgnyGzo6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-318642104-1542711517=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Mon, 19 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Nov 14 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is a good idea to error out early upon seeing, say, `-Cbad`, rather
> > than starting the rebase only to have the `--am` backend complain later.
> >
> > Let's do this.
> >
> > The only options accepting parameters which we pass through to `git am`
> > (which may, or may not, forward them to `git apply`) are `-C` and
> > `--whitespace`. The other options we pass through do not accept
> > parameters, so we do not have to validate them here.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/rebase.c          | 12 +++++++++++-
> >  t/t3406-rebase-message.sh |  7 +++++++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 96ffa80b71..571cf899d5 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1064,12 +1064,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	}
> >
> >  	for (i = 0; i < options.git_am_opts.argc; i++) {
> > -		const char *option = options.git_am_opts.argv[i];
> > +		const char *option = options.git_am_opts.argv[i], *p;
> >  		if (!strcmp(option, "--committer-date-is-author-date") ||
> >  		    !strcmp(option, "--ignore-date") ||
> >  		    !strcmp(option, "--whitespace=fix") ||
> >  		    !strcmp(option, "--whitespace=strip"))
> >  			options.flags |= REBASE_FORCE;
> > +		else if (skip_prefix(option, "-C", &p)) {
> > +			while (*p)
> > +				if (!isdigit(*(p++)))
> > +					die(_("switch `C' expects a "
> > +					      "numerical value"));
> > +		} else if (skip_prefix(option, "--whitespace=", &p)) {
> > +			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
> > +			    strcmp(p, "error") && strcmp(p, "error-all"))
> > +				die("Invalid whitespace option: '%s'", p);
> > +		}
> >  	}
> >
> >  	if (!(options.flags & REBASE_NO_QUIET))
> > diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> > index 0392e36d23..2c79eed4fe 100755
> > --- a/t/t3406-rebase-message.sh
> > +++ b/t/t3406-rebase-message.sh
> > @@ -84,4 +84,11 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
> >  	test_i18ngrep "invalid-ref" err
> >  '
> >
> > +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> > +	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> > +	test_i18ngrep "numerical value" err &&
> > +	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> > +	test_i18ngrep "Invalid whitespace option" err
> > +'
> > +
> 
> The combination of this gitster/js/rebase-am-options and my
> gitster/ab/rebase-in-c-escape-hatch breaks tests under
> GIT_TEST_REBASE_USE_BUILTIN=false for obvious reasons. The C version is
> now more strict.

Maybe you can concoct a prereq for this test? Something like

test_lazy_prereq BUILTIN_REBASE '
	test true = "${GIT_TEST_REBASE_USE_BUILTIN:-true}"
'

Ciao,
Dscho
--8323328-318642104-1542711517=:41--
