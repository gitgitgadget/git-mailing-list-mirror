Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CF41F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeHPLTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:19:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:48155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbeHPLTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:19:48 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdaCy-1fVNHE2l2q-00POWZ; Thu, 16
 Aug 2018 10:22:52 +0200
Date:   Thu, 16 Aug 2018 10:22:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] range-diff: indent special lines as context
In-Reply-To: <CAGZ79kZhLsUZL+bfoovV+U6W-zX6npERRG86fS8+1GsTQmKoHA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-5-sbeller@google.com> <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet> <CAGZ79kYVw3AXLyB1fx07WojN3dLuxJLDrbWwC_7M=9aoB9YuCg@mail.gmail.com> <nycvar.QRO.7.76.6.1808141713510.71@tvgsbejvaqbjf.bet>
 <CAGZ79kZhLsUZL+bfoovV+U6W-zX6npERRG86fS8+1GsTQmKoHA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C5UxOptA1gP7qVMFZAtFvUbjRbQmGr+UDCnsIWLvrh0pZyIjlgY
 BjHEyLNncI9VsfoB/R6IvNAot+7cTeN/UtU6Vz/VAcxjjvB02zbRRs+5FSqI0/laMko/OXf
 Sif9j2yUMUp2mXG59IurHPfBtLQjxv4jFF0P0L3z/Btj2PaPw32Y3NbGU/aXVrV/7bfgn1A
 O2xk5DH9RmWtEAeGQBciQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rQeoTpRs5BU=:87vdfJZgFyyFv7Yp1zCu0x
 L91ysm8G/bpzh0hPokyNffGapu8pGx1vuyLHaXYVOjiTTveyytN8P4J4Ql+okPagXrnNKgaHo
 t5MxmX06KX+CuVBx3ORs6ZHN9ur14uqtTJ30BnN/ODufUxGMvAEoPfFNLJnOI/IJy+rHBCFkS
 13RYAQMKtBUcXi2mHv0NlJCitI7tVYccbDZyABaSljn9OcWo/GpXlVy0IpiQhJ4H6IJfnBVY8
 iaGulyWG6FfdwH13jfC2eD1NUsHYkxarGs9JD3w6zCqmjvhivYH7AwLkfsIip+CPmrCuLpi/C
 TxeX3ymC3GRdYYq2icLtKlRZ7zoUqLke/eYM82aERFY03i14MJe1ihiFWKQRXqeMgPgueLXRx
 tMKNKWK923Md+Yxrn6JrN+rnhY7ZaSpwBdm8qFQaRdFcgf1TJ3f9tyrkGH8gWHhSoY8bkOyPL
 MCss2x8Ieg5ttfl7sYGPsJ9rzeOkfYm/C6piFJQIYaAPuqnbfSxTSe8YZwavydYHDQQvVC+Dt
 db3oPxxFhFj4dYQ85NDn4y/5o4+Yu65zicEl+zlfubq07pzMz7Sgs2vENBXEjSMlJGuFHlPHq
 VQWXvZh6aFWwwMXS2K31fktkhZ09IeWeRJeHg7jUAvY8XO95d61z/U9vuPIY5iMhnrVpxLWEa
 O5q8p9hSaGxbRBJiLAdg6qprwljvAzSFLPfL7jamHvkCh5g/mSqYjEjQ8z9ZJ4gGZS9uL8Emq
 hvaV6PkecFT0N+hj220fJTsRKmzrkGIs80klWOEcEdXl3U+jaKtV7J940R1FqpZPNvLWlwflp
 ChClG5t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 14 Aug 2018, Stefan Beller wrote:

> On Tue, Aug 14, 2018 at 11:54 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 13 Aug 2018, Stefan Beller wrote:
> >
> > > > > The later lines that indicate a change to the Makefile will be
> > > > > treated as context both in the outer and inner diff, such that
> > > > > those lines stay regular color.
> > > >
> > > > While I am a fan of having those lines colored correctly, I have
> > > > to admit that I am not exactly enthusiastic about that extra
> > > > indentation...
> > > >
> > > > Otherwise, this looks good to me.
> > >
> > > Can you explain what makes you less enthused about the indentation?
> > >
> > > Advantage:
> > > * allows easy coloring (easy implementation)
> > > Disadvantage:
> > > * formats change,
> >
> > This is it. It breaks my visual flow.
> >
> > > but the range diff is still in its early design phase, so we're not
> > > breaking things, yet?
> >
> > Indeed. We're not breaking things. If you feel strongly about it, we
> > can have that indentation, I *can* get used to it.
> 
> I only feel strongly about it now as that is the *easiest* way to make
> the colors look like I want them to look. And I really value colors in
> the range-diff.  Earlier you said that color-less range-diff is nearly
> useless for you and I thought it was hyperbole, but by now I realize how
> much truth you spoke.  So getting the colors fixed to not markup files
> (+++/ --- lines of the inner diff) is a high priority for me. So high
> that I would compromise on the indentation/flow of these corner case
> areas.

Okay, let's go with your indentation, then.

Ciao,
Dscho
