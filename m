Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212451F462
	for <e@80x24.org>; Sat, 27 Jul 2019 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfG0VnM (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 17:43:12 -0400
Received: from lovelace.chead.ca ([162.223.226.168]:43572 "EHLO
        lovelace.chead.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfG0VnL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 17:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chead.ca;
         s=lovelace20151122; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lox1LRdV1bb9xw3kE0F1Zcj1Z7QCMrCiPPNQAswWCRo=; b=ZMKBI/f3mKPcgMhycROCOa2Hah
        npXugdbzaJcrZhiHyTqdLSQYs3/PTWJQ44fB4Snl5jSh307KopKPmjbVwVdwB3S/15Za20LZ8Wk0J
        EKgJud1a83vUTG9TfMJU9bFkUnEM+IKsEz+LxETwX9l0Gsl6PwQrom7viH+g6YsHacaI=;
Received: from [199.119.235.236] (helo=[10.186.191.77])
        by lovelace.chead.ca with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <bugs@chead.ca>)
        id 1hrUT7-0004J4-Je; Sat, 27 Jul 2019 14:43:09 -0700
Date:   Sat, 27 Jul 2019 14:43:06 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqv9vnkxg1.fsf@gitster-ct.c.googlers.com>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca> <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com> <0DC4FE1B-90A9-414B-AFAC-E328608C4F98@chead.ca> <xmqqv9vnkxg1.fsf@gitster-ct.c.googlers.com>
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
Message-ID: <C021D654-ECD4-4A23-9DE0-D272C3A3D901@chead.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 27, 2019 1:57:18 PM PDT, Junio C Hamano <gitster@pobox=2Ecom> wrote=
:
>What I would call "logically the same" is the set of repositories
>that are synchronized at the server side, which may or may not have
>multiple URLs to reach it, but behave as if it is just a single one
>without your doing anything special=2E  Your wanting to actively make
>them in sync by the above definition makes them logically different
>set of repositories=2E  But the phrasing does not matter much=2E

OK, I would probably have just used one push URL in this scenario=2E

>One repository at a hosting service (which may iternally be
>replicated, but that is not even observable from outside) may be
>reached over https:// or ssh://, and the result of pushing to either
>one of the URLs would be observable by immediately fetching back
>from either one=2E  Having both URLs and trying to use either one that
>works may help under flaky proxy situation, for example=2E

That makes sense, I guess, if the unusable URLs can be expected to fail fa=
st=2E

>In the reverse direction, I think "git fetch" supports the notion of
><group> of repositories, so that fetch from multiple remotes can be
>initiated with a single command, but I am not sure if we added the
>same <group> concept to the pushing side=2E  I personally want to have
>finer control, so when I push my work to multiple repositories, each
>of them are treated as totally different push targets, and a script
>controls multiple "git push" processes to each of them in parallel,
>with retries and all=2E  I think having multiple pushURL and pushing
>to them is sort-of OK, but what is broken in your configuration is
>that you have a single remote-tracking branch hierarchy---if you get
>rid of it, so that refs/remotes/myremote/ does not exist and does
>not get updated, I think things would work fine=2E

Yes, I agree, the presence of only a single remote tracking ref is what ma=
kes the use of a single remote with multiple URLs suboptimal here=E2=80=94i=
t was just a better than the other options=2E I tend to have pretty reliabl=
e Internet connectivity, and I don=E2=80=99t particularly want to go writin=
g custom scripts=2E I just want to use the normal push and fetch commands=
=2E Using multiple URLs on one remote is OK, though the single remote track=
ing ref is annoying=2E Using separate remotes works, but is more annoying d=
ue to having to remember to push to all of them=2E If I understand what rem=
ote groups are (separate remotes but you can act on all of them with one co=
mmand?) then they should be perfect=2E However it does not look like they w=
ork for pushing=2E Would it make sense to add?
--=20
Christopher Head
