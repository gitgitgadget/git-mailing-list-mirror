Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB441FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162915AbdD1I7r (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:59:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34368 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162908AbdD1I7n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:59:43 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so9634385ioi.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sEabrSARw8VjP8OZ9cS4RYrpzOUfL48hhm3QWTYgLMQ=;
        b=VGgClwDrm+5iL4mFQdKb+MDxGR84MyENkRz1dS3k3qN3cwbF91ZyOgBBCg4fRxELiV
         kVwZ1AiyRnDoLghZ0WIsvRy9EVYqTookIThBQVLDhBbWrRB91Z+ASiZy2BgbgRYEJklt
         XGTcv5vqVlM00Iv4xS/UdYc8PU4py58dFgGH50IsW728yMFrpauB3DE6bTKR3XctKofO
         HvWce5Aw1jk20YU81tN8zpKuIzdiQrxT0UMsKwGu1SbrnVj6dVX9P7FoUVMH2Uc4gceq
         /v+TJiWWY8Q4l+tGtUoa5nzLHGky/Gtck02caC/1e+CGjoau8OGOp/80DIhWnI4jNGaj
         Fh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sEabrSARw8VjP8OZ9cS4RYrpzOUfL48hhm3QWTYgLMQ=;
        b=uaiZB089cHg/H9lXV67DvVMlGzEShQ+/pLBqX0gk1Hw31kjbobCmnSkdRKibf/Gnkz
         nyj3ndbtR+e54Z4ht9OdFOcCc/DD+FVAne7eF9Wyzqnjb1BK8E0V7Gk6VvWLyCNM/IaO
         LGtZKSqZDs+W0wwLOSQvVFG86bbu3Qa4gyhkv8RnhES0TjfkDmA/EZ3VbxLCYMtM41hT
         wEfGr3OvxnVI9Uezb/Uax8uX3XqQENo1RZ8bA1RWc2JD4YDcY0GmzZI3lvSz9iEtq3fF
         /cuLnEG8P+s4P3t1fg3hY8D0j8c+7v9SUsA5e3WN7QRQ7S4WYTB42r5TNC2fJRqLaLc7
         dAjA==
X-Gm-Message-State: AN3rC/6PWVYWgv3i8fq944baRxUlhAAp2s9guo1ofvYi2kk4+ZTO031J
        RZp7RESpCj+RjpE6MZUfmb2pUGIH6sgi6Uc=
X-Received: by 10.107.146.139 with SMTP id u133mr8706704iod.160.1493369982727;
 Fri, 28 Apr 2017 01:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 28 Apr 2017 01:59:22 -0700 (PDT)
In-Reply-To: <20170427221337.GB146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-4-avarab@gmail.com>
 <CAGZ79ka1_eJEa56TU5v++1FKsGY=nvZ4rWBK1begKvqecH17mQ@mail.gmail.com> <20170427221337.GB146047@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 28 Apr 2017 10:59:22 +0200
Message-ID: <CACBZZX7VHURHOoRMmcJq1e-pv7x3gKhYyWF5F5X+FgbunY-xhA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] tests: rename a test having to do with shallow submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:13 AM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 04/27, Stefan Beller wrote:
>> On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > Rename the t5614-clone-submodules.sh test to
>> > t5614-clone-submodules-shallow.sh. It's not a general test of
>> > submodules, but of shallow cloning in relation to submodules. Move it
>> > to create another similar t56*-clone-submodules-*.sh test.
>> >
>> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> > ---
>> >  t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shallow.sh} =
| 0
>> >  1 file changed, 0 insertions(+), 0 deletions(-)
>> >  rename t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shall=
ow.sh} (100%)
>> >
>> > diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules-sh=
allow.sh
>> > similarity index 100%
>> > rename from t/t5614-clone-submodules.sh
>> > rename to t/t5614-clone-submodules-shallow.sh
>>
>> Thanks for formatting the patches with rename detection. :)
>> The rename looks good.
>
> Do you have to turn that on or is that on by default?

Looks like it just uses the diff.renames setting which I don't tweak,
I didn't do anything special, but maybe it picked up some part of my
.gitconfig that doesn't look like it has anything to do with
renames...
