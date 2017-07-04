Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4B6202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 20:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbdGDUD0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 16:03:26 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36374 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdGDUDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 16:03:25 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so119063823pfl.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=iu9Am5RNKlAyZLpGdLmdmvYpeH0rNhAnZeGG4acH7CY=;
        b=ZV8QffJ55MxPrAJRiSyRQt7w6AZ9VzETVrmRCSEDmbXH8FoqoLwB9+rY8NFjOqRMiR
         Sm6JEuo15cnfIHGfq4Pxds+TrKCsfI0uG2+jMtS+cC11DBsi4/p2dmRalePglJOssLiH
         ZX1LsC6lVzRURdKIIY+q/59HbTft3DK/saHtytCCD0rJyi1j+d7e8W/9vPmVf0vJ026G
         pIYFN6rFm9KKfoNefO1AHVeCXfywJzuQhAJFUTzjxev2KAz7hSOsjBc8zYspjRFaVkjr
         Do7ngO2HUBu2JeiwO9HGWW/uIt+AVy/Wk6AExlA+0oRPq5J5iDY/B7tx4uqAAuwshOoO
         DtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=iu9Am5RNKlAyZLpGdLmdmvYpeH0rNhAnZeGG4acH7CY=;
        b=I8uyfcN4ic+hCx4ahyrZI5tZbfa2OWmgJhXFp6cN17ZMySLpgh5cvFHPU4tLYrvspo
         sMlJ61x5UNC6Yq/96COk/amqUQJRdH7AsDwxbCDPgwDP3v3oyEJncA2BVujwKqIQ4gtG
         aCGbNSaEZnH0qIVIuRxG1K4b8n/1GO0SfbHRokdY9be6SzF8TEH7gsEficP2u16wuSBc
         +HK5GIMZpkzlzMKDbicFMS4V2Z1oOM+xwF54R9g8QH8jraabtFMbBVZCeWEk67GE67od
         FiqOVnqMqW3kbGzh413uqp+iKHfb08cTsaJrLtSzFURlyinjNrM5Gh7TBtHwsGvkMlZF
         oRug==
X-Gm-Message-State: AIVw111yw3ifLNOriuNQDh7AVhGEhTyr/3p/UPpDEGhCMSom0gjc+eEQ
        9f2NAmDkPGVXZA==
X-Received: by 10.99.117.68 with SMTP id f4mr11172135pgn.56.1499198604626;
        Tue, 04 Jul 2017 13:03:24 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id g15sm41650956pfe.70.2017.07.04.13.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 13:03:24 -0700 (PDT)
Message-ID: <1499198607.6428.9.camel@gmail.com>
Subject: Re: Why doesn't merge fail if message has only sign-off?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 01:33:27 +0530
In-Reply-To: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
References: <1498996988.26970.1.camel@gmail.com>
         <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-03 at 10:21 -0700, Junio C Hamano wrote:
> I think that it is not by design that it doesn't fail.  It's not
> like we decided to allow s-o-b only merge because we found a reason
> why it is a good idea to do so.
> 
> So I do not think anybody minds too deeply if somebody came up a
> patch to "fix" it.  It's just that nobody tried to create such a
> silly merge in real life so far (I do not think you did, either--you
> found this out by playing around trying to find corner cases, no?)
> 
Yes and no. I found this out while playing around with the "insert
notes in the commit template" patch I sent previously. I wasn't trying
to find corner cases, though.

-- 
Kaartic
