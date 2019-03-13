Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B65D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCMJxv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 05:53:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4425 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbfCMJxu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Mar 2019 05:53:50 -0400
X-IronPort-AV: E=Sophos;i="5.58,474,1544482800"; 
   d="scan'208";a="373194587"
Received: from dhcp-13-174.lip.ens-lyon.fr (HELO moylip) ([140.77.13.174])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2019 10:53:21 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Git List <git@vger.kernel.org>,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
        <86va0o9qsp.fsf@matthieu-moy.fr>
        <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
To-List: git@vger.kernel.org
Date:   Wed, 13 Mar 2019 10:53:21 +0100
In-Reply-To: <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 12 Mar 2019 11:48:14 -0400")
Message-ID: <86lg1j6qy6.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> In patch 1/2:
>
> * drop the full stop from the first line of the commit message
>
> * s/futur/future/ in the commit message
>
> * s/There are false/& positives/ in the commit message
>
> * s/both, It/both, it/

Nice catches, thanks.

> In patch 2/2, there's a 'man curl' which probably ought to be
> converted to `man curl` (per paragraph updated by patch 1/2), but
> perhaps that's outside the scope of this patch series

Yes, I have no objection in fixing it but I'd rather limit the scope of
the patch and keep other fixes for another time.

Thanks,

-- 
Matthieu Moy
https://matthieu-moy.fr/
