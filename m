Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485DB1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeIKAsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:48:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37073 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbeIKAsM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Sep 2018 20:48:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 58F9B21B03;
        Mon, 10 Sep 2018 15:52:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Sep 2018 15:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=3U1YuYJqQw2Pk5DOHKPCJ8sOpqSSt
        yU7B2kqV9FWd+I=; b=l3G8gC07nk9zpKkK+8W3YyPCF6T9leHYx7MhsBzOX/TmU
        IO+64BN2eQjZI5bLuTrA1cf6va+W9d2RJk2zqS5josn70IyroI+uT5Ddp161mgBI
        rfp3B8XGkRJ62SFvZjczn4Ijjht4ciVLylqFdQ3op3eZs6m51WFBvxLcCR5mv2fW
        gEoJ0PmAJGr9Nj5FTLkvlekNfCpUi5nUbIc36QJnSZRqBpUEl8uNUQAorRxSTJjS
        erLAoOIgP3ulxN1UsHYhQI9P7H3AcKPsL6rrxOaOAE4DuJ961oZh7HTqc7x5lhSl
        xXI8soFXKca78xkSXx8Sx4GL9mT2rSvXVF1afc06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3U1YuY
        JqQw2Pk5DOHKPCJ8sOpqSStyU7B2kqV9FWd+I=; b=bJn82DcTOUXDsPigGOjNk8
        OD/vzTEwRa9DhPMI7itLx5qnwAv4gDtmPtX0OfNxVwz9FpPsper2WV6+jq4Hxrsb
        t4eZ+cb0XVoOrABiHCO8VGd+LETgKMl3tfggF7J12ZdjHChROq2BLjCj5jyftgNp
        3ES0sbxedml0eS14kbPg86zwsRTo9ou+1nEapycYowcTR0GKh7q3hJ8gWB72x3kD
        dndc+m4LRdy1fihbrilLK7EuPlyvau6aeUdSlwYBgKUkgjHBOqbBJu84zcwyIJRy
        /UFdQ6TPel2ONxZzmCV+3JVkOv9FLXiLFWMAul/e6+euVhfsZKirTtnfoZWgMOBA
        ==
X-ME-Proxy: <xmx:fsuWW6ah2fbnHhcGKNfsVZpQX4B-IGn6rm4mDPGhA_wqgaT1v9RQIQ>
    <xmx:fsuWW9ntNc_UJbgmA1-MG_SaQ1icuOVuL_M_IxKsAD8OWQojIejmng>
    <xmx:fsuWW2yEjUefwzwWPxKLgr5qWOtOs1muHFp1FQw4E77H9lC48vQixQ>
    <xmx:fsuWW7PnkEEksShhzCGXrqwSZv2tbZRoZ-Xz-k81gL9QXrpuwtQDGA>
    <xmx:fsuWW6RkeYuVgfmy2yd6QvR5ZPQZmr5pbar0iG1l27F1nhREIQZvOg>
    <xmx:f8uWW6UNDIT0i8N568FiY7f-CnHyzRXxO0xuzAYMw-lwmACLSZ0-Vg>
X-ME-Sender: <xms:fsuWW7EhjiMtB5iddFPT_O7-ABneGFQJsqz3YQ64tUzjFWh96I7DVw>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4641A10294;
        Mon, 10 Sep 2018 15:52:30 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <20180908212256.GB31560@sigill.intra.peff.net>
 <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
 <20180910171422.GA26356@aiede.svl.corp.google.com>
 <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
 <20180910183557.GD26356@aiede.svl.corp.google.com>
 <xmqq1sa1tb4p.fsf@gitster-ct.c.googlers.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <b6446834-04e1-ca65-350e-5847e689e2ea@stason.org>
Date:   Mon, 10 Sep 2018 12:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq1sa1tb4p.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To add another report of a similar problem, of silent skipping and not
of filepath quoting, I found this one:

https://stackoverflow.com/questions/31203634/git-clean-filter-python-script-on-windows/52264440#52264440

The user created .gitconfig and added to .git/config:

[include]
    path = .gitconfig

Not realizing that the two were not in the same folder. And probably
assuming that .git/config was referring to the root of repository, and
not relative to .git/, which is a reasonable assumption.

Of course he had no way of resolving this as git wasn't telling him
where it wasn't finding the file. i.e.

Can't find: ~/myrepo/.git/.gitconfig

which would have instantly told him where the problem was.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
