Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161FB20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdFVVfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:35:38 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36446 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbdFVVfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:35:37 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so12987548pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9wywWJ0Oon3JGGYY6TjEPEBwUDrnlyUtn0/NvpdCWhs=;
        b=YDm47wxiLdyinSZoYLNsT30AGymAUN1dQlWg1q24srSuxUuykzP026ABX8JOouE/5l
         bpHmXu+oNUnrYNnKf11o2Tu+qO/Br4xVI256yzno+6TbSm5NLMaq5xqvghpzETI/uIBd
         Iiy77TENQc1lMT2TSGfXBR2jR5h9mqOeL/+u4jU4w1vSdTaMbhNwYTbJsMR9zoMJKEYC
         p7W2gBhDjnf9dl9UWtu4vGyfgVkhcUduAW0osYJwFt69ao933WQIjGA4XZBSKU0wxr97
         D9QCLQaaASyr+fe7fu5ioQuIpHO24Zb+IpF+i90BLXW60RddmQvhUygFMN3CSKSjIPQ4
         sxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9wywWJ0Oon3JGGYY6TjEPEBwUDrnlyUtn0/NvpdCWhs=;
        b=D0kxxOBLa8yuWAEow18mm5zL82v+MSZ6EgcfXAx8n/bPvIT97jJO+iHTTSnH/TW/LL
         QACsDmkY+N1cOJLtidv1k1gsPvy/PW8wo0H7QzMzfVGYBderYPQv0GCiyBLX19042/si
         InMLYTp2LVfeJQ00nl7PeXasY03EwkyT0A7vEJWsNlGvoE9dtjHMlaWMeTxDpCxNIgVp
         oB2ILTmlLpUNWXTflxCQQfYniz99PIyrIVwPnPznZmV0jMFo4NxJYqHo034K1GUUiB3e
         inRDsPJiCBRx5rRWIq5HZQEVo8XSKoNDm3naFnGfByLU5e8haj7kJ128Hd8/nShf/tvC
         9m8w==
X-Gm-Message-State: AKS2vOwd6i8i7VnCrhzbTN/OlsBWODclQVVqvKeVP7PN3iUc0mn4l4Uc
        w7suNm4drbP4Wg==
X-Received: by 10.99.127.76 with SMTP id p12mr4741994pgn.258.1498167336357;
        Thu, 22 Jun 2017 14:35:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id l63sm5849529pfc.132.2017.06.22.14.35.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 14:35:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
        <20170622124803.45sduodpfbwuuq52@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
        <20170622134708.fcc4zxakga6p255x@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
        <20170622204628.eintlap4uchlncub@ruderich.org>
Date:   Thu, 22 Jun 2017 14:35:34 -0700
In-Reply-To: <20170622204628.eintlap4uchlncub@ruderich.org> (Simon Ruderich's
        message of "Thu, 22 Jun 2017 22:46:29 +0200")
Message-ID: <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Thu, Jun 22, 2017 at 01:55:27PM +0000, Patrick Lehmann wrote:
>> The description on https://github.com/git/git doesn't reflect that policy.
>>
>> a)
>> It explains that discussions take place in the mentioned mailing list.
>> b)
>> It describes how to subscribe.
>
> However it doesn't say that you have to subscribe to send, only
> how to subscribe.

For that matter, we also say "everyone is welcome to post", which
makes it clear that no subscription is required.

But I view these merely being technically correct.  And making it
absolutely obvious does not cost too much.

>> With knowledge of other mailing lists (mostly managed by mailman),
>> subscription is required for participation.
>
> That depends on the mailing list, some require subscription to
> prevent spams but not all do.

Yes.  But not many people realize that the world they know is the
only world.  We are used to an open list and are shocked when we
encouter a closed one; let's not forget that shock.

How about doing it like this?

 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index f17af66a97..bbaf54bffb 100644
--- a/README.md
+++ b/README.md
@@ -31,6 +31,10 @@ The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
 [Documentation/SubmittingPatches][] for instructions on patch submission).
+
+You can send messages without subscribing to the list, but it is 
+recommended to read what other people are saying on the list before
+you speak.
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
 available at <https://public-inbox.org/git/>,
