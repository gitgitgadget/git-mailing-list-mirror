Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12341F462
	for <e@80x24.org>; Sat, 27 Jul 2019 18:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfG0SPo (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 14:15:44 -0400
Received: from lovelace.chead.ca ([162.223.226.168]:43570 "EHLO
        lovelace.chead.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0SPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 14:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chead.ca;
         s=lovelace20151122; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tw8HjebswYE575gIP+s254Ww18zr1QQuqsCcu5qLris=; b=cm2pDGjLBjerUsxt+G8OirkyHy
        tpVTWUCq4wPQrQQREQeE/H5z0LnTaIW/HKo+Hzjw/fVic0FawgpvN+9Qf5ePz1weCPTvC2qdjy+Qd
        EDXZA7SzD/BrCNEAKI17oERRQcr2izaasTh+SDVQvOuxT9tBizC4pwYSjoepa4Z3bhe4=;
Received: from 199-7-157-22.eng.wind.ca ([199.7.157.22] helo=[10.168.1.241])
        by lovelace.chead.ca with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <bugs@chead.ca>)
        id 1hrREL-0003zD-RX; Sat, 27 Jul 2019 11:15:42 -0700
Date:   Sat, 27 Jul 2019 11:15:37 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca> <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=bugs@chead.ca; keydata=
 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
 XUwk7vGasuUsD+IytBrpkZx1mhB63Lr44ko=
Subject: Re: Push force-with-lease with multi-URL remote
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
From:   Christopher Head <bugs@chead.ca>
Message-ID: <0DC4FE1B-90A9-414B-AFAC-E328608C4F98@chead.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 27, 2019 10:46:43 AM PDT, Junio C Hamano <gitster@pobox=2Ecom> wrot=
e:
>Christopher Head <bugs@chead=2Eca> writes:
>
>Quite honestly, the true culprit of the above story is that you are
>letting multiple logically different remote repositories [*1*] use
>the same single remote-tracking refes/remotes/myremote/ hierarchy=2E

They weren=E2=80=99t supposed to be logically different (if I understand w=
hat you mean by that phrase)=2E My intention was for the different URLs to =
be mirrors of each other, and multiple push URLs seemed to be the easiest w=
ay to update all the mirrors without having to mess around with making them=
 trust each other and sending notifications and such=2E

If not this, then what are multiple push URLs on a single remote meant for=
?

>If your previous "git push myremote" (with or without lease does not
>matter, as this discussion is to illustrate that your setup is
>fundamentally wrong) updated X but for some reason failed to update
>Y (perhaps the network to Y was unreachable back then), and
>refs/remotes/myremote/mybrach got updated to reflect the update to
>X, what happens to your next "git push myremote" (or more
>specifically, "git push Y")?  The repository on your local side
>thinks that the other party has already took the previous push but
>in reality that is the state of X, and Y hasn't seen that previous
>push=2E

Of course it wouldn=E2=80=99t be perfect even with my proposed behaviour=
=2E It just seemed more useful than the existing behaviour, which will esse=
ntially *never* do anything useful as far as I can tell=2E

--=20
Christopher Head
