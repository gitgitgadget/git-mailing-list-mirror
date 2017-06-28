Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F802023D
	for <e@80x24.org>; Wed, 28 Jun 2017 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdF1Jej (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 05:34:39 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36569 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdF1Jei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 05:34:38 -0400
Received: by mail-wm0-f47.google.com with SMTP id 62so47613667wmw.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzCJFrGpjuz6zWl7NEDN0qCzO7Gyb33mMeAM9u7C548=;
        b=bG9fpPxAkQZ1VlLfjYVQ0e1pKdGa2FIP9Oj8DLGYh6rp9clOgLGB1mDeePTjmexPUi
         wPKQqA1epgIk77n7Tpoa/IfGI/aqVg+8JynT6Eb7qcfJRjY0PrcSuYhutMppaw0jT+jR
         hf5kemXqMla8wIpLCcN23OIrjW4ltTNoWLFQnrSCnPOL1LpRRZ3vX/pJoC0cuLb06/gC
         aFy50XVuAlyUAf37BHbJmNi1KPvH0FbhNRs2mksWDwL8yJzAOF16oLpf+Ze9qwWtPt2f
         meuaHRbGz76Lkp1vg8ko8KqOCNrLU706Gjy5OIaKSZIDGj5XjGddlInvV+t7JdvbL4/R
         Utng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzCJFrGpjuz6zWl7NEDN0qCzO7Gyb33mMeAM9u7C548=;
        b=S7wUSkx5HxkMna+av5CDUeS9IIF3btGEEIAosYJkhvcIMWwykpOtT31QtjufAN3TrV
         XgCn651gDHhaRqQaJAfiU2sqtoRsIwJuPMRSGGTlWMW6i9tzjVT3h/q6bUreF+e0NF3+
         6Qu6UMHQb3PPLoz7KD2a64egdz6ZBUrLnVvt7rloFTUwfg3KXC9CgjerI8apQ0tJHiyX
         eUUYA74hfvEMiGFlnJmAkOMVlfHjKhQP9HYmH7njuCPPwq0H5GPEzc3xnaHPKPGpt2Tj
         U+hTyvqYbnL2eEqVFBDaEMoMblC2L6tAVGfeTYX5YOqbF/vuC9/hJ0s77zDawd4bud9h
         soHg==
X-Gm-Message-State: AKS2vOwijwtlO0pAc/hyMQ0holTE+tu4jtEgN4iUw+8D1FxymafX/a2k
        onTJTDLgIJ0z8Amt
X-Received: by 10.80.165.104 with SMTP id z37mr7053520edb.60.1498642477277;
        Wed, 28 Jun 2017 02:34:37 -0700 (PDT)
Received: from localhost (ip92341f15.dynamic.kabel-deutschland.de. [146.52.31.21])
        by smtp.gmail.com with ESMTPSA id j56sm1336858eda.58.2017.06.28.02.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Jun 2017 02:34:36 -0700 (PDT)
Date:   Wed, 28 Jun 2017 11:34:35 +0200
From:   "S. Fricke" <silvio.fricke@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: remove "-h" from help text
Message-ID: <20170628093435.GD4824@sfserver>
References: <cover.1498591103.git.silvio.fricke@gmail.com>
 <c49b244848de20ad058a46023aeb266f4b361e4a.1498591103.git.silvio.fricke@gmail.com>
 <20170627210906.GJ161648@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627210906.GJ161648@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,


> > This regression was fixed in 91a640ffb6d9 ("ls-remote: a lone "-h" is
> > [...]
> 
> Without this patch, I'm able to run
> 
> 	git ls-remote -h .
> 
> This patch removes that support.  Intended?

*hihi* okay it was to counter-intuitive for me. "91a640ffb6d" talks about this
issue.

Thanks for enlightenment :-)
Silvio

-- 
-- S. Fricke ---------------------------------------- silvio@port1024.net --
   Diplom-Informatiker (FH)
   Linux-Development                         Matrix: @silvio:port1024.net   
----------------------------------------------------------------------------
