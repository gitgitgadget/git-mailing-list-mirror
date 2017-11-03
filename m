Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BBA2055E
	for <e@80x24.org>; Fri,  3 Nov 2017 13:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756256AbdKCNm0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 09:42:26 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:43197 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756220AbdKCNmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 09:42:24 -0400
Received: by mail-qt0-f173.google.com with SMTP id j58so3265583qtj.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IhRqxNoTJWpbX+niDYDv1cEdenJhzqLUDxtIxHJl4lI=;
        b=HICblNTZlXOvxXQ1Sf7w8JCnvRvwYOIBIeIXamBLIuwJpyn58FILEtSjebCQ63MskR
         e16P8VdCLYeBEwWmFwb8HU8Nr0e9c8NfRX99gP372hRvMbD+zdtmA8a3DQu4hOncNk2S
         O0/i7mAfwgQVeLU+MzJEiphyNA0OokdGUPwQuZgEOUp/vcHR2NxsTMWN+gF7NWN5V4lq
         mqm1DOVfP1QIkE667Nm3XGyui9nl4f7cAJF67/PYX8V3FbNwcK34Szain49k1/dUYAA+
         XkWdK0P+dQ3uPY6D2SmFRjSE6NDUghxSKy26N2DJn6P4WTEZQ5pmoZO63k8vLRoi3J83
         xGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IhRqxNoTJWpbX+niDYDv1cEdenJhzqLUDxtIxHJl4lI=;
        b=j5ZZ0h2AMZ9XuQdqon9ineQO5fREy1CB930NopQs8PutzZM0hkiFaClzsFmKgwSbox
         kUQQgcn+io3NgdAPomOWaaGUmnt9991KkmchVhGWTTRSGe9BkU0kfywsKR0IpZpn2hhK
         2UsYCBjPljGX0mlQcjUh0VDv/KVUWB/uqtAfuS8uGQVBEGMADypdzH776eWjW53tiGPM
         znxCIVstCxmdrXcSH4CCxkpY86IajFWCtg2Q7dgCvCuQVlIrAN/u4+jOSfjmp2PwSuXA
         4TGzbonfbotFHOTrbogWX3vrstBws0nX2zicxJo0WUHwffyDB0gThPIPtERK16YfIpv8
         j8nw==
X-Gm-Message-State: AMCzsaW6k0sNZVAbYxMEDdp3xan4WNAAcgwPlDdEIokwjvXuEX2h9411
        0yvSZgLeKAbx84EtvUg/TCZF6z0spfOi65A1AdoYePi2
X-Google-Smtp-Source: ABhQp+TkSTP693ulw4qnMahmnx1GPHlIPyrw9K0QLsivUoSJQ6kCnHbjKhdIr7kKvEKP++mbzgCNUkfKecPAHpTrGh8=
X-Received: by 10.200.51.41 with SMTP id t38mr10471413qta.241.1509716543903;
 Fri, 03 Nov 2017 06:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.147.227 with HTTP; Fri, 3 Nov 2017 06:42:23 -0700 (PDT)
From:   gregory grey <ror6ax@gmail.com>
Date:   Fri, 3 Nov 2017 14:42:23 +0100
Message-ID: <CACYWVif=zSiXpqVL0td+Mgu-Wz=AzDL50kREcXJY2Dtf_4_y_g@mail.gmail.com>
Subject: submodule using revision
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys.

Currently git submodule only works with branch of the submodule in
question. Adding a functionality to work with a revision would be
great from my point of view.

Proposed syntax is as follows:
git submodule add -r commit_sha git://some_repository.git


Thanks!


-- 

http://ror6ax.github.io/
