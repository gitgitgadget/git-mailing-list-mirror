Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A203BC55179
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9F20BED
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VdcjzwOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441769AbgJUNmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:42:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:56063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439258AbgJUNmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603287752;
        bh=oDMzg962y4d+AhCdKy5TpK4QXTCIeC+tYxigMjjkeq4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VdcjzwOlQo3zEtHEc+mTD5LnJFfOyw0U/i+EbU1QvDF6xcIr9UPxhqPXDGkfJlgQK
         IkL//IxUZMEdbR7MJiVD6UFHy/pwumrqH0M0TGvKPkpnnIMpq7i5YU04u7imk3dyog
         mqvvlzaezBspvfZ9GazS765E6xcA4GsiFo5u3cH0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1kDGQo2K2Y-00zFCh; Wed, 21
 Oct 2020 15:42:32 +0200
Date:   Wed, 21 Oct 2020 15:42:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui changes for v2.29
In-Reply-To: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.2010211542050.56@tvgsbejvaqbjf.bet>
References: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xOyoF1PWraljbMObNlQGoCUV1FFa+sW0bUE2aGtL9HkSK23QoF5
 KYtSHo3tSvgKxQ8VA2kQVmc8Q89ttUW+GVhbVAXoiaymXr+zoiY4Lk71ts5qw41U4vhdYGt
 ZJFsxuZ7LP09JzQgrEG4GbxqT/A4DUnRYldH9rg2rDMgLetkSjoWNvu8FNv7dbCvdRXnJo8
 9F35nAerxjA8HkLqsDhxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FcjabMk9auk=:9br7Oh0hAdfXZ4VoTVb7se
 g4seLm5Q2C5Uim+uqETym06C89D4SoBsOMW+ue+wYKLLqzQJ+u+i6KzUhKF8Ch9N5nsx2bYDu
 +2JO1w7Yy7X++BHnC/aWIWDQf/QN2lE3DZXk4xArpps0Q9qapWWcRGxvYi7t6vad3YlT6yq67
 dZjzzYfbZ/Ut+Mb1kVuxrkTlfEWSCvYYW+zR4jc6Otm45KzAxOE/btTQ/wzSwj9Dua76DjuCr
 9Fkjya4BHlEpkXlFe8IvWtukmE2hscllsY7JoNA1gX1oOzPLM/L7PJaRuIVUWuWk8i8licqie
 gI1HOknfZe9A8P48vschPYSFCHfuTI4JiTSGbU2XAWJOrdIXxEdnDMHkNtLny+mHYEiJpJ7Bl
 tqiXvVStl1wCVMLFTSYOwqgSpNkh/7xPg7iHFpcfJ1M26cSTRoBvwZMgF3U8vl+dn+9WuYNpG
 54OGII2uSaGp10ZWk5Q41dKKZBBx4xJ3PolPCSGb5BG2h8j1gZb9QcHBuXqGCdnZnGgRs9UQn
 U7m1J6d+qLmXq33v2Xl5Hpb1EpAorYa2/cd0eiJokAhkW0gsIARA/sTd5NOkXmQgziQaDKben
 0vv1pAsXTnsNHbqgRI6vHrqeFSB5XmcBzKJa2gose0MION5CRx6IgzgXyOKGjmV5jXLfifY4y
 OCtKuJTfrOTScV5+SU3cqMgLd+TkphPOFeUbRd1K4obOa8jIhElW/saImsuOt0U9QN1UxNDSx
 iX0UcsIrEUOL2i7Grvtx6gc6wlMgQvx9EwWx1Ms14Ejx/vz3dq9eZ1oS5nEhpNZ7kwnTUX5FQ
 v4C44jnvxBhlgN+Kkoqt67kQuQmeDnU66z6QD+8VMw9pp32bPGGCzJFl0/SEJFNBnfIoigiu3
 WTHJ6QSamc/nK6fzjHePtYySd+w76eRyuYVyGgjDc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Sat, 17 Oct 2020, Pratyush Yadav wrote:

> Dscho,
>
> I still have some open points about intent-to-add files that I'm not
> clear about. Let's target support for them in the next release.

That's fine. I merged my version into Git for Windows v2.29.0.

Ciao,
Dscho
