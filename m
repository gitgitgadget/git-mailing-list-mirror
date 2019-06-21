Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813AE1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 13:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFUN0z (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 09:26:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:36047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUN0z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561123607;
        bh=yzmWShUotmx/6gszgvtmwSmQly8ItkynX2yBEGGb+mI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kvsZkLeMRB/NQ0Fy6ZrYgGCkxVfuIgG0lYjX95LuEiQDE9BeY740x3Ekes+xwvI3T
         bTQwPA0LdmbZtJPivqukl5Sy9uI0lRLjlQx5c8i1gS8hW4Nkb+1O0hz8EWLuibO2fI
         Qjci0P7CQW2SFF2de8vDqycmiwnVxXS8WT8tlKHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1iPCm406m3-00pbz0; Fri, 21
 Jun 2019 15:26:47 +0200
Date:   Fri, 21 Jun 2019 15:27:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: pw/rebase-abort-clean-rewritten, was Re: What's cooking in
 git.git (Jun 2019, #04; Fri, 14)
In-Reply-To: <b2afef27-96f8-b262-2cda-4c22dc604d2d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906211526400.44@tvgsbejvaqbjf.bet>
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet> <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com> <xmqq7e9jsh8j.fsf@gitster-ct.c.googlers.com> <b2afef27-96f8-b262-2cda-4c22dc604d2d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LQIBKkMHCTeFDiy0QpRFPJEJQ5PB5kbkahFF4EP9AUq1BY2OZ97
 SClKnQu1xlTcudR3XFOg6Q7sakTCZs8oIti6Ift8a99my9A0pf/sVVekORduljF1fBrVNwM
 cOSySEMRkkhPODNPaO9aGG0RBEUfBmAj51zEmi6DnqqXZ25T57/6rQ7E35db/NnS6cismpt
 QNcQVXc2lh8xHM1Ud6I9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kNWvNFONCsI=:QfWMbhbUIC06HJtgE4e2I2
 PnhqzZZos2TcYwvA+IQBd8nzFB3BPrz7MTM5RY6WpbennhN0Bs9XoWkx16HtTKxX0u4uH/6PT
 6Iaq+1LqSYWy/rLseeknUNUa9MOpSsPBSBMxbfVRUAlmJJUbeVQQl/BoIRmh3uEHhlF+WwkgX
 nwcjDmiXdwVJ67LUhEKl5ACInOB1hsMHK5/I4xVEC0FK4jcW4rOsP+xQsOfL+pUt9c4GHFSNY
 usDLXTQ99hOp4XlZkqtBBx9krSLS6heKzUZN9UpZVAcOd1SOdO5N86T5Lq0Aod8VcAyQ294Bh
 hWdTAnwtwib5I6JBF2q59PP6kdQ2FxaGN5YSiXefXuweG7OAxv/GnoOijTt6WQMq1qqhFrTNL
 nM4TPIBWfqbQ71BcKOFO715r883YMICaQp2G/VhznQ1t+TbSfiuFXRbsA449peBXx4exBy7IJ
 kcEaRzsAYkOc2v3JSyP+DbVMFKlRa/ipXXobtKyMk8uIdAjSRNPPds5INp/fE/pqZPvvRxiji
 dyeynxzgfT1BK7twsIoIB5Fga3XOyBETdnakMbx3ltKe7pYaFVX3NY/yMCLk1fnGmNZr8D1Vt
 Wv6Kby/tHwm3ZKd2Q+kOpnssd8Pg+SvBn4DyCnQhEC2wVCqNd2hlyQlRkOZsJwqW5iNQdaV20
 GyTm4pIW9CojFAYN9ABr1u4/jwR257JAb/vnRuDJixS/r5XgwZ4m21xHh+w6jN1MGINkpsaBD
 NecHu6KQiMVsLaNnqalaMdUwMM7R6U3eMbSsLs+QFhundweBeoG17RZAbcbSEzjD/3ju90dQ3
 A7kIyLzBuoTrErWa1+NeREs9iPTSSH9dAOukK2zUhA3XWrZK4AkBOwi+PuZmP4EJ0mTuI/3XB
 5KVQFT1n1SKMxI7qRkU7TggCVUM8//Kw4KMq7gBfDBLQPRCDkx7mSefYSThJt2g3qmAje2VOS
 JqBjCBfH9Vr9FgBLUzOZQ3YHOlLCsYM5nYRFhWAFV+KRtiIjz++/H
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 20 Jun 2019, Phillip Wood wrote:

> On 18/06/2019 04:30, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > Yes I sent it just before I went offline, but that's a while ago now
> >
> > Yup.  IIRC, you told us not to look at the patch "for now" as you
> > would be offline, and I was fully expecting that a regular review
> > exchange would happen after you come back.
> >
> > I do not recall seeing much discussion, though, but ...
>
> You're right there hasn't been much discussion I assume dscho is happy
> with the new version if he's asking for it to be picked up.

Indeed, that's what I tried to ask... ;-)

Ciao,
Dscho
