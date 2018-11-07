Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A04D1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeKGUls (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:41:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:32779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeKGUls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:41:48 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUDXS-1ftMvq3Lbm-00QyoQ; Wed, 07
 Nov 2018 12:11:44 +0100
Date:   Wed, 7 Nov 2018 12:11:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] range-diff: add a --no-patch option to show a
 summary
In-Reply-To: <xmqqsh0dd7ql.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811071210250.39@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <20181106162413.9785-1-avarab@gmail.com> <xmqqsh0dd7ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1435426602-1541589104=:39"
X-Provags-ID: V03:K1:vTUowOFSLks0jEoyS7YsYZeMawcyG9u42DytPxvSp65iiLyNFLH
 IgRt0hboSTiC6v2QSXNgs6iNiC2jns0a5ZLdt9hN1hywWA3SBqeR+ZkY0JCV/F/VDCq+yF/
 imsgFSuswqC4TShB1HA2tro4OAc3SfPQ/oae9iXHMj+Z+7UDRkpEXl/ffoTk0nKrvB4XC73
 0f4FbT16SUx711m3LoUKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B6i+wxxgLJw=:Fo2fAt8TppACN1t6xYDBr6
 GVXN5cgMDggYj5hMveAAE2kBk+V8vsHeF+nhM9jgtu28y3Jt8Y8Vnr/YP3ZyNnlJArQv+w/7e
 /7tclveIRFCz5vkkiU8UTfmgcShZ42y8zzoHECVfT3ILW/XRVEUhxSyPMKdqMwfMtVP+kZ7uz
 FpdUHy2saDen4ZXeDQKqxj0ibHJIInHauLrYu5yib8NZh/PQIphvofDcJpZiFQlsmkND/B9xH
 oF3jowhjxXgZhPoB3/CIQf9wvZlKhTMtzFzkTg35ZdAEArT1BOtQ2eq/cSqEuipBtxeTOmcPh
 C3jucKFoTKNvi7E+tL15XaaKooh49LMj3WDwtw6KokwC6lii6PIDBznGicifURvMZHA6bP+ex
 mdwQYPR04uM7g74bWG1c6pgYf9axm8if92pu90BtS6AUJgp9nWxJC7BMLXmdOlbMoAnpE7zhF
 VTuYBukGpzGRQewy0fSGPCflF0RsioWpcNvZwKUxfY6UB9BS4MPbwYT9VglDO+a8oZMpS7/xv
 GgqM76ZejPsjGACvGUTh/osaaP4PYnahpln8CHooziMrQqiReTbP1jtNlYp28pSOAJdcAe7vk
 fwu2SR81/jTlUDFaB0rGsWrA9Qu2UAkgtXGEGdUc7MkyV9L2zunJzclDRynAll8WWBPG0illJ
 nlaYli++11wQRKrJqSRvErM7vL/3SDS6aDdG5+7dgt+56VE73Krl/smX6ituqBjdtzJjHkTpK
 AaPWUgoaKMbWGhW+Wy/NbFRPLrb+fivn8QW+lotrvdXUOhXHoglySw22LIP/brJwhIuwR6bOr
 ZinQjuTxojE6tKU6FCa6RYABueHl9gGTIXFsERJioq4aXhDb/g779ZqiSMg3ax0JB9RdwD0uA
 17kAOv27hEB/zyQT7QRaBXeHOaEKJDl1DGJ3N2I+8HEBNidWfyLb4i9U7OjNp6XdejZCjldJL
 Hh9kzx1rCrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1435426602-1541589104=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Nov 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > index f01a0be851..05d1f6b6b6 100644
> > --- a/builtin/range-diff.c
> > +++ b/builtin/range-diff.c
> > @@ -16,11 +16,14 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >  	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> >  	struct diff_options diffopt = { NULL };
> >  	int simple_color = -1;
> > +	int no_patch = 0;
> >  	struct option options[] = {
> >  		OPT_INTEGER(0, "creation-factor", &creation_factor,
> >  			    N_("Percentage by which creation is weighted")),
> >  		OPT_BOOL(0, "no-dual-color", &simple_color,
> >  			    N_("use simple diff colors")),
> > +		OPT_BOOL_F('s', "no-patch", &no_patch,
> > +			 N_("show patch output"), PARSE_OPT_NONEG),
> 
> As OPT_BOOL("patch") natively takes "--no-patch" to flip the bool
> off, an int variable "patch" that is initialized to 1 would make it
> more readable by avoiding double negation !no_patch like the one we
> see below.  I guess the reason behind the contortion you wanted to
> give the synonym --silent to it?

In light of my investigation that revealed that the original behavior
(which is still documented in the manual page of range-diff) was broken,
and I would much rather see that fixed than adding a workaround.

I would be fine with my patch being combined with the update to the manual
page and the regression test, as a v3.

Ciao,
Dscho

> 
> > @@ -92,7 +95,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >  	}
> >  
> >  	res = show_range_diff(range1.buf, range2.buf, creation_factor,
> > -			      simple_color < 1, &diffopt);
> > +			      simple_color < 1, !no_patch, &diffopt);
> 
> >  	strbuf_release(&range1);
> >  	strbuf_release(&range2);
> 
> > @@ -7,6 +7,7 @@
> >  
> >  int show_range_diff(const char *range1, const char *range2,
> >  		    int creation_factor, int dual_color,
> > +		    int patch,
> >  		    struct diff_options *diffopt);
> 
> Other than that small "Huh?", the code looks good to me.
> 
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 6aae364171..27e071650b 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -122,6 +122,26 @@ test_expect_success 'changed commit' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'changed commit -p & --patch' '
> > +	git range-diff --no-color -p topic...changed >actual &&
> > +	test_cmp expected actual &&
> > +	git range-diff --no-color --patch topic...changed >actual &&
> > +	test_cmp expected actual
> 
> This makes sure that -p and --patch produces the same output as the
> default case?  I am not sure who in the parseopt API groks the
> single letter "-p" in this case offhand.  Care to explain how?
> 
> The other side of the test to see -s/--no-patch we see below also
> makes sense.
> 
> > +test_expect_success 'changed commit -s & --no-patch' '
> > +...
> > +	cat >expected <<-EOF &&
> 
> Quote EOF to allow readers skim the contents without looking for and
> worrying about $substitutions in there, unless there are tons of
> offending code in the same script already in which case we should
> leave the clean-up outside this primary change.
> 
> 
--8323328-1435426602-1541589104=:39--
