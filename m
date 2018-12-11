Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58CA211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeLKRAe (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:00:34 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35660 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLKRAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:00:34 -0500
Received: by mail-pl1-f182.google.com with SMTP id p8so7202266plo.2
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1kac/EwR+JqBWfhY4GKZV8FRMJRSFCwFdACz8xPFq5c=;
        b=HQgdJcVOQLhRBzuIqY18dUmjDFDlCHIeCWUSY6MZvtakPAYV92N+/oYYoY9y+i7q3f
         DndIKHAkwsp5swfwz5DXhS1imsnfeiWZgZODOBuSunDUNLHPmkJAjBDy0YfWD2nNASv+
         2oLCo898qQvLrDcH/owxfsHDfPM9OsNH+gPfeA8tU6hIeM8UH/6X5mUEfUu4WfP2kmMb
         Watk1PYHzS7R/421n/cO+IgqlhEiRO2HyJaHFDlLwxdNoj/20VqqQBghkDAl3z3rKsLW
         BMPaEYBp8cq2XAGThlYLvA10Wuxktzdvy/Ll4F2J8f2+A/9QHHXAEX64SpETC79aijDg
         WqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kac/EwR+JqBWfhY4GKZV8FRMJRSFCwFdACz8xPFq5c=;
        b=CvH6/Kr7dwcCNl+g0WBk0lheZgEleIRdrLn45PFA/lEVMhHBo13MSAxorluzVSy5ss
         lnyLEw3Sa9HINqqKCQTMaCa7cHN81y8wCNS/RZ8C59g8aki9K+nzL6TORYtUAkr84HUN
         JEhbbgeLQy6QEJqvjqJWTqapwzkxel4l42ncVQEBjR9GfYzNhm18mkm3NFol0/Z26L9j
         VpbMLWJO8eMmQDYWiET7iK7T/6pUuOKytZoYr2x1CrZIL3gDtkCikHbQRgO5/E5WieOz
         EXypbuoTweRbabinrqzSsD+N0RIDDImkQkwoDcgiBSi0JwqUNqPLT/zUAi6Rop5ZqYDN
         zbRA==
X-Gm-Message-State: AA+aEWY1DeC2/ZO2iGShdQaeJX/9FhHo0YV8WN/NP6mGISGRj+V05R0x
        Mp4pAcN5loLGdLByzcIfmaZgHVBi
X-Google-Smtp-Source: AFSGD/WnK0HilavKI3RgaEw6hEvXCCiQkKFetguhma7DOlT8lTdXBaocVyF7DQuT9sbaZHYEmrs5TA==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr3156205pla.246.1544547633349;
        Tue, 11 Dec 2018 09:00:33 -0800 (PST)
Received: from [172.25.16.176] ([50.226.67.250])
        by smtp.gmail.com with ESMTPSA id h128sm17875046pgc.15.2018.12.11.09.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:00:32 -0800 (PST)
Subject: Re: Announcing Pro Git Second Edition Reedited
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
References: <pujni2$ulb$1@blaine.gmane.org>
 <20181211105007.GD7233@sigill.intra.peff.net>
 <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
 <CACBZZX6g7TaxNHN=3ApV4wV91ZuVV8eoemMurS=WMt4mG8Q67g@mail.gmail.com>
From:   Jon Forrest <nobozo@gmail.com>
Message-ID: <55838db9-4f08-b77e-bc95-5c7dce4024d2@gmail.com>
Date:   Tue, 11 Dec 2018 09:00:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACBZZX6g7TaxNHN=3ApV4wV91ZuVV8eoemMurS=WMt4mG8Q67g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/11/2018 7:13 AM, Ævar Arnfjörð Bjarmason wrote:

> As someone who's read neither your edit or the original edition, but I
> did read your version of the intro, it would be very helpful to me /
> others if there was some diff between the two so we could make up our
> own mind about which one to read, and to get an idea of what sorts of
> wording changes etc. these are.

That would indeed be nice. The best I can do is to suggest that if
you're satisfied with the regular Pro Git then my version won't
help you. On the other hand, if you find regular Pro Git puzzling,
especially in the early chapters, I suggest giving my version a try.

Since I'm giving away my version, you have nothing to loose except
perhaps a little time. If I'm right, and my version is clearer, then
you could benefit from it.

(You're a git expert so I doubt you need my version).

Cordially,
Jon Forrest

