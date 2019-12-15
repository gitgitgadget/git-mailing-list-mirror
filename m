Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E0DC2D0CB
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260342072B
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DsmF+CNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLORkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:40:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:49859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfLORkn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 12:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576431638;
        bh=mvuKtFJJo+/C9MHTYXYL3dU/kAOq5LTDjUAdS1/ImwI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DsmF+CNx8LNx+xWCBrcXqV9zddlhVxQUD7K8qOf+9vbk8bBbBshNfqbPCKefViCDQ
         AUv0eOwVF9fbDJNPna9hEOPJGK0b7HlvytNGZNb/FfC2yz/+dUgJAFDeSlH60YuIyz
         SRO8hVRpwE/v2SERdmrkzw4eSITUE+iowyvMDYxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1huEdi0oG8-00mfLn; Sun, 15
 Dec 2019 18:40:38 +0100
Date:   Sun, 15 Dec 2019 18:40:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/9] bugreport: collect list of populated hooks
In-Reply-To: <20191211205114.GD107889@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912151839280.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-6-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1910281522200.46@tvgsbejvaqbjf.bet> <20191211205114.GD107889@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RRe7+OCVz+G5YAsL5mqgWUGaBbnmu3IgrugjjxElxh9H7IYo29L
 K1oJbnc1o9BNyUQNagN59mwOzYmDcfbwqT6SmnwL6ATXXwV/a1A9f0PA99hjXmpSKaO7nmU
 saDN4BzI1OVJXQ3o1DmSIpRlzncBBZVjL7To+01EqWRBIMZLkAZONesTzOJzAxbpCXDxkLM
 7G4MryLfXDbH64h9KkEkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7e+5EuUE4U=:zzWDLoMfKj/eSEZooBo+MQ
 Bb/IDCttxiCmbQceHJgFlM6tbDGXpYip0eFOlehRYDNNDaqhSBVecrmXk88MXAg2uw0FvgCVU
 +a2o0t2xKfsDnwlmd/pKjvbw9RKMmh8RiUmqH82L6Rn4+H1KVSVrumx0mggaa1htXSdtiA1og
 O6eRrDRwb2NCPdsjbwqFKzb7h3oxrUFpKjMuVZ0HrKJRHML3usUYXt4Ifmaltft5/mz+KFyCS
 Yuy8n1SSLl4ezSUBF/fciHezYWJTKRWWfO+YFWcULZljI7O/QrgCpsVM6RyMZne4o1hM0xs+y
 G7kiPs6yel8aTXpt7gHJcvTi59ke2LWRxorNwOaZtUEEewPVA6A9ZkkgT4981AV2ZYjImpAjb
 6RBibhbRrUcWTXddK5CZzdkAQY9kRQbOM+NvTtcFCKljIcmag/3gRkXAx6q1c+K8wc7NQI1JJ
 2S4jF+FCcCZPdBAh/AE5ch5VLJBtgG+W82LiHwU/y+cjmnCbJd7xE3D3MglhS6ehaetCNXM4t
 1usK9Ok+rB2EvXj9YHdsOyTaMN1J1KGtlns4/4EQ2yQIKeOUs6tjYkSnlLX8a7ewuttWoOaPD
 sbS6z7bIbygdxFzA3WmNWW/wpyIS+ngF2uSzgCKg5NsgMrK2XCWp76BUURCBmgVVse5C5hd0v
 FR7IvDYcBB199TciTQmfPe5BaoJNoOUQL5jI5684MC227GT7s3u/79ns5Ewi40PbH46oF7OpL
 alrPQINP3K6soB/0iCisfZ9zudchmxZmxQNE2BeqzPUESoccsKPT10oDx6XggKS7wpP01VySz
 wKLb/txSE1BlsLWU9K/LTta2UGnJ8cDlTki0bIB15g34IHqMFUMmXediFQEHzPk/QuoZxvFMo
 pSZ+a86MA/YQuM9tkO4xF9WBK21W13Nc9o5GHwoHg0Kl0R+MxPCUd7gI+5ruxEe8rUQNGr1B2
 IUSuvLg9ktpHY4JiIwSqdIW2Up9tLlBJlqdy8ta4zleRyRhFCAicmaWSqoNa17orOiO3o2QZk
 2McmX32mnVO8Iy2B1HXpGeETcR4dIAPAHkPuaPf9A2VxujntnyqIADcoKp2fHfLYoDu4CvPNj
 VJ5HO20EviIYEVFgkKKK4GhaSi4OmqGyaQipwx1fAdnexAYAY/Bu6mI8kDYgPS4ytgZX33L3R
 adX57v7EtdPy1d2jLT2ioe/2ay/FyjaWnF4mgYuOY4S5OYx71pdifOdNjb1/A7njGUCRSpmC0
 zwtOz1efKU6FSSTwtUvo4ASr5ZW8OQfWlxObcG5iMOL+Qjmdz4gkSXXoQoFc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 11 Dec 2019, Emily Shaffer wrote:

> On Mon, Oct 28, 2019 at 03:31:36PM +0100, Johannes Schindelin wrote:
>
> > On Thu, 24 Oct 2019, Emily Shaffer wrote:
> >
> > > diff --git a/bugreport.c b/bugreport.c
> > > index afa4836ab1..9d7f44ff28 100644
> > > --- a/bugreport.c
> > > +++ b/bugreport.c
> > > @@ -103,3 +103,47 @@ void get_whitelisted_config(struct strbuf *conf=
ig_info)
> > >  	strbuf_reset(config_info);
> > >  	strbuf_addbuf(config_info, &configs_and_values);
> > >  }
> > > +
> > > +void get_populated_hooks(struct strbuf *hook_info)
> > > +{
> > > +	/*
> > > +	 * Doesn't look like there is a list of all possible hooks; so bel=
ow is
> > > +	 * a transcription of `git help hook`.
> > > +	 */
> > > +	const char *hooks =3D "applypatch-msg,"
> > > +			    "pre-applypatch,"
> > > +			    "post-applypatch,"
> > > +			    "pre-commit,"
> > > +			    "pre-merge-commit,"
> > > +			    "prepare-commit-msg,"
> > > +			    "commit-msg,"
> > > +			    "post-commit,"
> > > +			    "pre-rebase,"
> > > +			    "post-checkout,"
> > > +			    "post-merge,"
> > > +			    "pre-push,"
> > > +			    "pre-receive,"
> > > +			    "update,"
> > > +			    "post-receive,"
> > > +			    "post-update,"
> > > +			    "push-to-checkout,"
> > > +			    "pre-auto-gc,"
> > > +			    "post-rewrite,"
> > > +			    "sendemail-validate,"
> > > +			    "fsmonitor-watchman,"
> > > +			    "p4-pre-submit,"
> > > +			    "post-index-changex";
> >
> > Well, this is disappointing: I tried to come up with a scripted way to
> > extract the commit names from our source code, and I failed! This is
> > where I gave up:
> >
> > 	git grep run_hook |
> > 	sed -n 's/.*run_hook[^(]*([^,]*, *\([^,]*\).*/\1/p' |
> > 	sed -e '/^name$/d' -e '/^const char \*name$/d' \
> > 		-e 's/push_to_checkout_hook/"push-to-checkout"/' |
> > 	sort |
> > 	uniq
> >
> > This prints only the following hook names:
> >
> > 	"applypatch-msg"
> > 	"post-applypatch"
> > 	"post-checkout"
> > 	"post-index-change"
> > 	"post-merge"
> > 	"pre-applypatch"
> > 	"pre-auto-gc"
> > 	"pre-rebase"
> > 	"prepare-commit-msg"
> > 	"push-to-checkout"
> >
> > But at least it was easy to script the extracting from the
> > Documentation:
> >
> > 	sed -n '/^[a-z]/{N;/\n~~~/{s/\n.*//;p}}' \
> > 		Documentation/githooks.txt
> >
>
> To be totally frank, I'm not keen on spending a lot of time with
> scripting this. My parallel work with config-based hooks will also
> involve an in-code source of truth for available hooknames; I'd like to
> punt on some scripting, putting it in the makefile, etc blah since I
> know I'm planning to fix this particular annoyance at the source - and
> since it looks like bugreport will stay in the review phase for at least
> a little longer.

Fair enough, especially if it addresses my complaint about the
scriptability.

Ciao,
Dscho
