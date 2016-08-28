Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D822A1FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 11:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755566AbcH1LWe (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 07:22:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33073 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755496AbcH1LWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 07:22:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so5784183wme.0
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=qvVxjyMEjdQYvD92G9XmOzb9QU9Bgb68SScZLdx4Fqo=;
        b=xzMS8SEJ2+uIvn/9TGxUsmAxEsYQ2viYK0YVp/ue4OliHQI82CtPRh0ffackkYHr/l
         lhm3cvEifyK7xQGuFaOsd8s1pCped569b3ZTaAEY3SvjNS+09I2G9uu/7KIAVYb4Zjus
         EWOqYdpjhaEq6hYXEP7BHyIqO72riNL8yzWmj4QnsIw5lw/+oTvbnKvYifM/1TwLfJXh
         10j9LmjdJqC7hP2se6G3TCXsz3ZLgOtpfjYO6EcW4WbANGNatzvywPCp3Vn367OxnH6g
         6Lpp1RIyT8gwGhhy8aV1Kp6/1Lh5nTQpCqHrP0Vux/MqynuVP6bEHUThTMlG0MRafP9O
         Ag4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=qvVxjyMEjdQYvD92G9XmOzb9QU9Bgb68SScZLdx4Fqo=;
        b=lTUDr+wsnqU05dVwKzfRzGVdddIQ1QEQtAttSNBmWeEdrT8voXzR24xm4P9g10QI8v
         JpIylbpCxYwiiXJZerXj9YqZjOb6xUXnO5UzEvPFbLRdgJh13Rg3AadTJjK4+S7iRJAm
         dkuAA0Hw9roIvKImkmAHhmIQVrOygp9ayM0mZytM8yBIfbKPqSHmgqjUo2zfpOuyU6Eo
         vwfCp8uCBYc93B68c4jnwQ6Fe5rUzRiMzmnHiyMnhflUZJWT/fw0KVj4aFPyOgiDTBbS
         rkIt9ZgkVnfICKYOlJHq0N4D3gYV6bZ6HjJ8Y3oJME8HeZr8grEipveiQeVRUCCK34G1
         fu0w==
X-Gm-Message-State: AE9vXwMH7wMlj2qWjg7ogYd0mPH3ywUQ+7uVkLzeV0Ka4/3j61EB5oMBnd44tkby6G8YOg==
X-Received: by 10.194.120.37 with SMTP id kz5mr12377453wjb.196.1472383350227;
        Sun, 28 Aug 2016 04:22:30 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id ya1sm29012879wjb.23.2016.08.28.04.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 04:22:29 -0700 (PDT)
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     Eric Wong <e@80x24.org>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <20160826061500.GA22213@dcvr>
 <6d171c23-65f6-5f67-7d80-051f2dfe8678@gmail.com>
 <20160828094946.GA11722@dcvr>
Cc:     git@vger.kernel.org, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <45245d59-f258-f029-d478-62b3b99e6fdf@gmail.com>
Date:   Sun, 28 Aug 2016 13:22:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160828094946.GA11722@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 28.08.2016 o 11:49, Eric Wong pisze:
> Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 26.08.2016 o 08:15, Eric Wong pisze:
>>
>>> Not directly-related to the survey questions, but can you ensure
>>> it's accessible to folks without JavaScript/graphics, and
>>> perhaps also ensure it is on a host that is Tor-friendly?
[..]
>> A question: would it be better to have the whole survey one one
>> large page, or have it split into pages (with fever questions
>> per page)?
> 
> I prefer single. One could get one page, take take time and let the
> connection drop/fail, and send it over all in one go.  With multiple
> pages, one would have to reconnect for every POST.

All right, I can make Git User's Survey 2016 to be on one page
(at least the anonymous JavaScript-less channel).  It turns out
that there would be 40-42 questions in this year survey.


Though I don't know how resilent Survs.com is for submitting survey
results after connection drop/fail.

*Editing* survey (which requires to be logged in, which is not needed
for submitting survey), times out after inactivity.

-- 
Jakub Narębski

