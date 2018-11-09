Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94A01F453
	for <e@80x24.org>; Fri,  9 Nov 2018 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeKIWGl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 17:06:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:44479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeKIWGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 17:06:41 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoVja-1ft9uG3Pkg-00gcMw; Fri, 09
 Nov 2018 13:26:14 +0100
Date:   Fri, 9 Nov 2018 13:26:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 18/20] stash: convert `stash--helper.c` into
 `stash.c`
In-Reply-To: <4de1b725-8687-590a-f93f-e80843e5bf8f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811091324210.39@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <82f5af08c6475765fac27e30f716a48039d56404.1535665109.git.ungureanupaulsebastian@gmail.com> <nycvar.QRO.7.76.6.1809031640490.71@tvgsbejvaqbjf.bet>
 <4de1b725-8687-590a-f93f-e80843e5bf8f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tssuBHeS5JX9HpbUUPrIyu1ZxqAhkdNL7XlQRDccebu6zeWgiL2
 Sx9V6AxfugvOvl9+JRs++Zb9UfWezgHb6Mfft/XVEECZ5xDlttX9+A0gK7Hc/+GEjbsniZq
 8+HcDgueTniR/GYwZ5IKnOsjGXgoxj9dRTu1GWRhB2UPPfRt04Rz/+my0VaXpda5a1me6uE
 kEW89HY6c60g7S+vGbTng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6G48ByXmC3A=:fceSCTu9vLwOgheIvIjSOb
 2pQf89r5MfrrcMJi/QysZKUGPwTXhTkiqV/ORr6jY6gYgszgRWW5o+uihFTK8+8YpRCRnrV7F
 rFfzM0TWXQv925bbyEoSbrdPsfHpjF56vTUdsshq+1DKbM8/XHCkRML6f6ldRpOPmicXEn5ia
 wgWI/lAuTB04sfPObAc2DJd2RC8IWGHSuItTu77hnC1+N3r0n9AR5csijjIdWMJu0yc8bf6GE
 nhbzD4142Ut3Y7b9vBGalV856A6LAb0KlGl2ZYWIUF6A4AlZUQ+15bq+0Lria5FYZRgqW8/T4
 mGBJfWgLNN7Ye+hoKUeczMH1VLxQ+LHILQRVNLSAEO7QsmRlGJqNeMlgjF26Iu6WMdU1FMufY
 BcQC4xo9GZfFOIp0HehvQQXOZXjny2BNaPx8UMI4zeGvP/Sjb5GY5/K1rF3kRH6VYmZJF13Jl
 KJgMVZe6EnaeoK9WbRUJKCcFuVdrHSZ+UKFmDTiHa0naEWRAZlSKP5RqJ0q4MlY+8PRPAYQ6w
 oQyFzJAQPtzWeatu7218cBzx0RwDBavrikriceVb0HzgZsuRQ1opuZ1TTHjSbLhsMWsEVCniY
 vd2ubhOxSvGqflGfnU0gu5AOkfDEM9ZUaZhrIBaZOCmjh16DfSUUjVpp87BI8aZyX2Kz/gGHT
 FVS6lhWp1McPo3YcjqnAjNu4ZdUvy2iFkE7kFbabTyJdl2zcpKYHNV6InYyKzqLtjlixAUxcv
 nAiRTDCOKKuJj6RIKAaZLbkVMtKNHdFsMTv2YGn9vTV/dBW/cbfXDbYO3f2WbaMHsY8K0dBa2
 65+G4zwc26Dw2TX05HmuAmJD//Nf1M+KSRyrjWbjsZcZWrb6Q0G10ThZvpfdiYJxdK671TYJa
 c9D7jvqGVaqziTMsCKo93gT2MuxUsaiVr5UBhmD/Jq/7seGMjOnS0F2229Q7S/irr5hHB6JX8
 8Zdd7S39N0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 26 Sep 2018, Paul-Sebastian Ungureanu wrote:

> Hi,
> 
> > >   @@ -1443,9 +1448,10 @@ static int push_stash(int argc, const char
> > > **argv, const char *prefix)
> > >    	OPT_END()
> > >    };
> > >   -	argc = parse_options(argc, argv, prefix, options,
> > > -			     git_stash_helper_push_usage,
> > > -			     0);
> > > +	if (argc)
> > > +		argc = parse_options(argc, argv, prefix, options,
> > > +				     git_stash_push_usage,
> > > +				     0);
> > 
> > Is this `if (argc)` guard necessary?
> 
> Yes because without it, there would be a seg fault when
> calling `git stash`. Why?
> 
> After spawning `git stash`, in `push_stash()`: `argc` would be
> 0 (and `argv` would be `NULL`).

I *think* what you want to do, then, is to pass PARSE_OPT_KEEP_ARGV0 in
the first parse_options() call. In general, this needs to be done any time
you might want to call `parse_options()` on the remaining options.

Looking forward to v10,
Dscho

> `parse_options()` calls `parse_options_start()` which does the following:
> 
> 	ctx->argc = ctx->total = argc - 1;
> 	ctx->argv = argv + 1;
> 
> So, `ctx->argc` would be `-1`. After we are back to `parse_options()`,
> `parse_options_step()` would be called. In `parse_options_step()`:
> 
> 	for (; ctx->argc; ctx->argc--, ctx->argv++)
> 
> Which is an infinite loop, because `ctx->argc` is already -1.
> 
> This check is also done for `git notes list` (function `list()`
> inside `builtin/notes.c`). Now, that I relook at it, it seems to me
> that this is a bug. Probably a better solution would be to check at the
> beginning of `parse_options()` and return early if `argc` is less then one.
> 
> > > @@ -1536,7 +1544,44 @@ int cmd_stash__helper(int argc, const char **argv,
> > > const char *prefix)
> > >    	return !!push_stash(argc, argv, prefix);
> > >    else if (!strcmp(argv[0], "save"))
> > >   		return !!save_stash(argc, argv, prefix);
> > > +	else if (*argv[0] != '-')
> > > +		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> > > +			      git_stash_usage, options);
> > > +
> > > +	if (strcmp(argv[0], "-p")) {
> > > +		while (++i < argc && strcmp(argv[i], "--")) {
> > > +			/*
> > > +			 * `akpqu` is a string which contains all short
> > > options,
> > > +			 * except `-m` which is verified separately.
> > > +			 */
> > > +			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
> > > +			    strchr("akpqu", argv[i][1]))
> > 
> > I *think* this is missing the `n`.
> 
> I guess that by `n` you are referring to the short option of
> `--no-keep-index`, which is missing because it was also omitted
> in `stash.sh`. I am not sure whether it is worth adding it. In
> case `stash` will learn any other option starting with `n`, this
> might create confusion amongst users.
> 
> Best regards,
> Paul
> 
