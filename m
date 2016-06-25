Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C411FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcFYQgS (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:36:18 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36010 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcFYQgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:36:17 -0400
Received: by mail-it0-f48.google.com with SMTP id a5so37443659ita.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 09:36:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xNSe8HYS6qIb7Ysw5MuzSQQDAB7pUu2h0yOUi1G0Scc=;
        b=kVhD10ckjW8vsFr3iVrjZn4TqtWYqdTxwp++EkaLypDSP8vZG+jFHBa4Ard1LCgtHB
         J/hCW/Jj/pfsGtYY+qe326yp/7NypFwqN5KaKXsGLKdry4ZDNKsd8Kkq4Cq0CoeXkiPv
         iGwz9dTiBg72nTYq/yExZcK9eUaU22YYm+uCdA2ZcL9dyjzz3eA7evcCYcsGMdgBR2DH
         8N0kBBEDlbCWVXkAy8qwAD7ItlfgS5ezL4V+uuoTbjTehj5SifVeGGTbQyFAv9mR58re
         mnmd6AdTeW+F4cxiUtmsktDYy6PUSxUO/quAZk2QmxekHtTSP1yJp4VohQSxJOmL5QdF
         AZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xNSe8HYS6qIb7Ysw5MuzSQQDAB7pUu2h0yOUi1G0Scc=;
        b=cCHjILcFXHgdnXGTJVYiSwQggEpdMYGl/wz5bdRfKJC7VstBQT6Zvi9Lf8Slyf0ymD
         GwBOiTjrBWhHaiuewvSxM7WMRyPM0rAaqUTZnEl0GzgipsF1V17QIFSwg7obYUMexkHU
         M8ujzXmnfmJqmKufoZ/sWMtWAX+hfUfs89L0k+FBkLNBbAMSKz/Bv1juarw5yYzDFcoP
         WjL/IpaZmEQ0jmadtBi8uVeFazGu7aJVHkr31bMaHs3icNyA7KrcEXnAhhtKlqgMYpHf
         ++D3LQYfzVWUycYX/rIB6T5nqTlYse0gAq6fZSMDUzMc6I7lVCYBG4CbQFDADu+bFsch
         V+yQ==
X-Gm-Message-State: ALyK8tL8m0leTIr9e3DTcx9UgQcBPMM4CNXS+RN7s/dfcG03Hq+DWVceGAlpFIO2ZCV0fkVI/m1+tmcJ1D3s4Q==
X-Received: by 10.36.43.5 with SMTP id h5mr2879708ita.57.1466872577075; Sat,
 25 Jun 2016 09:36:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 09:35:47 -0700 (PDT)
In-Reply-To: <1463694357-6503-18-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-18-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 18:35:47 +0200
Message-ID: <CACsJy8BRQdWygX1Cp9d_2K7jUx0R5e0EiExmY0_wOA_Hi8TfuQ@mail.gmail.com>
Subject: Re: [PATCH v12 17/20] index-helper: autorun mode
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> @@ -417,6 +418,7 @@ int main(int argc, char **argv)
>                          "verify shared memory after creating"),
>                 OPT_BOOL(0, "detach", &detach, "detach the process"),
>                 OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
> +               OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),

I just noticed (lately) that all options since --strict has been added
without _N() wrapped around the help string and they won't be
translated as a result. If autorun, for instance, is meant for
internal use only (which does not make sense since you document it in
index-helper.txt), you can hide it away and not worry about N_().
-- 
Duy
