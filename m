Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14ECB20401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdFURlp (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:41:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33600 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFURln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:41:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so23627563pgb.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=ZedipzDpcJyf2wDZ+oo4xMBhnoqjHx3PLw1QhZthOJ8=;
        b=o8cM2sJyVHt43brlhHVP9I+pevycPMQXB/rcNbX2JL2psy5EWVejHnYM3tI2uFUILR
         /LpeAK2XZkL0W1YhMzFsFG9Y0lAG8F5v3Ec003FH/AQDaUiOdwIT8Zh4lsyb2Rdds2vI
         lQPdcWLsXHLlZVqExDED8DecKcNtTlp8yAmPvWj3WtijA4FeIvXqygPuarPl47L6k8UC
         Js0/BZzVuGudc6sWADF36/5yngaZ+zSwLEyvKzbQ8Tmuhp4B+rhxJ3AisWseKdt7rWaS
         WL9lWq+QTJEHPM7YsegxvkzpuW/KkYFqdgcJ0Xz582qdV4e6dqGIS5hBo7ahiuU9PIhj
         x27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=ZedipzDpcJyf2wDZ+oo4xMBhnoqjHx3PLw1QhZthOJ8=;
        b=IlEA8PYfxseoeEJhWRc2VfEKVITqVF/yhE8FZubvxgtrTp9f0FHIYaKXADDGT1k0mz
         IOTzSumbVAymESm5zEIiT5Um+5DPTbftcK1z1d/c04O4degpkHil9jFcY2Rlu411y78q
         GSLWCs3QYOizRyOozKvVHQkDImsL9RvWCAiv9M+t9P4Bx5/7SwgAiSo9DwQ7+mSaiIf0
         PlVY1hZeqMHr9AR0FGMSGyakva0X3BiZTCdZ18El5PsNHybQBDJOnLrvulnFjqaDSU4c
         8pIzxRFuXE3hsd0HbasCG28YL3VxHURbc6JjzZOF1gJFDmAr9TVin8PDSSX8q1pDULp5
         BfkQ==
X-Gm-Message-State: AKS2vOxBg5IsbywefFmjZxCTaXMMgolpQ2+vmStxEh3GS0dxzWu3R6ux
        wlI4Gb4IGpQrq9uwCQWU9A==
X-Received: by 10.84.217.137 with SMTP id p9mr38334579pli.80.1498066903139;
        Wed, 21 Jun 2017 10:41:43 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id d62sm697112pga.2.2017.06.21.10.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:41:42 -0700 (PDT)
Message-ID: <1498066891.32360.1.camel@gmail.com>
Subject: Re: [PATCH/FINALRFC] Documentation/git-submodule: cleanup
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 21 Jun 2017 23:11:31 +0530
In-Reply-To: <xmqq4lv9s4lr.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
         <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
         <CAGZ79kbJB8dFUYu_70TAYbFWxLQiACEWMrE8M71GSEpnXqqzQQ@mail.gmail.com>
         <1498014140.5419.3.camel@gmail.com>
         <xmqq4lv9s4lr.fsf@gitster.mtv.corp.google.com>
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

On Wed, 2017-06-21 at 09:11 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > Helped-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> > ---
> >  In case no other changes are required then this is the final
> > version
> >  of the patch.
> > 
> > 
> >  Documentation/git-submodule.txt | 49 ++++++++++++++++++-----------
> > ----
> > --------
> >  1 file changed, 21 insertions(+), 28 deletions(-)
> > 
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-
> > submodule.txt
> > index 74bc6200d..6e07bade3 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [
> > --reference <repository>] [--dep
> 
> The patch is heavily line-wrapped and whitespace broken, unlike
> previous patch messages you sent to the list.  
> 
> Did you do something differently?
Yes. Sorry about that. Due to some issue with the firewall in the
network I use, I couldn't send patches using 'send-email' so I used the
email-client (evolution) to send the patch believing it wouldn't damage
it. It crapped with the formatting. Sorry again, will be careful in
future (for which I have to find a work-around).

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
