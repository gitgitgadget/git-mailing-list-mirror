Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCCB1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 22:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeA1WtD (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 17:49:03 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:36450 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeA1W3J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 17:29:09 -0500
Received: by mail-it0-f41.google.com with SMTP id n206so4774136itg.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pWbvLB8gz9E+99Oke9X+gmFwpK0lQMxTbiw2m3gWj7U=;
        b=jjAzqpYkiq5JXr6k88U7RS1nOWUnE2wKd7lypR8aod9egbgXIjGJUcyPaHyPS4xixJ
         ctsXwoo7NeP+BuIbtL/ZCpLFG5U/Y3KPu/47rzBi+/tJk15ajoJ3/1jU9CeMfrFrrHGB
         wM6PupU6c8yi60Ybpo3HbpCDQVpzErigvXRVYDB98x+RdKqOpCfp7zyqzUAwk03nU5Le
         xCn6Y1N119hqQiPf2JSdzjd5fPsS07PRG1zlczQuA2j7sx8e8pczE27QtGsm15MIWAZH
         CPqpgIZlNnb1Nca54SmFZFGosEhGG0TuwW5utL/hLUhjkDtUovah0WlTstExStby2WwM
         2XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pWbvLB8gz9E+99Oke9X+gmFwpK0lQMxTbiw2m3gWj7U=;
        b=lANvLk49cEjUEaUu0dcTsgLYnleJL0XNljN3SbUXaCevJD/AaxNGgz+l/qOJJ/MJj/
         2XMvlkGuoCfNXTWcODsTAogiOlCqrLM8JDE0qA06FFaEDmh3Can6evAFLMyUqrRji4F8
         cGPkglTgosEvGRJ9jEXFwX0hQynUcI0PUujTctlp6jwekr2czxTGrbYyizTz6TqWoZcu
         6j900WJZKnOopPXY/eP7MsOD6GkyfZH5IFIlLvz7GOubeIwWRmkhaQ+FdOhxAXobn5ZD
         Ue+ug6u5tVFQiQmIbGAZMGevO5PvERTK+zjpKjXkRwg+Ux2aeVcKBeY8cR073oWWo9ok
         MOMw==
X-Gm-Message-State: AKwxytdNujqc8oRI3Zvm9d3vfLowwhzesqlMisRQ+EtxPxqhGG4I/N/+
        2miQp5JxiWx8ThV/mr/4Lz78wRQJ1b/40MefQt0=
X-Google-Smtp-Source: AH8x226tY3ThuC8L+GeGDKFYqf5PN2JtrUeq6Ge4WngMQIn3L+Le2WPBuCE1jI2IDJKqLwM4ozQ6DevI8vRTisSlkoE=
X-Received: by 10.36.77.65 with SMTP id l62mr26090256itb.42.1517178548918;
 Sun, 28 Jan 2018 14:29:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Sun, 28 Jan 2018 14:28:48 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801282140330.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87efmcw3fa.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1801282140330.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 Jan 2018 23:28:48 +0100
Message-ID: <CACBZZX74WcK4qX5O1E_6nxv7f4Vpns3O-7dcURbs+QneKsA87Q@mail.gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 9:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 27 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I just got around to testing this since it landed, for context some
>> previous poking of mine in [1].
>>
>> Issues / stuff I've noticed:
>>
>> 1) We end up invalidating the untracked cache because stuff in .git/
>> changed. For example:
>>
>>     01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hook=
s/fsmonitor-watchman' returned success
>>     01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '=
.git'
>>     01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '=
.git/config'
>>     01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '=
.git/index'
>>     01:09:25.122726 fsmonitor.c:91          write fsmonitor extension su=
ccessful
>>
>> Am I missing something or should we do something like:
>>
>>     diff --git a/fsmonitor.c b/fsmonitor.c
>>     index 0af7c4edba..5067b89bda 100644
>>     --- a/fsmonitor.c
>>     +++ b/fsmonitor.c
>>     @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_=
t last_update, struct strbuf *que
>>
>>      static void fsmonitor_refresh_callback(struct index_state *istate, =
const char *name)
>>      {
>>     -       int pos =3D index_name_pos(istate, name, strlen(name));
>>     +       int pos;
>>     +
>>     +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>>     +               return;
>>     +
>>     +       pos =3D index_name_pos(istate, name, strlen(name));
>
> I would much rather have the fsmonitor hook already exclude those.

As documented the fsmonitor-watchman hook we ship doesn't work as
described in githooks(5), unless "files in the working directory" is
taken to include .git/, but I haven't seen that ever used.

On the other hand relying on arbitrary user-provided hooks to do the
right thing at the cost of silent performance degradation is bad. If
we're going to expect the hook to remove these we should probably
warn/die here if it does send us .git/* files.

> If you *must* add these comparisons, you have to use fspathcmp() and
> fspathncmp() instead (because case-insensitivity).

Thanks.
