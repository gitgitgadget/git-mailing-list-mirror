Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F147620985
	for <e@80x24.org>; Wed, 21 Sep 2016 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbcIUWic (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:38:32 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37960 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755755AbcIUWiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:38:24 -0400
Received: by mail-wm0-f49.google.com with SMTP id l132so116491321wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QyG+hqFGpJSVHFlBVxbK95WcyHgCuFBZbxlN3TuQfAE=;
        b=CV8xzVqjI8vWBAsIVM1jVPDIf5HCvEScr4fKDhb6uOCVRd7jxYDXqiaKtPNgtJen3E
         zJKZqwFmePNtZa+Wy3bqnLp5+Ex/Ya1xKltc8I6sCMYZNE+brYoiSifdgMCEPsN8e1l3
         BGaJC2yo6nUOTDQrri/kS/n8UYJsSBHN+UKCtH65mdBsc51vaaLfremHeDh/hFl9/Mih
         0nK+iOk0um/50hBXB0idqp8Cxdnj6Me3aiY8qagq5as45wHlIkybphOAt+zdx0R+kz+S
         0VG6F05MyKLxY62RH+rlKYjxs5LlIu87E4MBuJjAe0ELbzB3UeEB0iBaT9iy2jXLw+FI
         HDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QyG+hqFGpJSVHFlBVxbK95WcyHgCuFBZbxlN3TuQfAE=;
        b=b+RUPP9yvz2vL7trZ3BuQcQ00PDGY8K7/rVdFyTutxCGSH8WZhctiV3J3UdKwDctaj
         r7zSCHkWDMGmWukJu3/GTdwLUeI9TcYpLbsMKV4OXZsosj/n0kfZ/jeIYNzRO8jtgR4G
         SYnBEs7vI2vGNZfP4ERAbWG4yv0pnqQvJ2QELuShfwNiIPudzBfrpUE98yN4M//8fVlX
         6pffhJBgka4AB4SH92DXs7r5K8mF5QB2ghduaZXiPPYVAuyYyoiGA/HdIJW/5pLGmP/R
         t7lZsJEBbAsW7IEha0MftvLn1KWfJ7OxwXUOk3Q1Y/R88E9UsFgLVjxTgf3Q7TCirCto
         SrsQ==
X-Gm-Message-State: AE9vXwNTx35EIwufOGtDPLLu+PBM1RoSb12n125XijO/YbRoSJGXo89ws3Suvqhaw90YKFfjNZo3NeFiQEYKOIgx
X-Received: by 10.28.186.68 with SMTP id k65mr5496105wmf.57.1474497502744;
 Wed, 21 Sep 2016 15:38:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Wed, 21 Sep 2016 15:38:22 -0700 (PDT)
In-Reply-To: <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com> <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Wed, 21 Sep 2016 15:38:22 -0700
Message-ID: <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

yes you mentioned this and I meant to change that before sending it out.
Looks like it slipped through have slipped through.
