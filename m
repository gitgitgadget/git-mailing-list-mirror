Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842CD20357
	for <e@80x24.org>; Sun,  9 Jul 2017 07:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdGIHHC (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 03:07:02 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35952 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdGIHHB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 03:07:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so8981008pgn.3
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=o1kr5dP81HQmENaa+7qYDvZXmn1lN5OwzEgEVwXG0HI=;
        b=MBGgV/BDtVnL0ZuCMnkUU2+zmb08PAZ41EdHYpsbLzf9O2B9NzmvE6jqkwpqnc9mHz
         toD/YzWuMhvrzFDuHgDYm7lDgrb0cZIc5tsGiGZyuS8N983U+jcE7YjyajKbLdwXq/ba
         TqK4JxWB/aPwH8kRnHBPat9PW+ItB+omsrKSova1cvUM9se8yjN/SdVJpxLejZEeCeIE
         FYhr39UFdf9P6Lve8EyNYWptdnf8waXd9Eqc0ml8ViI2+VxCFot5jDiLt507pA2OHygT
         1HOFldmbiN/xhwGZcF1a2A/zJfwok7loej7E9fvMMlBrCeAOEX3g2gFPeM9g3ab2+wX1
         tpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=o1kr5dP81HQmENaa+7qYDvZXmn1lN5OwzEgEVwXG0HI=;
        b=jo5QJDvCg+4o2Ia/rdOqf06WKzAzE5mkC1c3AOqLBXtgkC3tGcFtZIPw2bYoiUGpmA
         UF4BP00qcVG+Psom18SjLCEee+vV/btV8SlwL9rpxn0kkAmZrBNL5uixJC39J2R26MH4
         ylTJiWRPDhZDoMTls00vWqUaFxjpdeR3koO0IOvDuItaEbnmu29Ehlej9kJ1n6+naC15
         wI143HXlMZF0qlIO121OA7vX8qaJhLQcnVptCgHqKVKA56JVFay7yLvW4yn12ZjfdtQA
         nIshb4ppO250P5rTXlibMSlwQjHwubgASBqh3G8BmYJcNhD2rtc/mjduPl/eXiR9Y+zh
         cchg==
X-Gm-Message-State: AIVw111Dn4Mqfd8Xtdo3iehBavhWgu28UQTBbZBCvxJrxtWRXSOMgMdE
        SJsNrYUmABix0cmr0oI=
X-Received: by 10.98.211.140 with SMTP id z12mr40032473pfk.231.1499584021049;
        Sun, 09 Jul 2017 00:07:01 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 66sm12134414pgh.59.2017.07.09.00.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 00:07:00 -0700 (PDT)
Message-ID: <1499584028.5659.1.camel@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #02; Fri, 7)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sun, 09 Jul 2017 12:37:08 +0530
In-Reply-To: <xmqqk23ia78v.fsf@gitster.mtv.corp.google.com>
References: <xmqqa84gaw0l.fsf@gitster.mtv.corp.google.com>
         <1499518240.1914.1.camel@gmail.com>
         <xmqqk23ia78v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-08 at 15:33 -0700, Junio C Hamano wrote:

> That is how a message that is BCC'ed to you is supposed to look
> like, isn't it?
May be not. rfc5322 (Internet Message Format) seems to clear the
confusion,

    There are three ways in which the "Bcc:" field is used.  In the first case,
    when a message containing a "Bcc:" field is prepared to be sent, the "Bcc:"
    line is removed even though all of the recipients (including those specified
    in the "Bcc:" field) are sent a copy of the message.  In the second
    case, recipients specified in the "To:" and "Cc:" lines each are sent
    a copy of the message with the "Bcc:" line removed as above, but the
    recipients on the "Bcc:" line get a separate copy of the message
    containing a "Bcc:" line.

Until recently, I have only witnessed the second case as a result of
which I was confused. :)

-- 
Kaartic

