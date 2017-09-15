Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E7E20281
	for <e@80x24.org>; Fri, 15 Sep 2017 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdIOMkA (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 08:40:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35960 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdIOMj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 08:39:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so1183641pfj.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=cxXjB1BGvNr0yAnQbYVNQ1tYWwvqzYUBknsvI5Ghce8=;
        b=fVaxOvtxae9KqXUmTkzXdqAiQav7SlkrDBeBjls6Z0VB0D18ZOL2dZ4FoopXZv6KVn
         GrTdE2cVeBBoAEAoBnyO6XgKrpCRCcIRH8CxTZEHfNJIOwoNTwr76G1T2BjeeR2lgv2Z
         JO01TCU+MctZOtJiIfx7KEBTRDvtrn6KbrVKWzBNVvJctUeIHnTr3RoomL0HVsM0AEPx
         U8IfDR6fR7kE6yFDmPfEJgLvIPIXrE4a4Wdj+JZI6wAsNHGoPrRllEgvVp9lGPCvZ7nr
         e/M897xn+YENLj8fwZ2AtgiV7XNY27biMbR/dQtFcN9XthPeB+CUCBgM9kiIXGA6oeny
         Kwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=cxXjB1BGvNr0yAnQbYVNQ1tYWwvqzYUBknsvI5Ghce8=;
        b=JoK5PdnTvBiqBAAnHhGv2onzCswhB+hP6rY8g8aDkBCro2ICo9DIgnJPwrHc6PTMPk
         Min1L677HZI2iIxOZqL8gS/PwtEzF/lrVJCO3Aq8K8g5amFNM5bQVudZwVuUC+bOMNV8
         peNcdauMJB0XgnH0vFqQXUKfzkX8zklAbOCNi9UJmWGUTVUyXbF6eIFHl5ohAWxOafJL
         XQEbIpIAJPjTlGJMRJY/aUllVfdhVWIDtHAC8739OrAVZgX0ynsO2LkrV+kA/+tJaW8k
         Kr36T9+C68lIdeYKzPooP1o857ucY4JD09dBpNYBZXuqJMNVTDHZf+qB9hOTYyBg2Ps9
         hNHg==
X-Gm-Message-State: AHPjjUhGp35fypTpn7OjIzzHP2J0Ucdu/8oBw6p73wItvnXb61+hEjmb
        iOaY0jxv5CAo4g==
X-Google-Smtp-Source: AOwi7QAiUU1S3WTLmpKa9FRBNShp9BjnIYwjApRQTdrrUyVfKp/H0zIQi5mVkHLGClB3vs4pXT7HFw==
X-Received: by 10.98.1.66 with SMTP id 63mr5380936pfb.213.1505479198930;
        Fri, 15 Sep 2017 05:39:58 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id b68sm2483041pfk.23.2017.09.15.05.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 05:39:58 -0700 (PDT)
Message-ID: <1505479183.2638.4.camel@gmail.com>
Subject: Re: [PATCH v3] commit-template: change a message to be more
 intuitive
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Michael J Gruber <git@grubix.eu>, gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
In-Reply-To: <a8bfb8dc-583f-3126-bbe7-55cb845f1037@grubix.eu>
References: <xmqqefr8zouy.fsf@gitster.mtv.corp.google.com>
         <20170915045025.4272-1-kaarticsivaraam91196@gmail.com>
         <a8bfb8dc-583f-3126-bbe7-55cb845f1037@grubix.eu>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 15 Sep 2017 18:09:43 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-09-15 at 12:00 +0200, Michael J Gruber wrote:
> Kaartic Sivaraam venit, vidit, dixit 15.09.2017 06:50:
> > 
> >  I didn't expect the least that this would go upto v3. In case anyboy finds

That's should have been 'anybody'.

> >  something wrong with this change too, it's a lot better to drop this altogether
> >  than going for a v4.
> 
> That happens more often than not :)
> 

:)

> Your original intent was to avoid any misunderstandings, and all the
> comments and iterations made sure that we don't trade one possible
> source of misunderstanding for another but avoid them all.
> 

Of course they did. 

> I consider v4 to be a strict improvement over the status quo and (as fas
> as I can see) to serve your original intent as good as possible.

I thought I shouldn't go for a v4 as I feared it might make things
worse than better because the original sentence wasn't that confusing
in the first place ;-)

-- 
Kaartic
