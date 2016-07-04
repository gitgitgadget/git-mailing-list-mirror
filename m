Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E80920179
	for <e@80x24.org>; Mon,  4 Jul 2016 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbcGDPSA (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 11:18:00 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35045 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcGDPSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 11:18:00 -0400
Received: by mail-it0-f44.google.com with SMTP id j185so32036473ith.0
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 08:17:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XpIfdZukNDvU8x3eJVCegw5rrNR3zgZ0gEMWLm0RGAM=;
        b=rch/YdNaU6aTVRdO07c1V6hziym7gZYGQkZd4hGDw5vzII1yDNSqBuKnbEA6xZZ+pl
         /MEL/LFPwq1wxSO9cjbODig4qoSA87w4vUrJi0RnLJNk7F7lztIOT8nAc2JofZ5Hp+5Y
         PtRDuqrJTqEuKUnpALIhbn180fJ3zWndkPcrJVw720HIFI0+x4X3zlA5LQq51gBduSYt
         ht+lbWSD8SnIxfs4NdrzKrZicN52kSpXKqrJ9rkWqiWh6ou98FakouOL/57d14GYP3sN
         PL/fRfo5xRbQfbshkaLGEnE8yfWBYo53vR5IrJkH0RbusIPbbPu15lq9qVMk4YzoNzf5
         OvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XpIfdZukNDvU8x3eJVCegw5rrNR3zgZ0gEMWLm0RGAM=;
        b=Ck7o8Nu6RGalsg8kKAANpvi2wF9kmtjLMnauGDsmFR3WhdodaQgLflOiZyM7uYccuj
         DOuCeA+ewOesvqInVrXAC6q267UaLN+NXDYsIbBZV481boB9BDrS0Ti1SCI3k9R8lA/9
         Om3Gob6Gv6B0xkbfsuMKTkkMvqERe0Plvj0BDeMzp9jZPSV5awW6X2A/ZD9xngrbuA+X
         2VPn8mBBgGTGSC35w47cUAu6P9xv9c1bI/NUkBx6siyXQXFB9A1ucLsMQo6/d0+MiLLs
         16hxZaGgB1SLxcn6XvHWYgtUrufFxaVzi5IkSze0UTDuGo80D5e09xPlrwK2Le/N/2uK
         IAtw==
X-Gm-Message-State: ALyK8tJ/Q3/Ez1pnNzX1uwtQU+NfbpHgz83SRhAF05V69NcqNW3tNHLxGfIDieS569tvUiq8AByllrWXA6Tn0Q==
X-Received: by 10.36.123.199 with SMTP id q190mr9858416itc.42.1467645479251;
 Mon, 04 Jul 2016 08:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 4 Jul 2016 08:17:29 -0700 (PDT)
In-Reply-To: <577A6DBB.2030902@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com> <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-2-pclouds@gmail.com> <577A6DBB.2030902@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 4 Jul 2016 17:17:29 +0200
Message-ID: <CACsJy8CoSwM9W-HX2X9rA9NbJBVQ8BzySJjp3XjXBK+5r1tXZg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] git-fetch.txt: document fetch output
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 4:07 PM, Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-06-26 o 07:58, Nguyễn Thái Ngọc Duy pisze:
>> +summary::
>> +     For a successfully fetched ref, the summary shows the old and new
>> +     values of the ref in a form suitable for using as an argument to
>> +     `git log` (this is `<old>..<new>` in most cases, and
>> +     `<old>...<new>` for forced non-fast-forward updates).
>
> It would be nice to have documented here also other <summary> formats,
> like "[new branch]", and/or mention that if the <summary> is not usable
> for `git log` it is put in brackets [].

Can I do it in a separate topic in future? We may want to unify this
and the output format in git-pull as well, then include fetch format
in git-pull.
-- 
Duy
