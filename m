Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B17202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 13:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdGMNA2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 09:00:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36232 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdGMNA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 09:00:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so6927575pgy.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=M19mVxKTfrbaDomIX1w3TMoeZ2Vozw3ubAGsiHBwTHA=;
        b=uatNKr3bypb9DSpMIJmiiLA4ZWv2r1Vpq1cce6rRHUFO/ZDvlkL/gsG4p7jYz1S752
         xxE7B8K7DwhvDH4C5yOEXJvHdDtj5Vr00gKFFWkAmj0HO1ccDM5p4Um0P3uIz5k4IACV
         ZmMWBS2VtksZtmf7ih9558ZAk5NWuwQW1M5uML+d0rgIklOmOsQrr6H0+zRpHfyoJCzr
         q81HmBLrYN6XB5FaPpM+R6L6t5iZUMqZKKlZW/pj6ErTRNNebTXjEy85lZJCfIODyz1L
         BJW33G+Faq8OX4Xe9/HRwM8JIcalQvFOhHuWFUCIhaj71a+MxcO6mZa5ucHZwYN8jXhu
         xKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=M19mVxKTfrbaDomIX1w3TMoeZ2Vozw3ubAGsiHBwTHA=;
        b=JXtMLQsiZ/gVSpz6DeQt7Q7o6fkw8jhpSf3uXOCzSoJsK+4t1TSbmhMTz/hwqAJqEI
         SVaY2OwQt5rZ6CTlKVxPfQlK/B3X5pB8dhFPC302GQvJA/AWsJY9dSRni+AdlEVqzf2a
         q0pXi2xSYhFLQFQh2CkBHVorvyqJBgVyLg+lMoZ77Tz1KloTr9jvXLmx1FYuzqYsmnLj
         C1+u1A/5trblVH1P/xCbty4+fB4HO6bLK8k5llpZqoWudBPyjXknIug3Oe/vb9HGsVAp
         H0b8RVKu8JLbexZSDH6KQh/oo8XFmI0Gd0ORcIaPFK2kZV5jv1X90W+Qg30LJLY5esXP
         FMow==
X-Gm-Message-State: AIVw113PjA0MWx0/pUG0XGSi4a5vzTlQ/juRnfxuHt5PI7ScXq7mvNKq
        Aw5V8nJo113rP5GYgnA=
X-Received: by 10.99.149.83 with SMTP id t19mr9090662pgn.247.1499950826596;
        Thu, 13 Jul 2017 06:00:26 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id q19sm14028949pfd.24.2017.07.13.06.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 06:00:25 -0700 (PDT)
Message-ID: <1499950837.2427.1.camel@gmail.com>
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info
Date:   Thu, 13 Jul 2017 18:30:37 +0530
In-Reply-To: <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
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

On Tue, 2017-07-11 at 13:22 -0700, Junio C Hamano wrote:
> Having said all that, I am not sure "Prevent such surprises" is a
> problem that is realistic to begin with.  When a user sees the
> editor buffer in "git merge", it is pre-populated with at least a
> single line of message "Merge branch 'foo'", possibly followed by
> the summary  the side branch being merged, so unless the user
> deliberately removes everything and then add a sign-off line
> (because we do not usually add one), there is no room for "such
> surprises" in the first place.  It does not _hurt_ to diagnose such
> a crazy case, but it feels a bit lower priority.
> 
It's little unfortunate that I haven't mentioned the reason I asked the
question that has resulted in this patch. It would explain a little
about why I thought this wasn't "meh" (I hope it stands for "who care
what ever").

Sometimes I abort an commit from from the editor by providing an empty
commit message. Then I came to know that 'git commit' considers commit
messages with just signed-off-by lines as an empty message. I tried to
take advantage of that. I once tried to abort a merge by just removing
the "Merge ..." line and leaving the "Signed-off" line and was
surprised to see the merge happen instead of an abort. The rest is
history. :)

-- 
Kaartic
