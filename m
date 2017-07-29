Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E1D2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 12:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbdG2MMm (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 08:12:42 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36521 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbdG2MMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 08:12:40 -0400
Received: by mail-pf0-f174.google.com with SMTP id z129so65539890pfb.3
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=F2E+aKDmi3h1csqTXQnbUEvWxdE8/MDzikXh1rU7quM=;
        b=HxjmS4tjjiiCnwiIQZ7FDSzXDo6gA3LftltzAuNaPWVvj/5xKCE/lgivAycn/dQBEw
         oWIXyb5dE1IJf0awuljIRpohe9S0Wh2uibcZlvoNiV1nS97culo62gGEi/99ELXV9RH4
         H30Vcn3blaPwnapTffd/xxUZT6CJVHBNK8oWqAq+E39XyYOdf0FhPAOI7WHWqZknrvVG
         krkExx/d/yaEJyzLLVuLGOnbHwEhUik6YqyFDdXi8xc4oR87Xgk9RnYSNEhypkGgXxEC
         AOahnyAXWDtNFV0Zh8MonpyVnA0eV+EVZYIwh2uL4bl1i1jXWLNq+VEP/CNYwbN4rsh4
         OKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=F2E+aKDmi3h1csqTXQnbUEvWxdE8/MDzikXh1rU7quM=;
        b=be68l3yxQpN4MD3fkDQcptlPhQJctlQ3pysHyh2xItwvfwSiG6cjUXZ9zi7EJjrp9u
         bnb9tdugxeIrXoSBHTA4xfNT48Zydp7TqZWW5GEPgA+WVpz3BJw0gPAfL6jOMCZKakrC
         t3JBXVMnQDOUc3/yzPuEwFJoa91Xg1QxVZhFrN+Rri8oqWmBsU+GmYgGjl1S6mKb7a3Z
         eh8aWbWSC8iVhnGZyTSCi1LhKncOGVYCPXQHo/9+1R6wLzzx6XCN9T4OAICEQT2dzr0i
         NoW8Abz3mr2Ixjf6qJBd8b5guWk/Dskx8Iow1HhEhLzoKfzUoHh5+RCIrTTeEZpolwgo
         wU4g==
X-Gm-Message-State: AIVw111UF5RWtb6LOeLTi29w4FP/TSROPVCrJ0x3ntx4Ox/bkjYd4d9u
        Ga4oQxPtn8mR/aDX2Bk=
X-Received: by 10.84.128.195 with SMTP id a61mr10903685pla.222.1501330360217;
        Sat, 29 Jul 2017 05:12:40 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id e79sm40859745pfl.40.2017.07.29.05.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 05:12:39 -0700 (PDT)
Message-ID: <1501330390.2001.1.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
         <20170725212110.GG13924@aiede.mtv.corp.google.com>
         <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
         <1501296270.2112.2.camel@gmail.com>
         <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 29 Jul 2017 17:43:10 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-28 at 20:53 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > Though the message seems to be most fitting one, I'm a little reluctant
> > to use it as it "might" create a wrong picture on the minds of the user
> > making them think this would be the case in other cases too, which we
> > know is not true. For example,
> > 
> > 
> >     git log -p --full-diff master --stat
> > 
> >     git commit -v Makefile --amend
> 
> These are accepted not by design but by accident.  
> 
> I do not think we even document that you are allowed to do these in
> "log" and "commit" manual pages, and we should discourage them (I do
> not even mind eventually removing these with the usual deprecation
> dance, but I do not think it is worth the noise).
> 
That's interesting. In that case, I'll go with the suggested statement,
happily!

-- 
Kaartic
