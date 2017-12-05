Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB8220A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbdLETu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:50:57 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:45269 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdLETtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:49:41 -0500
Received: by mail-it0-f65.google.com with SMTP id z6so4428157iti.4
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0oSVMIpA9trSIR9HUZkF57CxQgP577PdZQIfV+NYGXA=;
        b=dZ3VA3mtl2mq/eUK7UYweqgVaDK1MXBXYewmsPO1DTsbxyqGFggfiKDMusGmBXkMAV
         NsLGGoBTLyM2tTKQnDJ5WoFclJpXfbEi8ZFaHm0KChQnmYymxVN4J5JFFQ0TueHJQQqV
         uGgnF3or39kUf3kIIhyX2edoyPE+jXnYAPfo/iBg8k6f3FQ1XeeUlF9JNq0g6o2PW51t
         edp0st85mM03tCVVuOCzYLLl5zlQL3fQ5RZCxYEkoovtd8G3Fhx57pxxilXfXmfXnOxc
         NF+v1W3kgi3+mxEOnaI++os1nUw0hTdni1nCicwhRwjluEbfhrTcQpZwLLhPQrwrJXu7
         L50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0oSVMIpA9trSIR9HUZkF57CxQgP577PdZQIfV+NYGXA=;
        b=acmQtKQTMlEQHrVpzZ7foZHqUSr2fw/3PyYLOQYZpy64joqhpOSZCU/t4Fpf81tcNL
         TGQ5/8cNEjkhsubsbm1H/0SWfXwVxT3gB0jk0AbZaxoEmcej8pdCFC4cTTTKBGgfiStp
         nCtrmSrygf4+sNui02o+kby99UiCRa876yFQDMR5D+Oupd4an321WrveQN0DJinIGjDA
         rxuNKA3TEfT2cY1Avh2/iTfBS/qqlMB+MNDV+LzvD/qnB22pq2BBDoh8bCNdXGeyE+0Z
         mNaoCqvx5r74rNoYODZQWTqxSxlyMl0ZUKAAUIc04133Rk8jR1aXwHW+Bof/lx33xsDM
         97yQ==
X-Gm-Message-State: AJaThX5k+zVAqRWKBMoxCijh/KhPVnokGjm2TBAjcjLZdX2b8SHfLiFf
        aLvjFrYik80ZtIsELX+NXVAppG8F
X-Google-Smtp-Source: AGs4zMaWbfZ1+wcniHSxjxtCtP9n+k+foIJXP0UqwerS5OYvxOeGIEs8MO81niUXhGpsXoHx++hLVg==
X-Received: by 10.36.88.134 with SMTP id f128mr20818914itb.116.1512503380823;
        Tue, 05 Dec 2017 11:49:40 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b34sm528342itd.31.2017.12.05.11.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:49:39 -0800 (PST)
Date:   Tue, 5 Dec 2017 11:49:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/2] t/README: remove mention of adding copyright
 notices
Message-ID: <20171205194937.GB8183@aiede.mtv.corp.google.com>
References: <20171126202100.1658-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171126202100.1658-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> We generally no longer include copyright notices in new test scripts.
> However t/README still mentions it as something to include at the top of
> every new script.

Where can I read more about this change?  Was it a deliberate change
or something that simply happened?

Thanks,
Jonathan
