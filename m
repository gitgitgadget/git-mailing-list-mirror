Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D731F207FF
	for <e@80x24.org>; Thu,  4 May 2017 05:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbdEDFXf (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 01:23:35 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33739 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbdEDFXd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 01:23:33 -0400
Received: by mail-pg0-f53.google.com with SMTP id y4so2568883pge.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jjhPvCcS9x8V+8P2YIX2Qfir+cXdu+Vwj+4m/y5A4/k=;
        b=adAxqYIiLmWsbazT5cDfD+p5JSsd0Ymww3I03kIg1RcV6ZodY702uCfrgTqGTlKvVY
         NNGTp+pjfWs3DEsir/elrPEGfvvqxIdCRGOqiu0c2AjTRDVBOiYdUoajjBqGmNZ2DBEj
         s99W1uEmGS7bLI3SdugGN9ZJz9llnPMPh2mRlqF74t7vbfPGbqSntiwLKJYKr43Osq+9
         EklDDem8udbYPFMg3Ab72hLCkLFya5bEyExLyTC6rZAozZ2c7n5EPIpjh6vruDJi+Yr6
         RLe4bR28cqJLeJ8QDVv/A/E74oCPlXX+SOa5TXKjWsUQ4MmBXuWwG3fOYIG0Snx3qGQn
         XKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jjhPvCcS9x8V+8P2YIX2Qfir+cXdu+Vwj+4m/y5A4/k=;
        b=Oc/8lcybv4RWMD8wPg43GCutPdl7+uh4siw/TKA13ey9LA9+KpjFo5t7yi8I1HGmAw
         uXNsoKmEkF/3LFx99BDllh9oQU/7mekaruDuCUkiJH1JZcxnb+AlqLYMR5Q1R3P9JHe6
         tDFZgavwLCZAIhTH2fd/zR0j4EF+ZQtbyqMMk0xF1yCIz+v3QH04mOkp3ZNvg7CLefkR
         VGPauL4s4PsFmKi1mMgQ417vM5NJsM7HJFDLux+Mu8ZLRj5OiLGjXDtb86jUJ1hWlbOy
         bs9+JqUMw8iwdYcZYwmsbYJW7yFYIV1YQJjuZHGsycUDCUmnj/KLESNiV6oU3oJaEGE/
         ck4g==
X-Gm-Message-State: AN3rC/6iu7DZciilGMrKeRHPY+THuiWwEdlhtV3tqaWeZJhVFcQaQMbP
        thGfN6erfeWGAg==
X-Received: by 10.84.233.196 with SMTP id m4mr23537996pln.177.1493875412576;
        Wed, 03 May 2017 22:23:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id w23sm1402790pfl.133.2017.05.03.22.23.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 22:23:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rashmi Pai <rashmipai36@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report: Git Stash; spelling mistake of stash followed by a yes prints character 'y' infinite times.
References: <CAOqCAXTN6_dR=+As_i6yxOL+A3dOzs4bM5Lzbj6qzyT_3ecRcw@mail.gmail.com>
        <20170503094709.rn252pina4vdm6lv@sigill.intra.peff.net>
Date:   Wed, 03 May 2017 22:23:31 -0700
In-Reply-To: <20170503094709.rn252pina4vdm6lv@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 3 May 2017 05:47:09 -0400")
Message-ID: <xmqqlgqd9ovg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 4. Now git says git: 'stahs' is not a git command. See 'git --help'.
>> 
>> Did you mean this?
>> 
>> stash
>
> After this step git exits, and you're back at your shell prompt...

Perhaps the suggestion message should be rephrased not to sound like
it is asking confirmation?
