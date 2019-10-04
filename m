Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983601F4BE
	for <e@80x24.org>; Fri,  4 Oct 2019 09:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfJDJhO (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:37:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:55895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJDJhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570181827;
        bh=aXz8RxTZeHwd+WH22BNST7BNYm1RmK0WC8eU2Ax81yc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J/CeLgHxe68iSPoSzBXNEQke7m3o3jG8qBAhbxFt4QY3cPdtnk7iWGnzI/DjSnQtU
         Xc76sEhbcSnxM9tHpe6lqccqRuiL0EQgRGCGppE7NhF/NrIe4LPf2pKbTcKg0wNAgI
         0OYKG1fg0IDNFGzZ9MqONniU4zwWB5k1DQy5Y1ZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1idWFr1udo-00Y9ET; Fri, 04
 Oct 2019 11:37:07 +0200
Date:   Fri, 4 Oct 2019 11:36:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 01/13] push: do not pretend to return `int` from
 `die_push_simple()`
In-Reply-To: <xmqq36g9bgl6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910041136150.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <pull.288.v2.git.gitgitgadget@gmail.com> <4d0b38125a13d85963be5e524becf48271893e2b.1569837329.git.gitgitgadget@gmail.com> <xmqq36g9bgl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h7zmu+M5u4vF6nWOHYbv+6hyk65k+hn27fdtGydEFpZJt8z3/ZK
 NjVmq4G6xfWEe7bGOqFZMatXFQK7OFICJ21J0ofjy0RQ3O3thAGj2loQ78XRRypRwcDorxU
 d2U3XLtk0JMB2A1o03sCVWctGbxQaFnJEhyMqV5t1M72Y07ZoGk9t5PEd7qXdCtE6rhEIss
 KD5UDJgvgZan9oY59wFOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ywfCGVtiz4=:QG9aP019Ul6G4geqchweCp
 H5R8wiJZUXoJxRuBzEYsI2iggrdumF3BAmoBooMAE/1d+aO1xsSHaXT1y6tOoPF4vss5vCx7b
 glOVkSo5wpe6ohju4g1WG9Hq0Fp+Q5XoDkTD4c9U/NM4+aBBNuat+OohVv1/uHPZ4feGv0jof
 ilGqlOxUZ5cvzMRDM7v/0TGUnABaOyR8dgNVyVG6NHkDgUmjZWO47jmWdmwDPbaDjfE6j0Z2h
 OvPHnRRNxCgNI/aKBrVoQipyUE7mFSy/t6WSM1l0VzGwiIUhIElZyCxHCq8w6uBmHTBwDvnC4
 pjMYKNvpdDz1wlhJX3BOcVZq4tbNw6QwwzNAVNTV2UKFDlXRSL/sCsqz0sys5l2ZF0o3ZX4UC
 wO72sVVodAUuCS/XXfh7864S3mHfcHyHH4l6ycxszHpCW8WoGDOKKhE6aNA6miduioCdeK5sJ
 PEOAJUzUO9eoFZmMewZH/E80gpTmU5nAl2cuznW1hO2GDVU8EINwL4zfzQzDiX8NHYDk8gtf4
 OQkLuTAli3bGfpo0axW+w1JzwVRbhKtOAK77xhdJRCJG2fvofFNrqECH5NR6fEEbCkAdATLLd
 FyUOFbeXuJbEe1igBuE1VgOE8O9ttQo9vfGZDY+p3AJQRaMLcfem4wHH5y5L0cClCdVrfrghK
 w4ZU3VDvRb/W7hvXYCVyJK6tEJPSSBhw9NX12UVqK77xigOHArd5zxW1vWhlnqKxOY23v6tdN
 8rqZScd0DqqFTjVKVGb4V4nobavLdS2GO902VLvuNVaJw519avD0lZc1HH4p7hWw/7sn9z54Q
 LIOLfsyIffjyEQ+jXrGz74hc/JSvllabrmc3B7J/WBU9QY+LEUb4ilnsdFghrSRIE8zUVgso0
 PCALBPGt1rUIodBxRKCG1wr9HWN8JCRw8xBben6BIp8xkHXyFI9aAKI0gwjvh2peuvC5iijFX
 0Lkjsp5+KVqt+x0fgt3lqEMy0uVEJ3sn4YxRbtJg1CfajH7Ox1xhnVucSWHK1cmjqyQK7ill3
 ha96tz7Jz3XaNxYiIZVs4EjtPjKTs3A/qK3MwiUmRfIfZHmZh3ZukeC5bmyT0SiKXdGMv+NV9
 VduWKvyk6CGhYAgzqgV85U/mIX+d0EfiOSECtnO7WvELfM3Yv+EHtvtNjLvWMHldD8bDBIt9J
 DumUWI7XvqIjozbJ6LvLfJ8IWKEw4ZnpYLOQERqcgE+3+KyIeNaIY5ZCucmYhctG1kayPXBQt
 38QR/Cy1Bh6unc+XF4Hqm9RtycZUbx3eopJZyOHogoxEhtz/ZESg348wLI+g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This function is marked as `NORETURN`, and it indeed does not want to
> > return anything. So let's not declare it with the return type `int`.
> > This fixes the following warning when building with MSVC:
> >
> > 	C4646: function declared with 'noreturn' has non-void return type
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/push.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/push.c b/builtin/push.c
> > index 021dd3b1e4..d216270d5f 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > @@ -143,8 +143,8 @@ static int push_url_of_remote(struct remote *remot=
e, const char ***url_p)
> >  	return remote->url_nr;
> >  }
> >
> > -static NORETURN int die_push_simple(struct branch *branch,
> > -				    struct remote *remote)
> > +static NORETURN void die_push_simple(struct branch *branch,
> > +				     struct remote *remote)
>
> Haha ;-)  "I won't return and I'll return int" sounds like an
> oxymoron.

Funny, right? ;-)

I was a bit concerned that GCC did not catch it, nor Clang, but hey,
that's the benefit of compiling with more than just one compiler.

Ciao,
Dscho

>
> >  {
> >  	/*
> >  	 * There's no point in using shorten_unambiguous_ref here,
>
