Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C42B1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938861AbcIHVpe (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:45:34 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:42548 "EHLO
        homiemail-a76.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S938842AbcIHVpe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2016 17:45:34 -0400
Received: from homiemail-a76.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a76.g.dreamhost.com (Postfix) with ESMTP id 15E2945807C;
        Thu,  8 Sep 2016 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=bFJ1y
        hg6XJ3Pnb2dNhiI+qFT8+I=; b=IyExTDWO5Dxo6NxU238tTaLOGAxsi2EdGSv0o
        A8vY2WTrTlOVbsYu8MeMAXGOaIG5rXltdbXETcIWTu7mXBXpIB/ZMAL85q2jqM1C
        zDFc/K8DeLMNnQy/6oGWzM5lEHpU78XI8Z1x6JfEx4gNMFq1NzJp3f57536UGVnT
        OHGV4I=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a76.g.dreamhost.com (Postfix) with ESMTPSA id 46659458079;
        Thu,  8 Sep 2016 14:45:32 -0700 (PDT)
Message-ID: <1473371131.9503.5.camel@frank>
Subject: Re: [PATCH v2 38/38] refs: implement iteration over only
 per-worktree refs
From:   David Turner <novalis@novalis.org>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>
Date:   Thu, 08 Sep 2016 17:45:31 -0400
In-Reply-To: <d4e799241de9186f05187d820707c103bc5b4e8e.1473003903.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
         <d4e799241de9186f05187d820707c103bc5b4e8e.1473003903.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other than the duplicated sign-offs, this series looks good to me
("Don't act surprised, you guys, cuz I wrote 'em").

Kind of a funny place to cut it off, but I guess it makes sense.

On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:
> From: David Turner <dturner@twopensource.com>
> 
> Alternate refs backends might still use files to store per-worktree
> refs. So provide a way to iterate over only the per-worktree references
> in a ref_store. The other backend can set up a files ref_store and
> iterate using the new DO_FOR_EACH_PER_WORKTREE_ONLY flag when iterating.


