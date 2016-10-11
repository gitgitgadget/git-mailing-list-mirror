Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2B81F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbcJKPH1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:07:27 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35389 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbcJKPH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:07:26 -0400
Received: by mail-vk0-f50.google.com with SMTP id 192so21937871vkl.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0iw6V8sEQ8QreRbi66IKOL+yp6Hpah6B+BJGdTTHzYg=;
        b=kdULLjArJKmoR6nnRwZ8TjZ9hp4a927ElYhHEIEYuc0cI78jcysOmAL/38cvQV8wZq
         Rg6koYbHYM/rmICvMmCQm3iC+YiX6y5aznV/CNer0OXvT7WHxYmCxmM/hy2z2358Z0Hh
         SuOooVFaqlX5tE4GnyixDU8nbSO0wFuBJF33kJSIs78zO6HxLKuECxQCrikABpH89VQP
         pdVtn0EH8HbV6lRkQvfB8XqZaNMfIP750xd3nbZJ/q2o4erSJrrgLeFrroimBAokbbR1
         fsoe9SS/BRR3zDKBIA5PfbARg/EtKQQn3QH3HOjNRkrC04zxVRdAlDs17uRS3HFBSZW9
         rAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0iw6V8sEQ8QreRbi66IKOL+yp6Hpah6B+BJGdTTHzYg=;
        b=Px0muAt6B00XMc8zWRwveWqUYhHqHMOyvEf2u0djIV4jToVrUNMW6yKfm8qKVuBSsx
         uowN2FBG7tM8cWbd6Sgk040X8HX4cmt9I6o+SFIFBCqOFQLMMDbiHPyRyT2dtAOSvgxv
         BwJsyUYjUmJzHevN2MpKIzaAVJ7pz827PmV/MPwvy260/OUPjBmPvsPNy9ahkjWZcmvH
         uZpOqithw2kZiFFCO2xcI+lAh1myvFACWs0tuwOSuXexMJjfieL3FA/sGgpv8bbbDxtB
         /6OsvoAU8fgpXej34JaAYJeV91qoWz9W+6aX0SmhhuIvwsaTqTESHOnTWX+eMkuhXVI7
         tSGA==
X-Gm-Message-State: AA6/9RlfQ6uMUi9Nz2zd4GYQZWnGbFvuXreipm9inmUnUy11fpJTNwpwwsKNNZobV1Nkww==
X-Received: by 10.194.158.193 with SMTP id ww1mr5562014wjb.176.1476198083124;
        Tue, 11 Oct 2016 08:01:23 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id va3sm7115394wjb.18.2016.10.11.08.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Oct 2016 08:01:22 -0700 (PDT)
Message-ID: <1476198080.3876.8.camel@kaarsemaker.net>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org
Date:   Tue, 11 Oct 2016 17:01:20 +0200
In-Reply-To: <20161009123417.147239-1-grawity@gmail.com>
References: <20161009123417.147239-1-grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-10-09 at 15:34 +0300, Mantas Mikulėnas wrote:

> +		s = g_hash_table_lookup(attributes, "user");
> +		if (s) {
> +			g_free(c->username);
> +			c->username = g_strdup(s);
> +		}

This always overwrites c->username, the original gnome-keyring version
only does that when the username isn't set. Other than that it looks
good to me.

Reviewed-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Tested-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>

D.
