Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B371FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 16:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbcIEQdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 12:33:55 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36338 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933743AbcIEQc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 12:32:57 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so9579620pab.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=s4nuYAtZ0E9MhvbnhBPfLq7zKtDOW6HlJJYquy8vxNY=;
        b=NslaqKMKx64dqDLNpkPESChWB708JJ4a5eVTiyFuR0wStyY61OO6oqklZnekMPVyGq
         hjn9NkveTFilOiugJBp+GxpBi5Tby3SAowtLAsfFwKIEPq9sGxyvdh9VWbyePLaRM5PC
         mVlPm8VuLpeGtCsXb1hawEDf2FLo/ZiA0DGPy5M5UjpHUkBlfCpfbyPfbwpjr+6gZIsM
         azfaVqrPUHGvIHyag5mZKnIMSY7lLXjimLDoEnmjDvYdqHShOf+F42x+zLZ9zvbQ1/0k
         ycuf1AapP/gDWiw3FQJdaY25SfEi5oEp72wm7j+PoptpTp+0IqZ0Mkoq7TzrLGPk80Hl
         AWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=s4nuYAtZ0E9MhvbnhBPfLq7zKtDOW6HlJJYquy8vxNY=;
        b=LVxSXV+M+V+g7eUa/jRY5Nncr0VbxNaGfSJp2duGecVsy8VFf9iVPkEDF+JTcomJSp
         MCb7t+TRJfgcmKdPZsPH/YhcxMqoTO2/wUy84PZIvgOFQ8VAvMVxl2bgEtWeqXBVHSRR
         hfdggsqJnnd26JVnLrIZ8ucJ5qRfQqSUcHExfTUWzhyFKO141eXAxClwSkG69rD8aVov
         fwgjKKTf/Ty8NMQi55ZqFVoFVF3Kb4pctqyLcnf8iUMoVvL8FPKbmGNWn/+uyaISlTPi
         kcBI7Od5bhQkfZJkBtpSVhsqknb9dwj6v1wkhFovnNdY8ISW/IciHZ+Fr1bwk++31+mq
         Y47A==
X-Gm-Message-State: AE9vXwMt8ohN9BZRAINQGroUhgrucygZ3w7acRDd8FqlBuZiXLvyer8FLaMYq1b+WBUWfQ==
X-Received: by 10.66.216.130 with SMTP id oq2mr65142374pac.89.1473093176670;
        Mon, 05 Sep 2016 09:32:56 -0700 (PDT)
Received: from Yasushima (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id si8sm31931891pab.8.2016.09.05.09.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 09:32:55 -0700 (PDT)
Message-ID: <191E6E09AD6B40489CE24D53666C5EA6@Yasushima>
From:   "Satoshi Yasushima" <s.yasushima@gmail.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com> <xmqqh99wqhn7.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqh99wqhn7.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 1/6] git-gui: The term unified for remote in Japanese
Date:   Tue, 6 Sep 2016 01:32:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-2022-jp";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3564.1216
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3564.1216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 03 Sep 2016 23:54:36 -0700 Junio C Hamano wrote:
> I couldn't quite read/parse the title, but luckily I read Japanese ;-)
> 
> You saw different Japanese words used to translate the same original
> word "remote" in different message strings, and you chose one of
> them and use it everywhere.  And you did the same for "blame" in
> your patch 2/6.
> 
> I would have described them like so:
> 
>   Subject: git-gui: consistently use the same word for "remote" in Japanese
>   Subject: git-gui: consistently use the same word for "blame" in Japanese

Thank you for your title patch.
My English is so poor as with many of Japanese.

Resend patches in a little while.
