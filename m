Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF9E1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 06:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932717AbeGDGjB (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 02:39:01 -0400
Received: from mail136-9.atl41.mandrillapp.com ([198.2.136.9]:33590 "EHLO
        mail136-9.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753518AbeGDGjB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Jul 2018 02:39:01 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 02:39:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=jlGwiY6F9o85Iqd1qWTsFeGdJY/x8K3GF5oGTUOpab4=;
 b=QD7RbOss06FhTY0LPSA9COLhvErvL+MeScF55XWJ1ppGXDU22TEpJpbWKRDl2K3cWjkqR9WPrTr2
   sw9lFtenLfmqoASWTQvlGynnF6Y0TSa5CAtLBxvAG4lRu4S/Il+1vWKTkTaFk7YNtslintT1CmlT
   JhgPXygNnz9Q5xC0S9U=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail136-9.atl41.mandrillapp.com id h7hloa1sb1k3 for <git@vger.kernel.org>; Wed, 4 Jul 2018 06:23:59 +0000 (envelope-from <bounce-md_31050260.5b3c67ff.v1-e1824fccfcec43ccb1262cb199269b92@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1530685439; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=jlGwiY6F9o85Iqd1qWTsFeGdJY/x8K3GF5oGTUOpab4=; 
 b=hIWTr26MRmUAJ7cblB30mPRxjq826F6K/Vt7Zctgi2pDMeEIuMzj4tBYyuqwQ2tNzC2Ign
 bW4z3mVrowHjyJ6304AxI3lh/un6+vBDgIVqEggku/KQhPrbmllr/4AHaV21LSXIfhSeEvhA
 1+cejZ0+iFRSdbZ2qBdRfRqgwxH2Q=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5500: prettify non-commit tag tests
Received: from [87.98.221.171] by mandrillapp.com id e1824fccfcec43ccb1262cb199269b92; Wed, 04 Jul 2018 06:23:59 +0000
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
Message-Id: <20180704062353.GA24862@deco.navytux.spb.ru>
References: <20180703165518.GA29295@sigill.intra.peff.net>
In-Reply-To: <20180703165518.GA29295@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e1824fccfcec43ccb1262cb199269b92
X-Mandrill-User: md_31050260
Date:   Wed, 04 Jul 2018 06:23:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 12:55:19PM -0400, Jeff King wrote:
> I had prepared this as a squash-in for what became c12c9df527, but since
> that's now in master, it can go on top (or get dropped, but I think it
> is worth it as a style fixup).

I'm ok with the patch. I thought it was already squashed in into my
version, but maybe it got lost.

Thanks for this prettification.

Kirill
