Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306211F404
	for <e@80x24.org>; Wed,  3 Jan 2018 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeACJ5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 04:57:21 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:42766 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeACJ5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 04:57:18 -0500
Received: by mail-io0-f182.google.com with SMTP id x67so1554036ioi.9
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 01:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/M0ptBQIecFdUADyazYYcqcZCxpmZzVkCmLvI+8HDBc=;
        b=PxjLuCgLpJUT7Q2NwK6KWdT1BRDlq6mFekCmrhfFWVTv7C1ebzT4V9cGAgBULmA/ZJ
         Qrr481l65Uq5MlIpirtEvt92r1OQq8U75mj+KLFlI4Im4fVtzTg7YZ5vsMbw7dKudOON
         buew/d8RBdga+HbLer1OPXsnYUF71cLdnAwLsiBRmOYyPsfQKFo3MYffS7MIJ9aeJ65g
         zPcaqjaDtteY51Jk4Mpf3b8gEP3mLpeAFTMFRPXuBNfV4X4JD791Rz0CgWR/QvPGSOMb
         +vDg/dwQfiRHPFII4rmI0Ed/V9ZCGNkmy++oq0wddlDH1lYWl5rk3FDIeAzM/MdVC9oq
         3nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/M0ptBQIecFdUADyazYYcqcZCxpmZzVkCmLvI+8HDBc=;
        b=s63Rsn/CPMa8ov7hNeq7z0wtBkGGLOgOo4CsI7P04ZPfhhq5sWFWGZ+QQwsMahumN9
         Tlnu2JC12CVu4bShJmH8zMEYl5OWobwJMhxLBu0RsaVYXDXJR9YC9yFS/nlMEPaUfKOK
         ErmGD2y+6+EfMLbx5MeSMrmW+XonHgzCgHfX0g1wft0l4Vug0ZB8j9+aFHyyWc676nql
         Au0/6p4SvzkVa8MLaBbR7R0hzt60ahisIJc0sQgc9uAziZmnbrf3V6OmcQOWBKEUXjec
         wk98GRveBIKqs9iRCjnyPvEODr88t1Mx7hG9T5QZEvbWN+OTNd+9Df+lNhj4oeAWk8lJ
         PlAQ==
X-Gm-Message-State: AKGB3mINk5/2SP4ya+wKu+Q0yUnLp7O6cwxZMq4hkNP142MXsc8NEG7J
        rtBZoGc0J36REY0J+G0GE9c=
X-Google-Smtp-Source: ACJfBourwLoH3dcWLPtJNTjgwOOvCYA74aqTP1Ca6bBfpj7rw1Kxym11uHu55yg0ka4COECCCGZnyQ==
X-Received: by 10.107.101.26 with SMTP id z26mr849158iob.41.1514973437676;
        Wed, 03 Jan 2018 01:57:17 -0800 (PST)
Received: from [192.168.206.100] ([117.246.167.101])
        by smtp.gmail.com with ESMTPSA id k67sm494135iod.6.2018.01.03.01.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 01:57:16 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
To:     Daniel Knittl-Frank <knittl89@googlemail.com>, git@vger.kernel.org
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
 <CACx-yZ3MPN1Fw4s=mV9n=zibVm9Z_OE1eSg+4PBtUsqxTTvwXQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <fc20d692-8a01-5f96-25bf-41549620d2c5@gmail.com>
Date:   Wed, 3 Jan 2018 15:27:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CACx-yZ3MPN1Fw4s=mV9n=zibVm9Z_OE1eSg+4PBtUsqxTTvwXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 January 2018 02:56 PM, Daniel Knittl-Frank wrote:
> On Wed, Dec 27, 2017 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * dk/describe-all-output-fix (2017-12-27) 1 commit
>>   - describe: prepend "tags/" when describing tags with embedded name
>>
>>   An old regression in "git describe --all $annotated_tag^0" has been
>>   fixed.
>>
>>   Will merge to 'next'.
> 
> Shouldn't this be merged to 'maint' since it is a bugfix (for a long
> standing bug)? Or am I misinterpreting the meaning of the 'maint'
> branch?
> 

IIUC, the pipe line here is something like,

                   [PATCH]

                      |

      (after the patch gets some consensus
           when it's not trivial)

                      |
                      V

                Merge to 'pu'


                      |

  (after waiting for some time to see if someone
   shouts about a build failing or complaining
    a regression about the PATCH in 'pu')

                      |
                      V

                Merge to 'next'

                      |

  (after waiting for some time to see if someone
   shouts about a build failing or complaining
    a regression about the PATCH in 'next')

                      |
                     / \
                    /   \
                   /     \
                  /       \
                 |         |

   (if it's a bugfix for  (if it's a new feature or
    an already released    an enhancement)
    version of Git)

                 |         |
                 V         V
       Merge to 'maint'    Merge to 'master'



Of course 'maint' and 'master' are not diverged completely. They are 
'synced' at times.

Disclaimer: I won't say I'm 100% correct with the pipeline. This is just 
what I've understood in observing the mailing list, the "What's cooking" 
emails and the history of 'git' in the short time that I've been here. 
So, there are possibilities that I've said something incorrectly. I 
guess the "Documentation/howto/maintain-git.txt" document covers it more 
comprehensively especially "The Policy" section describes the branches 
more clearly.

-- 
Kaartic

Quote: "Be creative. Be adventurous. Be original. And above all else, be 
young." - Wonder Woman
