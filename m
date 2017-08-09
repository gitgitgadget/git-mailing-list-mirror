Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250DE20899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdHIAdf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:33:35 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35752 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdHIAde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:33:34 -0400
Received: by mail-pg0-f45.google.com with SMTP id v189so21182060pgd.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsbpDjYzvzQDpyYihWAhq7YZkeySwONa7eYIxICmngA=;
        b=by1dmkqW3Bu1yrLNsVX0bIUm+VUvepeMOtvkjLaUgqqcwbKpvvBJKTMwIsFjMMTEp5
         u0ztu7oSD53pwZL5r0jKFbXtqUBa50p4MqD9kpOvS/SaoCol2iErVdMy1Ey7jcVHVAdL
         9BP08SoXf/HS4mD3QKG4iabyiNCjL0SW+5U77nHHoRNmtmx3EbrlpwM/6Ugnb9+TIPMn
         NtIklGWDdm2ORcJXi+bX84DEqab9rNG7RuxQjbJcUyIcOA5azwG7/ZlE3GHXl8y1rWWW
         i8+2mJr5POlg5CeFIMv/8kB201N3SUId5xMcVr7Xtr9oaX+JL8cYZaZOQlp+PNX2+64J
         Wr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsbpDjYzvzQDpyYihWAhq7YZkeySwONa7eYIxICmngA=;
        b=lnbgmyFTk0uOiuXTpe1piq0/bEwXAjNCsb0OGJk9jA5xOT18668lzGRQexPV7st0hN
         SBOxH/1ruvC+gEtHS2oU7EyXppFd33mx9KIfr/+09NjdFW+kaaAomrDgxjBS/AhxjsWv
         StGfSNtQJ4W5HUbnjU6Vq1qyGsXnXk1ezo1zUbV4TykiawuxWggtBIlhMC720ffNUBCs
         uYbwdl0eibW1kLrLvz4u/VN32W1p1/rlWW0qeShCRCICenjvlw7IJDlC7DFHKoa87Ein
         RPGnx3j2VwoIsfmr9lpPueKMfYp6CKgk99cJAgyk/ZtH4zh4GmTGHmgWJY38vo5Mlo2Q
         SE3A==
X-Gm-Message-State: AHYfb5jtG4Yl0OLC9VfQctAjFhytc+GYJG2BZhhU0mgMVJqJLMiLgoIW
        SJbwqiV5btVdOQ==
X-Received: by 10.84.142.131 with SMTP id 3mr6897286plx.130.1502238813785;
        Tue, 08 Aug 2017 17:33:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id l24sm211449pfi.99.2017.08.08.17.33.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 17:33:32 -0700 (PDT)
Date:   Tue, 8 Aug 2017 17:33:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
Message-ID: <20170809003330.GH169894@aiede.mtv.corp.google.com>
References: <20170808234308.25565-1-sbeller@google.com>
 <20170809000742.GG169894@aiede.mtv.corp.google.com>
 <CAGZ79kZ45=2ngM437fdj8KCJjJo5h0R7FtmEBBG+VVkm0pTLrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ45=2ngM437fdj8KCJjJo5h0R7FtmEBBG+VVkm0pTLrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Tue, Aug 8, 2017 at 5:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:

>>> Nowadays there are better tutorials out there such as "Git from bottom up"
>>> or others, easily found online. Additionally to that a tutorial in our
>>> test suite is not as easy to discover as e.g. online tutorials.
[...]
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  t/t1200-tutorial.sh | 268 ----------------------------------------------------
>>>  1 file changed, 268 deletions(-)
>>>  delete mode 100755 t/t1200-tutorial.sh
>>
>> Interesting.  When I first saw the diffstat I assumed you were talking
>> about a test that validates the examples in some manpage are correct.
>> But this is not that.
[...]
> 2ae6c70674 (Adapt tutorial to cygwin and add test case, 2005-10-13)
> seemed to imply that it was testing some part for Documentation/tutorial.txt
> though.

Oh, good point.

v1.2.0~121 (New tutorial, 2006-01-22) means that the test is no longer
testing what is in the tutorial in any meaningful sense.  That's why
my search for "git whatchanged -p --root" in manpages didn't find
anything.

So what your patch does still seems reasonable (we have lived fine
without a test validating the examples in that tutorial, and if we
really want a test validating the examples then we should find a way
to automatically extract it), but the description is misleading.

With a corrected description, my Reviewed-by would apply.

Thanks for catching it.

Jonathan
