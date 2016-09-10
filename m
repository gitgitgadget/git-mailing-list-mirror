Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8703E1FCA9
	for <e@80x24.org>; Sat, 10 Sep 2016 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbcIJJwI (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 05:52:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33191 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752538AbcIJJwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 05:52:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so6011866wme.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8pgx7HRANoSNkPD+01shfKgK5D90xcvhYyfbMANM8EU=;
        b=rFId3IqnNtBAC5Jsis/2FfXA/NL+EbdFahCeJ4luA2qy2rNTdvgQ8kdVL+Ryr1GN9X
         eswtdcQBw1Y8EMhQT6ieVXbKJsE8yFL4Us7amCcMXwm9FH5Ci56uubxkrURXRoLtiepr
         XpJA/3YNwNikvtswLdvKS1GNGIVeBnfjydye4uKAhaFj/nt+ema+idclsHX2Dv8YyVPs
         BxFlhzQDyiA7Nif4SpxEwi8tQx9bfctSmBA6bpf9R12c7WOT1TW1yNLjk873tR0WQ9hm
         S/0qm0CK9d8i6PWYoV+1dkUOpkDBM2xEx7diyKHaP/C5dWJvujudo0gsEU9txNxq4in6
         Rm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8pgx7HRANoSNkPD+01shfKgK5D90xcvhYyfbMANM8EU=;
        b=SXawfqCJrUSb7D3Yf2ajKS01stIwnAGtsQz5svwn/RAxTEcIb8Z68/YlpFeh1UZN4V
         vYtkS9IVcSodwnTizdesl4bCATRIOqW7SIo1fEu1saSBNbkYESiNEcp44w75Yq1MZ6bf
         m9+BGXFtMr86FJJ2jyKl0vx/N8jaRKEG0KRyz/1LOtZUUqJ9Yn5dKqAuAzj5uNA8Cae7
         tkbXFuYF7pRNPh41lLSBbSFaXf9nkI1R8h8FSUx+68XhBWSccui7pxY8Tv/88/6DZLCP
         7RtcDywCZ9pL76SWbvrBPiVKwipQ38G9huFJfPJ3ElJRtPdSyVe+s5rDo7ETEBbDUb7K
         w8VA==
X-Gm-Message-State: AE9vXwO1N3hqWAEDMiZbVoU6Nd09VxLE7pO7EoiyXGEKhfpqn3J33qAihJU6PxlMlNceHQ==
X-Received: by 10.194.114.100 with SMTP id jf4mr6553801wjb.87.1473501124171;
        Sat, 10 Sep 2016 02:52:04 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id bo7sm7558481wjb.28.2016.09.10.02.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 02:52:03 -0700 (PDT)
Subject: Re: git commit -p with file arguments
To:     Christian Neukirchen <chneukirchen@gmail.com>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
 <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
 <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
 <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
 <87inu4bxt7.fsf@juno.home.vuxu.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
Date:   Sat, 10 Sep 2016 11:52:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87inu4bxt7.fsf@juno.home.vuxu.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.09.2016 o 22:52, Christian Neukirchen napisał:
> Jakub Narębski <jnareb@gmail.com> writes:
> 
>> Which means that with "git add -p <pathspec> && git commit <pathspec>",
>> the "git add -p <pathspec>" would carefully craft the <pathspec> state
>> in the index... and "git commit <pathspec>" would take worktree version
>> of <pathspec> for commit, ignoring what was in the index :-(
>>
>> Currently there is no way to create commit out of subset of the index,
>> e.g. with "git commit :0:<path>"
> 
> I played around with creating a new index just for "add -p" and then
> committing that one.  Seems to have worked...
> 
> Perhaps I'll just wrap git-commit myself then.

What I wanted to say is that there is no built-in way to create commit
out of subset of the index.  You can of course do what "git commit <file>"
does, that is use temporary index file (GIT_INDEX_FILE etc.; see
contrib/examples/git-commit.sh).

I wonder, if git-commit is to acquire such feature, what would be the
best interface.  "git commit :0:./<path>"?  "git commit -o -p <path>"
(that is, "git commit --only --patch <pathspec>")?

-- 
Jakub Narębski

