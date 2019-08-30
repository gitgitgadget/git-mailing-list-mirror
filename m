Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462A81F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3TtM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:49:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33837 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3TtM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:49:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id r17so2619407vso.1
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NTwmZ9BaTaPFlb+erKJc6II3rAOmbVASGktcHXfwzk=;
        b=AzU8aX6bi3S9NJMCWXvYWnYtjo24qCGK3dIwtGM8Rj0LWBzNmJ85QK9ydzgvUOwkwe
         QrEYRXL8KJ+DxIYVLzdsX8qx4oMyT6bqgKNxF/G5uh5jxNQsmTSj3Et3t1oMCLfrF6WH
         0wZKm4Jn/IWN+fH+bf0NlE3mSAHo5F64wUPRzb0IMy+QhfsTo+GiyzDbSLnwvONFKzfO
         SDWQpiMCEwDQW6TxUmRKcSB2GRr28Im5vFh+NKvZIliDqsC1o2xlzYwV5Cr8/1UUUUF8
         mcoCoIef9KCdE/9B5XY4gvEeUvEnAYyxsneKYWmqWVGAi/tTohg20xQCfm1MjKnHmIEG
         5Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NTwmZ9BaTaPFlb+erKJc6II3rAOmbVASGktcHXfwzk=;
        b=sOCuEtbkkB+ir6FCTYHXBh86lOQgGh0l90qyoadZL91sDKc0dv6LUEk7tfpvbgPd6g
         Il8sn9stss4fEXIdxYTbxjkRHl69PbWRKAEqhdcGWWksz2WfwzbktGCcABz0/mtYtGnF
         usu9xi4ddEvrS5os1SnbvQNtSppYyKQBo4KJtItnLkV8YotroU5g2AIwxN4lC8/AjBpP
         jc8dPbD13417NEHf+f/iFMkfP5L2TrWZ0729S9xCkqTvFW44k3HjrL0KKIKtSJz2ARTp
         Ql+Xmd9xvNfGHOnSolhoUvm4BrXf7BFazjB2B6mWZDAjJIYGcYF+1KP2UmxpwStMHt0D
         MLXg==
X-Gm-Message-State: APjAAAWHP+q7QrnOEuinzhp1kRHAJFykl0+/oNxma2Z1eOE2OoJ3/qVJ
        qw7MbXcKJhCjdCDRUhbOrrZHxtG0yx5VPEY0oDI=
X-Google-Smtp-Source: APXvYqzbd/+HTmByCRTAf1Bq9EEJZHJxBpeLRWSJWcf5ntHNtKDUdUlqWTaeJO81u4IlljAdfiHlFIq+Y5s84mEs0Bg=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr9790488vsr.53.1567194550945;
 Fri, 30 Aug 2019 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <877e6x3bjj.fsf@osv.gnss.ru> <20190828155131.29821-1-newren@gmail.com>
 <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com> <xmqqef12xwr4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef12xwr4.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Aug 2019 12:48:59 -0700
Message-ID: <CABPp-BGsPEikU=KZgZgMbSLFn7Cf+fy0L==w8m4Wk95BnpHj+Q@mail.gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various
 ff-related options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 12:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> >> +--ff::
> >> +       Whether to only allow resolving the merge as a fast forward
> >> +       (only updating the branch pointer to match the merged branch
> >> +       and not creating a merge commit), to never allow it (always
> >> +       creating a merge commit), or to prefer it when possible.  The
> >> +       default is --ff, except when merging an annotated (and
> >
> > It would be great if you'd write this as `--ff` so that it got
> > monospaced in the rendered documentation. ...
> > I'd also write `refs/tags/`, but I realize that you're just inheriting
> > what is already here. ...
>
> These comments may sound nitpicky at times, and some parts may be
> beyond the scope of the discussion on the patch and are better left
> for a later time, but the consistency is valuable.
>
> Thanks for mentioning them; and it would be appreciated if these
> suggesions are followed through after the dust settles.

I'm confused; these suggestions were incorporated into V3 already.  Am
I misunderstanding something here?

(But yes, I agree that Martin's reviews are valuable.)
