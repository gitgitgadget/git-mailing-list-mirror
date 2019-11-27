Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E4C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3196D20661
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ss2RvSuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfK0UBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:01:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:44815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfK0UBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574884862;
        bh=t47W/jI0m/ye5+7wgfRGid5qc1ICWDgg/Kc1V264Bdk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ss2RvSuMVSlJURZFOCAzApkmkclFbWIhib0Iz5GW+KGkEOVVHOcy4NuwsOJJbW46v
         2jeD91T53//DulK1b2F29CQVjF7iEw5rERJcoKtm4TrkjwcqmoKipok+Pb3Uz5tWa6
         uBUSwUqvLll8W4z4dpVi8VLhfBOKS+nBPOj/y4wA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1iNvRy02tI-00TmrZ; Wed, 27
 Nov 2019 21:01:02 +0100
Date:   Wed, 27 Nov 2019 21:00:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over
 public-inbox.org
In-Reply-To: <20191127125936.GA9877@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet>
References: <20191127125231.GH22221@sigill.intra.peff.net> <20191127125343.GA27983@sigill.intra.peff.net> <20191127125936.GA9877@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ABACXOu/KWpr63GEClz19ymmM2mw3N0yhDpyn6Kfs7VpkyJHhnU
 gPaFy6OD+c18pIT7JknDLl2qpflT+n1A1yTf9NLsAPBYkiFO6piy4gDuYWUuf4+Kk22hhOx
 B8biYv+5uJpWVBK1JRVwm5A00m3YKjAZMT8VjwExFExKTX7/QsBtn8HPrpFCk6q0lrCN469
 lt6GFLBTz0XLkIqJDBVsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1TAYPVUGPY=:z3jGyEYkFqUe6gasImFpaW
 k4zOtWta/YdQScxxsD8nnEo86A69jQp2Cn85I0/abvRVRGaUnf34K0SfEa3kamsn7zsMPW6di
 IgXsQIKAA40nt06B+mJqwDFk0eFB3WzJwpoHaYIZ0vh301trj+yYMNJGkiXyChvUaTxjDT6zT
 8f5f5a6iF/TFj3ExGPcqd7PtAe7aPNjZHz77RAhMduaNnLU6OV8nsFNirUfAD70zgC7PrFxBx
 sV7OTuA2HQplxI27Mr60upt0SOntiH+uqaS+ofKouNBvgeDAugQMj2ePggRA0QfOdnZb1OTUV
 42GviZzU6v7sQG+fjD1g5V7ozNLOycSSfBQKzu4+3e8hD8tja5aAd/20H1eIniSAAw02Yo+cd
 i3M0R5a91ldIlvfS8h2Ae8hjKbjqrKfUYe2ckaXheHQ6d2lxW9ehP92Jf999AmZh8Xv5A4zrM
 OlAZTXAX1FlO5vMr59708kW9PmIGPQ5/xsDVeV0/jk17RVeGtc7qGYqGVe55gUzkjXc+3U3fS
 dvYApXDmrpHCJT7lVylCKqonHwW894tlFTPZqxdSzxSbwn1dyW5rhGmH7fVMyk0gn1H5u0HYw
 DDyHsrkcd2QEtSEANOfhcJ/xbFW/fZ06ukIfLZnow+ciIKjEdBvXr2auTtYvxxQXlbDyKASCh
 7VBunl3K32gA8UpdbX7HjgOR/vpMAZKUzJGDOXTh4vyzEA8fGrceDRfik1C/XK5sv6CKUHLLD
 y0p9JSLO8q2V0t1qQm1gJ4JHFMUzE+LD/APUwpwfDAAxODWsYOMBfrryVDA8lLu2fRD6HITaJ
 n4aqnt2ByB3hnTpgtPil07uJ9s3h0AlhgoPLVjqRmk/VR69yS4IqhpDRBNpgTv2rnY8wW3P7l
 rr2vGL7CQe3/5+i6OU488903X182Y6nDGs5cgmG/Hwbe5x+K+Kp5tqMhzeEXA+toJV4KcMQjx
 I9b+wsDWDD6X/uH2Y8dp/fPFkHHhFXqiblVXDA14zQ74KvdteQ2ktOUXQp2jXj2DdjNdqZB5V
 11xWSFSQ4l4uBZo+Xju6YtUq4Kd/px3BqN2E9JcAPu8Gd63ZS0A316d3gFOOFzFSdk0w/z0Gk
 TTJi3F+2BolC26S40r5Ka/DzAAqvALxMs5qAAjJU1ZsODX/62BX29QIfwRyUQnIMJu6nkaHc5
 mnvZEEAnrPW1S60phfayQq2xYmxBmLgOmg5MHAoTASBQuZSz1EbmggApflIQney5Hbo79lEzS
 usIMd31PoegpubbURky7ZZfZVVPMc8hzbyLCTgcZXvsWLtFygmrCWT3iPDno=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 27 Nov 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > Since lore.kernel.org now has the same archive as public-inbox.org and
> > may have more longevity going forward[1], let's recommend people use i=
t
> > for finding or referencing messages.
> >
> > [1] https://public-inbox.org/git/20191120195556.GA25189@dcvr/
> >       or if you like:
> >     https://lore.kernel.org/git/20191120195556.GA25189@dcvr/

One of the things I appreciate most about https://public-inbox.org/git is
that you can clone it. I just tried this with
https://lore.kernel.org/git/...

$ git clone https://lore.kernel.org/git/  lore-git
Cloning into 'lore-git'...
warning: You appear to have cloned an empty repository.

Is this something other people also care about?

Ciao,
Dscho

> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > And it's one character shorter. Think of all of the bytes saved!
>
> :>  URL length has always bothered me.
> peff.net/git/$MESSAGE_ID/ would be nice to have, as well :)
>
> Anyways, consider this series:
>
> Acked-by: Eric Wong <e@80x24.org>
>
> (and I doubt I'll keep paying for 80x24.org, either...)
>
