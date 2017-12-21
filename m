Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F352E1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 22:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbdLUWEQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 17:04:16 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39845 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdLUWEP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 17:04:15 -0500
Received: by mail-wm0-f53.google.com with SMTP id i11so18414413wmf.4
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bC7Wi8hwx+o+Zn1KcsOQ6MwxvcwAHCceRSC5Phamysk=;
        b=bn9oFBq+GdFAyE47bmwJk14BkKIyjbaxGNLo0UitHF7Slo3neiufQq0LB+eeldrPTi
         oUTkEq5CXvSfW0xEO6y+U38g+JONTtIsqUgKOUhbCpd+SHWb48WxGtEP+PW8aNfvRh9d
         SX7LjMIb53PVuTpu7ZtSNE+RaFxJWaePVbziYzfNcH2MDdf7mSh+iB7DdU46Zt0CpeL8
         ulmhtb/6t7+yPrRzY/2L+5M414cBbzsREX7wuD0lhLVMaaFe5Y0jrfNnAXEnrw0IiMc9
         eqoUHnDsp5j3JCFiS3DgXixQdtMMOfUudoFU5AmP2oLNXSyOwaEvNG3LKXtIRPUDl8rE
         E0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bC7Wi8hwx+o+Zn1KcsOQ6MwxvcwAHCceRSC5Phamysk=;
        b=EMJVqXT9I4LTCo0/BJzQoL7hFUIclAVw4GncCrddVQGg2q74CvKl6BB7/F+edh5t6L
         Mf4B+jJWWC5eUMafaS4x3ePSf2lbB8agQCGudhmoLG+N7DuQ9bNM2Hn0eOx9CsKkyA3t
         3R85a/+Q7KZQ1YIRoAtPb0HVhD4z/o8gsNe5uAqkF6vDOvWPPufeZ3P6fPvKZ9KBAgr6
         cwa1y9Txlplqds9c7vusWjzlWYzQMyvp/gYCVCqcSt8U7gGQnCRe7p+C1+e7deK8N81r
         BfvU+qXSEyln3zpIZOYy8IMGQskBZbE4fAnQF8TIV7rJWlbIY47mosDNCMyAK1L8Pq98
         zvzg==
X-Gm-Message-State: AKGB3mITIycSVxm910JvbEkeW3D1Y6mR6NsjoF3ECBUuKsjLL9WqtJUD
        eLg6UmdGDSJK0GbiTi2Y6Q/K47L6
X-Google-Smtp-Source: ACJfBouQ9cH4iQSIFwhci3StxhQUSsgfxEQ+3Hpklw4zuIxZPsLpGVSajco8sUSeG7/d/fG2J/BitQ==
X-Received: by 10.28.133.4 with SMTP id h4mr11206300wmd.35.1513893853708;
        Thu, 21 Dec 2017 14:04:13 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id o98sm33318604wrb.40.2017.12.21.14.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2017 14:04:12 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
To:     Josef Wolf <jw@raven.inka.de>
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
 <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
 <20171220114337.GE18542@raven.inka.de>
Cc:     git@vger.kernel.org
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <fdf75150-eca0-dde5-a305-ae5fd5c35369@gmail.com>
Date:   Thu, 21 Dec 2017 23:04:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220114337.GE18542@raven.inka.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josef,

On 20/12/2017 12:43, Josef Wolf wrote:
> 
>>     $ git add -u
>>     $ git reset
> 
> This would be added after the "git checkout -m -B master FETCH_HEAD" 
> command?

Yes, so it would be something like this:

    git fetch origin master &&              #1
    git checkout -m -B master FETCH_HEAD && #2
    git add -u &&                           #3
    git reset                               #4

But it actually depends on what kind of default `git diff` output 
you prefer.

In order to avoid failure on subsequent script runs, in case where 
conflicts still exist, you need to ensure #3 and #4 are executed 
before #1 and #2 are executed _again_.

So you may put #3 and #4 in front of #1 and #2, too, that would work 
just as well, where `git diff` would now be showing "combined diff"[2] 
as long as the script isn`t executed again (and it would keep showing 
new "combined diff" from that point on).

>> Yes, `git diff` won`t be the same as if conflicts were still in, but 
>> it might be worth it in this specific case, conflicting parts still 
>> easily visible between conflict markers.
> 
> That means, the conflict is still there, but git would think this is 
> an ordinary modification?

Yes, as by that `git add -u` you confirm all merge conflicts are 
resolved, and `git diff` output changes accordingly. You can read 
more about "diff format for merges"[1] and "combined diff format"[2] 
from `git-diff`[3] documentation.

Here are some examples from my test repositories. Local repo 
introduces line "A1" (local modification, uncommitted), where remote 
repo introduced line "B1" (commit). Steps #1 and #2 get executed, merge 
conflicts shown with `git diff`, before `git add -u` and `git reset`:

    $ git diff
    diff --cc A
    index 5314b4f,1e2b966..0000000
    --- a/A
    +++ b/A
    @@@ -12,5 -12,5 +12,9 @@@
      2
      3
      4
    ++<<<<<<< FETCH_HEAD
     +B1
    ++=======
    + A1
    ++>>>>>>> local
      5

... and after `git add -u` and `git reset` (note line "B1" not 
showing as changed anymore):

    $ git diff
    diff --git a/A b/A
    index 5314b4f..8ea9600 100644
    --- a/A
    +++ b/A
    @@ -12,5 +12,9 @@ A
     2
     3
     4
    +<<<<<<< FETCH_HEAD
     B1
    +=======
    +A1
    +>>>>>>> local
     5


Now, without any commits yet made locally (except commit pulled from 
remote repo), local repo adds line "A2" where remote repo introduces 
line "B2" (commit). Steps #1 and #2 get executed again, merge 
conflicts shown with `git diff`, before `git add -u` and `git reset`:

    $ git diff
    diff --cc A
    index 424ae9e,4aac880..0000000
    --- a/A
    +++ b/A
    @@@ -2,7 -2,7 +2,11 @@@
      1
      2
      3
    ++<<<<<<< FETCH_HEAD
     +B2
    ++=======
    + A2
    ++>>>>>>> local
      4
      5
      6

... and after `git add -u` and `git reset` (note showing line "B2" as 
unchanged, and now showing leftover "conflicts" around "A1" here as 
well, where previous "combined" diff discarded it as uninteresting 
due to implied "--cc"[4] flag):

    $ git diff
    diff --git a/A b/A
    index 424ae9e..77ad8e6 100644
    --- a/A
    +++ b/A
    @@ -2,7 +2,11 @@ A
     1
     2
     3
    +<<<<<<< FETCH_HEAD
     B2
    +=======
    +A2
    +>>>>>>> local
     4
     5
     6
    @@ -13,5 +17,9 @@ A3
     2
     3
     4
    +<<<<<<< FETCH_HEAD
     B1
    +=======
    +A1
    +>>>>>>> local
     5


Hope that helps. As usual, best to give it some try on your own :)

Regards, Buga

[1] https://git-scm.com/docs/git-diff#_diff_format_for_merges
[2] https://git-scm.com/docs/git-diff#_combined_diff_format
[3] https://git-scm.com/docs/git-diff
[4] https://git-scm.com/docs/git-diff-tree#git-diff-tree---cc
