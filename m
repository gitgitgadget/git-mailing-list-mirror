Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98E71F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeACFhJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:37:09 -0500
Received: from mout.web.de ([212.227.17.11]:63891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeACFhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:37:09 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVu1U-1ePufQ2azo-00X1zD; Wed, 03
 Jan 2018 06:36:56 +0100
Date:   Wed, 3 Jan 2018 06:36:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de
Subject: Re: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
Message-ID: <20180103053654.GA428@tor.lan>
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
 <20180101215959.1460-1-tboegi@web.de>
 <37D4996F-CC42-4D01-B15E-6287F1F5BF83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37D4996F-CC42-4D01-B15E-6287F1F5BF83@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:dlHgtfG1iQg4wC3uA1uJBUWx/ok0ptftdXPo0zMu+Awe8XBm2jB
 V3GHVZaazSCEzJlLQqF6owl6NquRT3JlZsa2cqLDGHOmhTzrbx/HX/+yjyst4bEM1Dc9pzB
 kFW2qznMaocVpQAYmeXc9ZvjYpoF8ylat8FIQ3l0revBtu+LNVOhDLQTSNmGuFDuy8E7yfP
 ld91WAMX3MPWUDbtmjy/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x8X9NGOQn6A=:yKAo0xOfx2wvECwVxVa4Wu
 GJyo+P0seGr1iE2Hj8aYrMw8OB4Pmtr0OiS8XoUMn2nuYcreJu1iokLK+3tUts3cKCT7q/L6w
 awv3T7wTAxk1EPvwj0wCsbzpTcG+CKoajZ2VfjCO3MerZx5KxKbh0MkfLmbMGVBmMrRmdKWxS
 ZCSdpu7YrHEilU9jc4SWiAPM21poRt/d5f3h1ns8xjGJLuCFund+4lL5egCe2LEMX5A12R1K3
 Dh+Z0euah4z4EEH8b6bXyy0h5BE9ZpcPq0biQETr3xBweoAMPgJfSwTSlQKtCVtLUzKPaygHH
 QvJtZzBd2B/AVdDBN0Z+JDa4ScT5X5CTHFRhOam6F8ybixO3koSirpB9H9FRQqUsxfZCLuNYV
 lakO8kmNuiRU4Lr596nKyizugPa+UVUoaltZcKVhLWhfrvMScnxnD2v6xY1COJnwfVRrZVzTD
 pz/VIuXA3SuZOX/p0eguZbDQ/2SXFXzz5Nc8yHZxnW7n4JFieCY82dN3LVCYb52NReMfTqGl7
 5U0y9/mo907k+IJTbTqjv7bLRtAZf3721gUjYvHhoWufTTZYp8SL+Tna1ltQ5g9SiigSGGCFA
 t+RoZ/ONVkuGFKSVBGhGU0+eL+7+wr7yMgDOIMKU8/pwB4HZJEsPK/GgPDlHFnU+HVSqRRwFY
 XXIDw7Z6rYi96ccVn6x03yfLlQz/2x3z7rsThOpnhNYilpYKbzCIhqjYDQIaZpLsrr/PkSCs0
 l7c6zzSDsoxRZI5hHAimxtpES4nzczFtrAm+Kcr10ACk/xtDRTnLm5o/vg+YAgTgx3+oREN8n
 5zr9tvvNvXtvT5wcddOvSDeKfqXEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 08:11:51PM +0100, Lars Schneider wrote:
 
[snip]

> > /*****************************************************************
> > diff --git a/diff.c b/diff.c
> > index fb22b19f09..2470af52b2 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3524,9 +3524,9 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> > 	 * demote FAIL to WARN to allow inspecting the situation
> > 	 * instead of refusing.
> > 	 */
> > -	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
> > -				    ? SAFE_CRLF_WARN
> > -				    : safe_crlf);
> > +	int conv_flags = (conv_flags_eol == CONV_EOL_RNDTRP_DIE
> > +				    ? CONV_EOL_RNDTRP_WARN
> > +				    : conv_flags_eol);
> 
> If there is garbage in conv_flags_eol then we would not demote the DIE
> flag here.
> 
> How about something like that:
> int conv_flags = conv_flags_eol & ~CONV_EOL_RNDTRP_DIE;

The next version will probably look like this:

int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
{
	int size_only = flags & CHECK_SIZE_ONLY;
	int err = 0;
	int conv_flags = conv_flags_eol;
	/*
	 * demote FAIL to WARN to allow inspecting the situation
	 * instead of refusing.
	 */
	if (conv_flags & CONV_EOL_RNDTRP_DIE)
		conv_flags =CONV_EOL_RNDTRP_WARN;

> 
> ---
> 
> In general I like the patch as I think the variables are a bit easier to understand. 
> One thing I stumbled over while reading the patch:
> 
> The global variable "conv_flags_eol". I think the Git coding guidelines
> have no recommendation for naming global variables. I think a "global_conv_flags_eol"
> or something would have helped me. I can also see how others might frown upon such 
> a naming scheme.

I don't have a problem with "global_conv_flags_eol".
Thank for the comments, let's wait for more comments before I send out V4.
