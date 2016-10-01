Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87ACD20987
	for <e@80x24.org>; Sat,  1 Oct 2016 17:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbcJARJl (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 13:09:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35576 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcJARJk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 13:09:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so3294076wmg.2
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pYX/q+CY7iUd21irznTN176tV+dYMiaTMKml+967XdQ=;
        b=cd0NbGkpnCirc4FwZ7sh15BlmncJaPIhVyt7pZXxYY43QJfx+y0Jy5RY2zQschsGxl
         JCBGfTReUnwW5mpqkzrfwkwQpDJFKI/j4HC8Yrmcnh2q+3bV1111JslA7VwTEsGeHgPs
         0ixzbTtfAXqDgoLZReK2foBsWq4MJS+aEpwUSmQoD0FKyNkOYGRTUpo+NGMjBgOeomiX
         V33XzYm3wQIo7gf6ZrHMYeudZonKCkbxjo3HZuFlqP8YADWEZdAbyXv2WrpG+JdkyNLl
         4yfk2JJcFULJU1UHkcgs1NoCgacplW7NznPFPdRHeqRyBxns4mX4xmVJukJIUUjPS9YT
         U8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pYX/q+CY7iUd21irznTN176tV+dYMiaTMKml+967XdQ=;
        b=fJIvY4xf1WqUDmZpqHB2aAx4WODkB1M1BfbI96rKR+FanAOTAEVSSfPXo3HM4ptV7/
         y3i6td2ELvePv09O01EnxKDydPFVqFy8T790WdM2mi+9Fb/P1j77v5N59dq+f4oxIh/w
         prhxM/uNGJcCJgH6fAbEo4/I7ABXJXuFTz7M2JrwmOW2ZtH/kBJedLOSQfwHC+6uGr5Z
         arR/Z8Ce2Y/cJ29EpbH/zf+4aFiiTvNjVThub1XO34vQ1z2sX4X+6KZiVHcYzmkwzLNw
         g3mNYFl5faLVRtzasMengdaiw12hgL4hnrRTilaa+9ceO6Q60sGzn1eEthXwXrfUQI9L
         2rbQ==
X-Gm-Message-State: AA6/9RnHmR5LJ2cUwyymFp+WSnt9A7nyJ1AdtIHL/0Mz3s3b3EJL3XB+/yb6wEW15+wUIg==
X-Received: by 10.194.20.167 with SMTP id o7mr11929750wje.70.1475341779214;
        Sat, 01 Oct 2016 10:09:39 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id lz5sm25415605wjb.24.2016.10.01.10.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 10:09:38 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] i18n: add--interactive: mark message for
 translation
To:     Junio C Hamano <gitster@pobox.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-6-git-send-email-vascomalmeida@sapo.pt>
 <xmqqbmzby3tc.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <32b8c9ed-82df-0d71-a610-064b6ebf7a4e@gmail.com>
Date:   Sat, 1 Oct 2016 19:09:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmzby3tc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 01:09, Junio C Hamano pisze:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
>> -		print colored $prompt_color, $patch_mode_flavour{VERB},
>> -		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
>> -		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
>> -		   ' this hunk'),
>> -		  $patch_mode_flavour{TARGET},
>> -		  " [y,n,q,a,d,/$other,?]? ";
> 
> I hate to say this but expanding this single-liner into if/elsif/
> cascade of uncountable number of arms is simply a disaster.

Even if we turn this "single"-liner composition of sentence into
interpolation (allowing for reordering of parts in translation),
like

   print colored $prompt_color, __x("{verb} {noun}{maybe_target} [y,n,q,a,d,/{other},?]? ",
   	verb => $patch_mode_flavour{VERB}, noun => $patch_mode_noun{$hunk[$ix]{TYPE}},
   	maybe_target => $patch_mode_flavour{TARGET} || "", other => $other);

This would of course require N__() on values of hash, somewhere.

the problem is that the ordering may need to change depending on
verb: "Stage", "Stash", "Unstage", "Apply", "Discard", and/or noun:
"mode change", "deletion", "this hunk", and/or presence and value
of maybe_target: " to index", " from worktree", " from index and worktree",
" to index and worktree".

>> +		if ($patch_mode eq 'stage') {
>> +			if ($hunk[$ix]{TYPE} eq 'mode') {
>> +			  print colored $prompt_color,
>> +			    sprintf(__("Stage mode change [y,n,q,a,d,/%s,?]? "), $other);
>> +			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
>> +			  print colored $prompt_color,
>> +			    sprintf(__("Stage deletion [y,n,q,a,d,/%s,?]? "), $other);
>> +			} else {
>> +			  print colored $prompt_color,
>> +			    sprintf(__("Stage this hunk [y,n,q,a,d,/%s,?]? "), $other);
>> +			}
>> +		} elsif ($patch_mode eq 'stash') {
>> + ...
>> +			}
>> +		}
> 
> I wonder if you can make a simple helper function so that the caller
> here can still be a single-liner:
> 
> 	print_colored $prompt_color,
>              sprintf(patch_update_prompt_string($patch_mode, $hunk[$ix]{TYPE}), $other);
>  
> where the patch_update_prompt_string helper function would look up
> these messages from a table that is looked up by patch-mode and TYPE
> and the run __() on it, or something?

Yes, this would be necessary; hide complexity behind helper function.

-- 
Jakub Narębski

