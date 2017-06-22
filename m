Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D8020802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdFVV6N (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:58:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34462 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdFVV6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:58:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so7869262wrc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fZDQvRVqWL/OBF+K1RNsoTu7dedecf6AGwN/9PP71w0=;
        b=jOalMhRORoWTRRGq5Wr7F3jSbiXBcEv9PvTuS/RcPdApGLQDlcoyFzOMW4/hCcyvk5
         Z5UmyJBi4mLVPVFywZg5Kxi4Tol4Ska+roor3jbg02kZOjTMmzNOMQRjs++w3ZVQMtQc
         Ret9oDtJXbm5WVe560sFwPEWWoSjO50ADDHwV1rz54wKeRUjGbgr5tX8sgtw3frfLSY9
         IUmRCBB7XlO1KEhsF9KT54oJKj7ew9w5Py5cPAPS0GXMLF14Bqvg04wajp7dW1kJKGSj
         274nbBwGdEnMACK1lAzaujzxr3N/tjFSzWE0HQK+Ba7pQ4gFIQn9l23SATiwpULyNIS/
         6fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fZDQvRVqWL/OBF+K1RNsoTu7dedecf6AGwN/9PP71w0=;
        b=YTuVZ0/9b+jrX5z96qfDKrjgrNxVRDX2rCH0qazZQ8g5SF2D+KJ+mMmrhZuDTGlX8y
         5Y9E5dqeSgszhnu+ul31unTZTmqUoWcVVGRSDc79hYFcAGKysEO2pHoqDhpqn4qMJY0F
         BvISrtTbyumsWTp0ITr/he+DfPUpV+xQLbk40Gl3ezfmOpOYFvOjXrg2f5+CFAr3KEyj
         6Zjbdxbz8n4/P+r98f5sysDDAXY6uNWt9NtZEJ8pYzEo8uIBoXy5nPpJRS2hA62mP5gm
         tRnyxX0C2TpFdTanjf2wmpf7kbuUORZBpLnAisWtOM7pSPm1m9IvY/jQSWQFpsL8BT8S
         HSdw==
X-Gm-Message-State: AKS2vOxvRmXJz1c693aLe8+EEbGuKXqqsoN4sohmEewPvLrHOvbqlITV
        a3Cm4y8Zz627SNGt/2M=
X-Received: by 10.80.145.25 with SMTP id e25mr3990325eda.8.1498168691274;
        Thu, 22 Jun 2017 14:58:11 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id e28sm227062ede.14.2017.06.22.14.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:58:09 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOA76-0005HQ-Ul; Thu, 22 Jun 2017 23:58:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com> <20170622124803.45sduodpfbwuuq52@ruderich.org> <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de> <20170622134708.fcc4zxakga6p255x@ruderich.org> <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de> <20170622204628.eintlap4uchlncub@ruderich.org> <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 22 Jun 2017 23:58:08 +0200
Message-ID: <878tkjk7m7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 22 2017, Junio C. Hamano jotted:

> Simon Ruderich <simon@ruderich.org> writes:
>
>> On Thu, Jun 22, 2017 at 01:55:27PM +0000, Patrick Lehmann wrote:
>>> The description on https://github.com/git/git doesn't reflect that policy.
>>>
>>> a)
>>> It explains that discussions take place in the mentioned mailing list.
>>> b)
>>> It describes how to subscribe.
>>
>> However it doesn't say that you have to subscribe to send, only
>> how to subscribe.
>
> For that matter, we also say "everyone is welcome to post", which
> makes it clear that no subscription is required.
>
> But I view these merely being technically correct.  And making it
> absolutely obvious does not cost too much.
>
>>> With knowledge of other mailing lists (mostly managed by mailman),
>>> subscription is required for participation.
>>
>> That depends on the mailing list, some require subscription to
>> prevent spams but not all do.
>
> Yes.  But not many people realize that the world they know is the
> only world.  We are used to an open list and are shocked when we
> encouter a closed one; let's not forget that shock.
>
> How about doing it like this?
>
>  README.md | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/README.md b/README.md
> index f17af66a97..bbaf54bffb 100644
> --- a/README.md
> +++ b/README.md
> @@ -31,6 +31,10 @@ The user discussion and development of Git take place on the Git
>  mailing list -- everyone is welcome to post bug reports, feature
>  requests, comments and patches to git@vger.kernel.org (read
>  [Documentation/SubmittingPatches][] for instructions on patch submission).
> +
> +You can send messages without subscribing to the list, but it is
> +recommended to read what other people are saying on the list before
> +you speak.
>  To subscribe to the list, send an email with just "subscribe git" in
>  the body to majordomo@vger.kernel.org. The mailing list archives are
>  available at <https://public-inbox.org/git/>,

It's unclear what that means. I *think* it means "consider taking a look
around the list before you post", but then it's probably better advice
to tell people to skim the archives first to get an idea of the traffic.

E.g. if I page through the first 2 pages of public-inbox.org I get
messages going back to the 19th, but if I were to subscribe to the list
I'd need to wait 4 days to get the same mail.

Which, in the context of what this follows (how to submit a bug,
questions etc.) isn't a good use of time for the person reading the
instructions.

Maybe something more like:

diff --git a/README.md b/README.md
index f17af66a97..dc175757fa 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,12 @@ the body to majordomo@vger.kernel.org. The mailing list archives are
 available at <https://public-inbox.org/git/>,
 <http://marc.info/?l=git> and other archival sites.

+You don't need to be subscribed to the list to send mail to it, and
+others on-list will generally CC you when replying (although some
+forget this). It's adviced to subscribe to the list if you want to be
+sure you're not missing follow-up discussion, or if your interest in
+the project is wider than a one-off bug report, question or patch.
+
 The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing
 list.  The discussion following them give a good reference for
