Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC64D1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757979AbcIURPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:15:18 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38072 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757962AbcIURPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:15:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id l132so102827477wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OxFYHb5h7BM/z8NPGHVvGHZL3yxYh7tDZTp0K9ofLvE=;
        b=oFglE2mtAHrtfQxQ+55spUG9pNAbKPorH3eJF5ezOaL5oyv7rREIn9lalvm7ryczVE
         5GqG0EDquAjMaecbpNAlQmJ8AtxUz3r+9JSxhgIlMlEuwKupz/7Ka8mPZGVOn4RnPA2X
         r1kcQsg9lQaHYm/NbyQ/wr1CLHhIWuMMzmY42huJliRtAyTJovePIEIFtM0lhTztSMN4
         jqSCbMR3RAvA8EAsgAe02+inLjC68Ye4cg+SHtyCNi853kNdSZSuI8bm7ot6cTr21b2b
         eITlUpSW1/atQxbiI+IpkByPFeqAmw6FNlmKbPr483LUe1xmo0/mfvJkRKlItF7AmGje
         LNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OxFYHb5h7BM/z8NPGHVvGHZL3yxYh7tDZTp0K9ofLvE=;
        b=ZU7DqprQLGSh6Q8cSyZJld1nn1HSFsb7hz4J/BJP213ul7xfGMjA4ql7iNO7wQxdTA
         mhqmedh0fqEr9MTioGnKx+cgkO5/e9GgC+C1ndZmv7pKCvE6X9Gvw5CCcL9CxaNHfynL
         N3gGiUIubar1PUM6tYGTdkxQ2vfEKXFP9Rm9chhfqCL+/r8rbCxelpTQuday+2v2AMdt
         ZvqbW2NU9JA5YHOQvSEHmPKPxTI06KUhJrtHRFB56vSqJ1Y98Kz4dzULb/mvvI4AYTsp
         ZUsyI2wJvUV5LLYOMJKFOO/ZYPewr3Ca/orzSAIlOo4Y5j28ZvAXJwIvYdkwAvAtrWFr
         JVfQ==
X-Gm-Message-State: AE9vXwP6xpmwSvGzqvhiJUVVe6Ie6BVUBHH1RgcjL77Bc5pfPakta8010EZsrhzEDX4Jvg==
X-Received: by 10.194.241.227 with SMTP id wl3mr33669814wjc.177.1474478115855;
        Wed, 21 Sep 2016 10:15:15 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id a84sm33622718wme.6.2016.09.21.10.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 10:15:14 -0700 (PDT)
Subject: Re: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
 <d047a76d-8f13-5c90-3946-6821957d9278@gmail.com>
 <CACBZZX4QDTNYDpOF+GsK3tMQamoXQhJoXuPTgB3O+iEW3jBxag@mail.gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8b43ba22-9634-e2b8-8de7-d70c258f4034@gmail.com>
Date:   Wed, 21 Sep 2016 19:14:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4QDTNYDpOF+GsK3tMQamoXQhJoXuPTgB3O+iEW3jBxag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 16:17, Ævar Arnfjörð Bjarmason napisał:
> On Wed, Sep 21, 2016 at 3:33 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 21.09.2016 o 13:44, Ævar Arnfjörð Bjarmason napisał:
[...]

>>> -# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
>>> +# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
>>
>> Nb. I wonder how common is use of XHTML nowadays, with HTML5 as standard...
> 
> It's sent to modern browsers, I noticed it because when doing the rest
> of the patches in the series the slightest mistake in the HTML syntax
> would cause the page not to render in Chrome, because
> application/xml+xhtml activates its anal parsing mode.

What I wanted to say is if we should support XHTML mimetype at all;
the future is HTML5 and perhaps gitweb should always use 'text/html'.

But this is unrelated to this change...
-- 
Jakub Narębski

