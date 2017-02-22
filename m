Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FC4201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 01:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbdBVBUM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 20:20:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdBVBUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 20:20:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so22581034wmv.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 17:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DfUMT7q/Basgf4GK/t6Ib+in2UMXG9rZWdbBfTvl7V0=;
        b=gTr8dBQXyFXLDmMX/8av3fh4l4tLNhMqnWuAPDEYSWEh7M/OQV6EgqqaI9rT6tcRsD
         xT5NUGrpWzjDCIziNS/T7UbPL/Os7bNfueAqmQkY9qL/Iz5RWhGMrwekUZDxO75R9UOB
         Sxi6R3enWStWVcoRoQjcpxXwqVDB+kwR8mUAj5sE15uT+lYj4wM6rC7SvXsgNKXHW8w5
         ZoUPpZVrlK/GoiLr5hFHn65RqRsm3N5zdcTuEjQuo+Q3rXZbSCl7vYPTyrfNEYVVW0m3
         Kb7KC0F7eUqNc9mBydGms0+nvatpeZdR1ZmOHgHTfCS6aZFl/v2sM8oSWbXNLlLL0zX3
         unsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DfUMT7q/Basgf4GK/t6Ib+in2UMXG9rZWdbBfTvl7V0=;
        b=E5KSvWVIQwZVy8BPinA1AojPN/RaDZFzCpimYOkPI2xaq/4fxj/Ekw8tRXlzb3eY6I
         XjC5/Fp+brgAcyMd6Ta69UOGrEGGJFDpaEWc882EGK7RJ6xwrR1DLUa/sKBceOqsHfK8
         VtcFdkeUgy2AOIPHi7v4DA7hRkBEo+GCWAZXSRZatqug94sNEGHKF7/BvwfKExgHUDu8
         mRe4vVAXgY+Rg0og/dqroHfY/2918LQSVLxtc+2hZ4oM1yCn9iC+GZIxeIzI+lJ8BSm7
         yTqK6CxpVCJFRqeqMP1bd4lFv+0mmiYDZMs+Pqm59n6Wy1s3rq2ckZe0NT90cY1Klp0/
         tjWg==
X-Gm-Message-State: AMke39lJPGXGPA+32sKWXOljVs2kMIXK9FlgxbF55ghoiekJJo81s8KCEmPVZL1Qp0iKnA==
X-Received: by 10.28.37.195 with SMTP id l186mr29211wml.73.1487726401646;
        Tue, 21 Feb 2017 17:20:01 -0800 (PST)
Received: from ?IPv6:2001:a61:3434:d400:f45e:e7e:d939:ba62? ([2001:a61:3434:d400:f45e:e7e:d939:ba62])
        by smtp.googlemail.com with ESMTPSA id m29sm30899759wrm.38.2017.02.21.17.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 17:20:00 -0800 (PST)
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath
 variable.
To:     Junio C Hamano <gitster@pobox.com>
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
 <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <61a3e1a7-e70c-cb68-184f-95dff28d1271@gmail.com>
Date:   Wed, 22 Feb 2017 02:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.02.2017 um 21:48 schrieb Junio C Hamano:
> 
> I was waiting for others to comment on this patch but nobody seems
> to be interested.  Which is a bit sad, as this may not be a bad
> idea.
> 
> If we refer to core.quotePath, the mention of control characters
> being quoted can also be omitted, I think, as that is part of what
> appears in the description of core.quotePath variable.
> 
> Alternatively, instead of referring to another page, we can spend
> the additional lines to say what is more interesting to most of the
> readers from that page, e.g.
> 
>     When `-z` option is not used, a pathname with "unusual" characters
>     in it is quoted by enclosing it in a double-quote pair and with
>     backslashes the same way strings in C source code are quoted.  By
>     setting core.quotePath configuration to false, the bytes whose
>     values are higher than 0x80 are output verbatim.
>

Without `-z` but with core.quotePath=false the path may still be
surrounded with double-quotes if it contains control characters (and
some more). The documentation in `core.quotePath` mentions this, your
"inline" alternative does not.

I will send second patch. :-)

