Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40722023D
	for <e@80x24.org>; Tue, 23 May 2017 05:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936108AbdEWFrN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:47:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34705 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934600AbdEWFrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:47:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so25048972pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GJnq3QRglk1Yh0tSC3cwMA3xxJdOuOKVQ7nB1Eiu/hI=;
        b=AyA/sVPWarQN5TPPgKxIozg2CtdP/gXbhxlNc9dFXHrbdBysndxL49+RcLQgfsOOtO
         AtaGX7fNkwVAQyVvdHf7cKi5X4DCLcWvfGqKRw+u2GyJmb65AFqzL8G1SK0kJq/YOMQ1
         FTdR3mTJY4ox9opqpSV+u4FGcLwewcmh9BO4xp5nxCZT7B0ESpMd4XmP19DdHIc2RFpO
         LPPyI5GW/rlbAvANhqG6DsbSTfOPVcqVDccXqWKiKbDeU9otr0dr91s8JhqxIMdHB3I5
         xLjf9qc7S1xDzDpYco1K+4k+JzQSwNGdiel8RuFaFv/xoDBNmUIwlWmR94srU3Fsunn6
         +xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GJnq3QRglk1Yh0tSC3cwMA3xxJdOuOKVQ7nB1Eiu/hI=;
        b=RB+ailjKb99S2t1iKeYhbl1RvLtLDRdbp5/BzoK3wM0ONk72prV1AxJQvu84ad1IKR
         BuXcL0UD2yP5cu5hHF29iCFxPlO6tOGgFq1hGPi28z/DNFKwE0LGNbPtrr/FhOsGx+Jc
         /ckTvZ6fZzT5tPHfvNrye/LgkFYZPfEV+Q9LbN/jLY2RjNu7fuSwWDCrPqOQU/JTkiMP
         eWqFg5KNPHiR6AkFDVJ+pi/rn4NvYynbB1bPcGJlVhbyQ2LrrKKLdHDiY0av04dd/zzZ
         s9XnwL3SGoJlRJZLNbPTWstiZaS3TI3SmfNtOTWA73DbJ/1Rv7Er/oTFPMyuLnEHb8CQ
         tSlQ==
X-Gm-Message-State: AODbwcDrn70QCxZNB0S802dPHViLTCKIDXG8yotvX4+/8++G8QsXIK0p
        pq+gMc6TYJYuswkT8Lc=
X-Received: by 10.98.29.79 with SMTP id d76mr20852825pfd.141.1495518431334;
        Mon, 22 May 2017 22:47:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id 15sm34920929pfj.59.2017.05.22.22.47.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:47:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix reference to isExists for interpret-trailers
References: <20170522194533.6394-1-asheiduk@gmail.com>
Date:   Tue, 23 May 2017 14:47:09 +0900
In-Reply-To: <20170522194533.6394-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Mon, 22 May 2017 21:45:33 +0200")
Message-ID: <xmqqmva4ktuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I'll fix s/is/if/ on the title (no need to resend to fix
only the subject).

