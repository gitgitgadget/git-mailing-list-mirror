Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C661F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfBKTMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:12:42 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37229 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfBKTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:12:42 -0500
Received: by mail-ed1-f42.google.com with SMTP id g4so14641eds.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M+mOxiYYju2EubDiTu6mzC9UORD9ILW1qo0mk8Sfl3M=;
        b=p+03PODR8c0jxr27jD+q5AcaxUnLeD+Jwbb7/G5suO8AS8APmg1C9vSeSJwZ8QfEgi
         CMD2wH+ht8n3qPOxypAmIWNHR+AvIxrAggke/s8aEBShIELY6SnIakzWiDaIE/ixuMV3
         5RV5EvEUWPkdirW256Rt0cerrJvxrF0BIq5qY0sX35r49/ybOIl3Xk2E2cf2/oyBFkGn
         bib17Kd9QW7kW07o+sKCg2oydqAeQqnc+vmyqkxLGWH5cwE9a4OrF1P7KkttfoW2JSeC
         Wbyeho1xw42s6Oghyak4HdOlZQdPoGJIoT1f/6twh/g22VxkCebBkR6fqveJqZPPvgOk
         qhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M+mOxiYYju2EubDiTu6mzC9UORD9ILW1qo0mk8Sfl3M=;
        b=SlCTJuhzi8CZkxFn+YOJfi1kPO2TOt/5y1vzPnmUnN+hTW9sSoslwNmKfBK9soBH+c
         rZDiBmmYbnYix95wHY4xgfACvSK9Vnt4mrgnCZAcunqMNp0FhHcejUXaoLiyYaLSCcUI
         cQH4dH0cHi+aywAjRnBRtKYAA4lRI0UcgUU7wjQ8Wd/WPi5wallQ8klhVxf4N0U+rc1O
         QKD5Ygz6Iks67T/voGr5L480osIwWnJ0Voii0sQhmmD4zsKw8APWgJaS6L7iTsd3lz1G
         1+JH5Uyw0WfFbddn56F4DKfTDTl8W2OVYW02FVFRqALURu00BpQ0saNxe6k0mUeBwk+f
         kisQ==
X-Gm-Message-State: AHQUAuZzAuHEbkhqKMLi3WusSt/dt4VA2G9KpBe1gokdEcBDXo1mv5y6
        cAaZY9UBE0ddQ8s9RpSBUXXa9ixv
X-Google-Smtp-Source: AHgI3IZ5o1N8dStLmVCCX1jzCkU4bmpfvUphdfewqirv+4wamA2gaOP8U8imDVJtR9yQ4rMxt70bFg==
X-Received: by 2002:a50:c11a:: with SMTP id l26mr30276206edf.233.1549912360114;
        Mon, 11 Feb 2019 11:12:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm2475368eji.69.2019.02.11.11.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:12:39 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:12:39 -0800 (PST)
X-Google-Original-Date: Mon, 11 Feb 2019 19:12:37 GMT
Message-Id: <pull.123.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] fixup! trace2: collect Windows-specific process information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     [jeffhost@microsoft.com]@vger.kernel.org (mailto:jeffhost@microsoft.com),
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix infinite loop observed on Windows computing process ancestry. This
should be applied to V6 of "jh/trace2" currently in next.

See: https://github.com/gitgitgadget/git/pull/108

Thanks Jeff

Cc: gitster@pobox.comCc: peff@peff.netCc: jrnieder@gmail.com

Jeff Hostetler (1):
  fixup! trace2: collect Windows-specific process information

 compat/win32/trace2_win32_process_info.c | 32 ++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)


base-commit: 878e2cd30e1656909c5073043d32fe9d02204daa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-123%2Fjeffhostetler%2Ftrace2-next-fixup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-123/jeffhostetler/trace2-next-fixup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/123
-- 
gitgitgadget
