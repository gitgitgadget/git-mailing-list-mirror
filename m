Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7121D1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbcHOUTi (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:19:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38783 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcHOUTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:19:37 -0400
Received: by mail-wm0-f52.google.com with SMTP id o80so125173943wme.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 13:19:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XFzWAtAuwKWubhMc3jZdDWxyyRqUv5PNgpT4Sa6xvC0=;
        b=vbR/xvtklAPWIVCGRE3GkJtApmIJNuDlShGKFXr23tYYwG48SH5FfEn6GcdQAeKS9x
         UuSo6dQ3gvtKrIkEHKX9omi06ASi/45Vbmnugf5TNk+oTexoL036Jzm02m7Da+/+v953
         2s7qDrf681y1Q4ycpgmJR9yKWeugeIQef68XvRMSVFzLo0n5KRT885msxxebXs5bFxHB
         n3Rq0GW0hhmL3E9NIL7ekP6SfP2FK+bzh3qPSoc/rXYmFDTorIs8rv+dkLafh6+1l71f
         PijbFKk4AauL05dENLZYsozBBP/beuqYdOGP1zpzD/YVmaRJfC5kfUNPBMh9my8cNw60
         VYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XFzWAtAuwKWubhMc3jZdDWxyyRqUv5PNgpT4Sa6xvC0=;
        b=b5rMDhY1XFVVdsXenpTGTChwuVlZdWNqD4OZ2Tp4dxGJdSy6CIO2T3iS7bWyceTH8n
         K52XbpDPCklftFVKdzgWIgSww8F6wy4KuI02iKrWDOQhMM259OrJy7RXPPdxtOnWvLUx
         HmEM+T1PyHNujeb24KRIEZAYIhyB3wooEgPwbclCgLJuZmkYyL5RAoJx0N2uQS9xv8BZ
         cZeD8sESUDfrLD9p8KO0NPlYPRsebqJ4sWR+mCIJzsg8Wa2FRbhJOdnWa1SHaQsNdh89
         uAemu0ghH/lc8ujBasGYIkwdG11okvcAWhpSJw5O0DXI33M7RgG+KzNieuDj9MaSBFHX
         rF2w==
X-Gm-Message-State: AEkooutQM5esTGfW/HDImQUaZGB4Hnaapj+6RmJzu8QqRfRaJL14YpsuP/NdpJ1wG8i27OfVl2T4Ld9mLRPXBg==
X-Received: by 10.25.154.10 with SMTP id c10mr4782153lfe.72.1471292376111;
 Mon, 15 Aug 2016 13:19:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.144.203 with HTTP; Mon, 15 Aug 2016 13:19:35 -0700 (PDT)
In-Reply-To: <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com> <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
From:	Luis Gutierrez <luisgutz@gmail.com>
Date:	Mon, 15 Aug 2016 21:19:35 +0100
Message-ID: <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
Subject: Re: git-mergetool reverse file ordering
To:	John Keeping <john@keeping.me.uk>
Cc:	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> Thoughts?  Would you be interested in helping work up a patch
> for this idea?  At a minimum we should also write a test case in
> t/t7610-mergetool.sh to verify that it works as advertised.
....
> Why not reuse the existing diff.orderFile config variable?  (Also
> supported by the -O option to git-diff).


I'll be happy to write a testcase, and to re-use the -O
(diff.orderFile config var) option to git-diff as sugguested by John
Keeping.

Is this the final spec?



I'll be happy to do that.

Luis
