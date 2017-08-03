Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBFD71F991
	for <e@80x24.org>; Thu,  3 Aug 2017 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdHCRzx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 13:55:53 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33042 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdHCRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 13:55:53 -0400
Received: by mail-yw0-f179.google.com with SMTP id p68so13173494ywg.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8glFMwkbCJSU0Kuar7TBXO3dnbcFnySOgfcJqa6GIk=;
        b=JMReiU0x0LyOG/PeXu/povWvxnDiVzrGu/uiNNjFQ1AI06WiMCnEfszewQO6ZmFdnY
         02RgfMjiNEBJkirk+QAUIgE2sRGXoxNnKhPXAdtfjvgjnWx96swnuA5K4JnN3SEMsJfd
         M+1AIXUS/nB0qMkqiEhrXjFe/gf5EcPGMXbLZXzK5RxuQ6Tv6Al6OjsEzFBKa4jd8r0q
         eM+nGZ/udz2ob/x07UCUwUGL3qSA1NXVv3EPy8NW0JaukI3UrIVDCPQ2B4tZ8qkAHQzy
         75oFFw1NBZTSzlqKsK791mbon0h8cMQcQSL+0cR2WdbWSmTNwMC1gn18aBO70Tku2yFf
         tOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8glFMwkbCJSU0Kuar7TBXO3dnbcFnySOgfcJqa6GIk=;
        b=R3QDBRMHclAmDkv76owoTXchhmV5GEQRmNkYs8JP2EmscWVSpwfjNkOmsHPvC5kLGT
         P1pFPm8By8t0EkuNzxwlaxp+s+bu7KS7LByjTkducCyJrEIhHwG3hpqgf8zVGm4nougx
         q719j0+d4LO0jQkValCe0/oSqUsbLyLb6ncUCj/66jjyEomowR+xRxuD9ZlLQsHsKuxt
         TilzaPhMkemdkDWukkiAiIq8zhv1wL1/iB6Z+/qavUz9SlmHpdvioJG9qXw6QJv7EER6
         WyR+AkelNsl1etva1kyUaZVF/prIKQP+ObLbNn1+4j413Vv+ZwehB41B5q+JDuf2RFL9
         wfdQ==
X-Gm-Message-State: AIVw111Sqt/bykiS+/5BH8hsMCHYrisX1UphS5nW3HNfKr52BJlWPcVk
        8KDUflNR2F+5y1rRdNPP5orxXfYEWHx7
X-Received: by 10.129.57.214 with SMTP id g205mr1808993ywa.105.1501782952336;
 Thu, 03 Aug 2017 10:55:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.215.84 with HTTP; Thu, 3 Aug 2017 10:55:31 -0700 (PDT)
In-Reply-To: <xmqqtw1opnla.fsf@gitster.mtv.corp.google.com>
References: <CA+kp=uoHiP8t_40yZvT7r9ziB4uSxgcc=NRY0+XzQJDkuJpx4A@mail.gmail.com>
 <xmqqtw1opnla.fsf@gitster.mtv.corp.google.com>
From:   Alejandro Aguila <aguilasainz@gmail.com>
Date:   Thu, 3 Aug 2017 12:55:31 -0500
Message-ID: <CA+kp=uq1L7TFjXMCoFaNxq5wCNtKWw48MXFX_Unh-QxDf587dg@mail.gmail.com>
Subject: Re: Cloning an specific commit from the hash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio!

Is there any chance to find out what are the trees for the dependencies?

Cheers!

On 3 August 2017 at 12:28, Junio C Hamano <gitster@pobox.com> wrote:
> Alejandro Aguila <aguilasainz@gmail.com> writes:
>
>> I've been working with Oscomo's project OpenBSC
>> https://github.com/osmocom/openbsc and my old hardware won't work with
>> the latest version, which is 0.15. So I asked for help to osmocom guys
>> and there's someone who told me that his version is working with the
>> same hardware I have, so have gave me the OpenBSC hash for it (
>> 7f100c9712de5c684462e809bf31a58c0c326337 ).
>>
>> To be honest I don't use git more apart of cloning repos, so I would
>> like to know how can I pull the files for that hash. And since OpenBSC
>> has some dependencies that are in osmocom's github repo, I don't know
>> if I can get the version that worked for the one committed in the
>> hash.
>
> When a user of a project that uses Git says "try this version"
> without telling you on which branch that version appears, that
> statement typically means that anybody who clones that project
> would get the commit, i.e.
>
>     $ git clone https://github.com/.../openbsc
>     $ cd openbsc
>     $ git checkout 7f100c9712de
>
> This will give you a checkout without being on any named branch,
> which would be sufficient for you to build; if you want further work
> on top of that commit, you might want to do the last step more like
> so:
>
>     $ git checkout -b mybranch 7f100c9712de
>
> If you are not developing at all, then starting at this URL
>
> https://github.com/osmocom/openbsc/commit/7f100c9712de5c684462e809bf31a58=
c0c326337
>
> and clicking around, you should be able to find this URL
>
> https://github.com/osmocom/openbsc/archive/7f100c9712de5c684462e809bf31a5=
8c0c326337.zip
>
> which would presumably give you a Zip archive that contains the
> files in that particular commit.
>
>



--=20
Alejandro Aguila S=C3=A1inz
