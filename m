Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C8120986
	for <e@80x24.org>; Sat,  1 Oct 2016 18:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbcJASzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 14:55:49 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35291 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbcJASzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 14:55:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id f193so40902681wmg.0
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=m1uAjEW2Tmn6yGECgwFjqh33Zkiiwz0fzGSOHDb3oSg=;
        b=nQ5AaNqtmlp1EW3+DN9hXRhe4Y0yE1QZfGQDmotaZXQnefzpsZAeIY7eLBPLbbK2sx
         sksxBsUOEOlBGeKFo8pWbtuUip3Em/8qaRJ0ZTdYY3Oygta+WTumzLcyYBquJMhq9cug
         qJoIqCs/hXemiQWhlKy0YQMXTi5nNnuEXmvZqCRTlpFD+4p6zbrOLfUEzX6HzMUjEgaa
         CnW4UEhitnxd/fWyi3k8JZvL6N4LTQhb5Hdrnig9/f0rKvtKBP3Ey5bEJqF4b5HwbZTt
         Gt8ZufdlUgRj3n/ttfPf9VQGwidWeiVgttOmzgFJSS1g85k+3M/ozl/0+dLmBh9Dv6MD
         Qpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=m1uAjEW2Tmn6yGECgwFjqh33Zkiiwz0fzGSOHDb3oSg=;
        b=N7Wtokrh95fExEmmK9BWaFlCYRiTxAHoXK2njKBtrlRC/iFR+R0rFI+amAdt12IKoy
         wOYeDjA1l88Bfu0gNfVONX/YLhaprzdkMS7TYWn+ssGrdCuk/Yk1XocVMTu1suzO1Vmq
         z6NPLgj9sKZAq3djhDgubpCcWsciZ70ClRaygGEutf7pp3PDfkDu8+HdQCvX83TLkApf
         d0DuLucpzgJOpSIZTCec6uC/DRPbx/bZgv/RhwYEAgKA3V3s1MyKmaKcpW8UW+SK7gc0
         BRXF5stRE/i807g/e/pBImROgsm/4ZuWV7v0ABkOI8XH+o6gQKxSNeyQ+gA92kxJcTn5
         QVxg==
X-Gm-Message-State: AA6/9RnhWd5MNxlKfnIdCjaNJESmc/tthQcsOWqMnb3yTIcYFgj0dR0fEnTuYJaIGxV+jg==
X-Received: by 10.28.24.197 with SMTP id 188mr3293938wmy.77.1475348147375;
        Sat, 01 Oct 2016 11:55:47 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id j198sm10444826wmg.4.2016.10.01.11.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 11:55:46 -0700 (PDT)
Subject: Re: [PATCH v2 08/11] i18n: send-email: mark strings for translation
To:     Junio C Hamano <gitster@pobox.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-9-git-send-email-vascomalmeida@sapo.pt>
 <xmqqy42fwotm.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a3a74863-f7c4-4c9b-619d-33fbe0c33860@gmail.com>
Date:   Sat, 1 Oct 2016 20:55:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqy42fwotm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.09.2016 o 01:18, Junio C Hamano pisze:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
>> @@ -1403,7 +1412,7 @@ Message-Id: $message_id
>>  	if ($quiet) {
>>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>>  	} else {
>> -		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
>> +		print (($dry_run ? "Dry-" : ""). __("OK. Log says:\n"));
> 
> I am not sure about this change.  We either say Dry-Sent/Dry-OK
> (under --dry-run) or "Sent/OK"; don't you want "dry-" part also
> translated?

Actually, we would probably want to unfold it, that is use 
__("Dry-OK. Log says:\n") and __("OK. Log says:\n"), etc.

-- 
Jakub Narębski

