Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D581F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeKLTS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 14:18:28 -0500
Received: from fallback21.m.smailru.net ([94.100.176.131]:57240 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeKLTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 14:18:28 -0500
X-Greylist: delayed 2334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 14:18:26 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0U2vyNs1M7bgUk7/NGGcsZG6MymntEo4CciKuw/Mq7g=;
        b=tTcwud369q97/VMsfkhQv1YiqYUrJouRYY0qNpPJG5Ub4ykusLbptlAXaaDGL/62Be2KlSPE4luX1GVTjWBs/W0VV+cYjjrJW0Q5E/JhT9LkwWbyNULF6yXoMV/U6Jfc4vyS+tssHUJBuQYWjDJKD2kTRUT9fj0ZZDAkXG/9nVk=;
Received: from [10.161.25.36] (port=41470 helo=smtp59.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1gM7sN-0001Zp-9Y
        for git@vger.kernel.org; Mon, 12 Nov 2018 11:47:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0U2vyNs1M7bgUk7/NGGcsZG6MymntEo4CciKuw/Mq7g=;
        b=tTcwud369q97/VMsfkhQv1YiqYUrJouRYY0qNpPJG5Ub4ykusLbptlAXaaDGL/62Be2KlSPE4luX1GVTjWBs/W0VV+cYjjrJW0Q5E/JhT9LkwWbyNULF6yXoMV/U6Jfc4vyS+tssHUJBuQYWjDJKD2kTRUT9fj0ZZDAkXG/9nVk=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gM7sL-0005H0-7h; Mon, 12 Nov 2018 11:47:17 +0300
Date:   Mon, 12 Nov 2018 11:47:13 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Martin Delille <martin.delille@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Add issue management within git
Message-ID: <20181112084713.g344kksb2bf33dzb@tigra>
References: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-77F55803: JXxPhqsJyJxaeFBL0qwpQZiHhPxsSuMf4pb4u6wtqbyL7fNqRXFqpqzYVQZlvxXSKAKAl54weYE=
X-7FA49CB5: 0D63561A33F958A565D167DFC16C5981A1BEAA71F1ED4DD39D0985C91518193A8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249D827CA74CCEABFF33AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE72AD3B10CAD5CF02BDFCF47C548E65BD175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA43E79D5E45FCD6B6E8BEDF36A45716AA6C87DFF528253291DFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-77F55803: 6Ns2ePE+8+B/n1JIXLWE1ycf199igA/c0KIGMNloeeRlZc3rv2Jjiq4hRz6gAPyuhrVpcgAMT50=
X-7FA49CB5: 0D63561A33F958A5D71E091E28E17E8396C3293C970424B14B409E133AB2B0928941B15DA834481FA18204E546F3947C062BEEFFB5F8EA3EF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: A5480F10D64C9005C18DAE012115204D56427842528889B16565CDEBBF62638A38FB88F2046B4192FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 11:50:00PM +0100, Martin Delille wrote:

> This would be awesome to handle issue directly with git: Having an
> offline version of the issues synced to the gitlab/github issues.  A
> lot of work is done on the issues and it is lost when migrating from
> one service to the other.  Beside we don’t always have a good internet
> connection.  There is already a kind of integration between commit
> message fixing issue automatically when merged in the master branch
> (with “fix #143’).

[1] is the last discussion (of many) happened on this list on this
topic. Please start there. It also contains pointers to past discussions
and past work done on that front.

1. https://public-inbox.org/git/CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com/

