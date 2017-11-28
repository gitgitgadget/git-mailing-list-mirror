Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBBF720954
	for <e@80x24.org>; Tue, 28 Nov 2017 17:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdK1RYv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 12:24:51 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35252 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdK1RYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 12:24:50 -0500
Received: by mail-pg0-f42.google.com with SMTP id q20so217306pgv.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Zyaect2BuwK+YoeGkEBIlK+yFSC/1e0Rp6LMD3AdzRI=;
        b=EKLyVZ7EnSjNdCzH+o9Ge2P2/NU36LlojAF8E9rMsBqeY2F30UCkNifjSSkrVJUyTT
         UTId8ivD6Q2Wn4VbcGVVFcort2gwOe9HlnppfIhY0UTAJrP+seqmooaXxxxby64rg8tI
         0F36aYVy1HgekBaZX6f99sgyvDj7IquEf7Rfa6+e/5X0X7juy1B2C3hyyNr9fhHETLV5
         XxA5DKBdPXxOliuOIxYOiqjmwl/MqmXzwOKAsEDZzVdGwbd10PKlLjX5C2XzSsZS/Pd6
         2qVJSo8jBQsZGfbsnLjLvl+SGtNAvQVXpx2SpWg2pOmqjuKbrLkjkq98joHuAiU4lFla
         xt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Zyaect2BuwK+YoeGkEBIlK+yFSC/1e0Rp6LMD3AdzRI=;
        b=oxAzGjLpNiQJiBdvHs+bVXfZX6raCjJpNEHSl6hHd+Gq0hTmp+ZtsykPf4THpe7BaO
         7o3qd8gST55TNVIzkQev24X1M+iDrYOyYt1E6QsUK2It6vnq7JLXZYSssnMZcEFlQOA7
         tq5kHCSbzHbvb7eNTd4TFamxrcGhCOg0MlKa4to00qGOZUQ7hbweL52uXPTdOBMSokAI
         KKR67WqjBqmYdg1OIVD7ENGEFr/jE2c+NMbUe91p7FrV/7wtINalk6NNwqMcZCPbpole
         vBZBIKMd1Wo4kEd2T8eiqO1iu5wpZ7CUfP8ng2+chQcWzM7rEVPZoQjRfdSkWxU0AEfM
         GAig==
X-Gm-Message-State: AJaThX4jjF6HJ8ZZAoUw0vRixxK5Y0NVjvs1guh3Js6+XI3Mm4BQdaGw
        ceuNM2TfXtWR6GFm/KFZqfU=
X-Google-Smtp-Source: AGs4zMaSU0sVKKBk7fXyeSV7abXPdqEPJGfs0gYZ+CXcuZwMiZ7tS72nfjzlGmWG6TQk3pCTfubpTQ==
X-Received: by 10.99.109.73 with SMTP id i70mr17569079pgc.258.1511889890425;
        Tue, 28 Nov 2017 09:24:50 -0800 (PST)
Received: from unique-pc ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id p189sm52756617pfp.127.2017.11.28.09.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 09:24:49 -0800 (PST)
Message-ID: <1511889885.16420.3.camel@gmail.com>
Subject: Re: Feature request: Reduce amount of diff in patch
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     KES <kes-kes@yandex.ru>
Cc:     git@vger.kernel.org
In-Reply-To: <372261511885370@web21o.yandex.ru>
References: <372261511885370@web21o.yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 28 Nov 2017 22:54:45 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-11-28 at 18:09 +0200, KES wrote:
> Hi.
> 
> I get often patches which can be minimized:
> 

I guess the one below can't be (see below).


> @@ -60,11 +64,8 @@ sub _get_filter {
>          address    =>  { -like => \[ '?',  "%$search%" ] },
>          company    =>  { -like => \[ '?',  "%$search%" ] },
>          country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
> -    ]);
>  
> -    $users =  $users->search( $filter, {
> -        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
> -    });
> +    ]);
>  
>  
>      return $users;
> 
> This patch can be minimized to:
> 
> @@ -60,11 +64,8 @@ sub _get_filter {
>          address    =>  { -like => \[ '?',  "%$search%" ] },
>          company    =>  { -like => \[ '?',  "%$search%" ] },
>          country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
>      ]);
>  
> -    $users =  $users->search( $filter, {
> -        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
> -    });
> 
>  
>      return $users;
> 
> May you please fix the git to generate minimized patches?
> 

You seemed to have overlooked the empty line above the ']);' in the
original patch. So, your minimized version isn't actually equivalent to
the original one. Further, when trying to recreate your patch I get the
following,

diff --git a/diff-test b/diff-test
index 1d5dc1b..f3ec38f 100644
--- a/diff-test
+++ b/diff-test
@@ -1,10 +1,8 @@
         address    =>  { -like => \[ '?',  "%$search%" ] },
         company    =>  { -like => \[ '?',  "%$search%" ] },
         country_code =>  { '=' => \[ 'UPPER(?)' => $search ] },
+
     ]);
 
-    $users =  $users->search( $filter, {
-        prefetch => { Packages => { Ips => { Subnet => { Server => 'Locality' }}}},
-    });
 
     return $users;

I use git built from the source (2.15.0.531.g2ccb3012c)

-- 
Kaartic
