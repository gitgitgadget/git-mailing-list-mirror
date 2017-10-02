Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80E6202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdJBLoB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 07:44:01 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:47882 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdJBLoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 07:44:00 -0400
Received: by mail-yw0-f173.google.com with SMTP id i7so3198689ywa.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HwHXSvWm2PVv/JchMknaQuoWWdBngBNN8SgIVzkfNTE=;
        b=pqN8egYki1B+XQUWg9+kv3KFmZqSgQHZup1G6pRmRjEKddRh0lqZcV9FKbWvjpWg6M
         dk16fkM+2qCHf/NZfQF9yL8dUADhS7fiRz7IBYM7HqQwg+4F98gOsev0MV0B1BQDxdVH
         lQRrKPfiPTwkLHI93Wgt883DibsY8XXWNVbxqvyovGGVjQM3D+EUf+PdDcKH9W9jZUXX
         T1g2MO56o0VuDuiFRqzkDkwjKcIJn/SVrliAkHjsGjzJaBJbbpEcyCAEg9zr3mvDCTWZ
         AIJVZYS9ZigxRuUvmU9F07zAVAY5czcpORDbrDp6KwDNWv3FZ6V8HlCR83DhostJrYzl
         1Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HwHXSvWm2PVv/JchMknaQuoWWdBngBNN8SgIVzkfNTE=;
        b=j+i5oL23ojoj9HsY2PlLlu1eEB01cwxEETTG6nWnqJ6ogdDxOVmYRRnfAjBmvGe1CT
         6uFHI2x2u9TMIoY50eUPZRmjOqL4R4b6a1FkAa9vm65nl3oq40xHKX8cr1r93feeMRSO
         nBv3SQfyYxICRrZ0VEF9GJaFSE2I5V60ZvIqwOYaEceLu1JO1kl5GwsQ5W5WmgtVcIAp
         FP5s121TlZXXd6FGB8gDpHvrSee/z3tnZCY5coEGvE2ehYvUtFTqydR7Y0I7aCzt9zlQ
         CaH0Ox2V5vrStcPCIr7sGPBV1Shg+pXyj+CTypRGZIM1Cxdkm0ACWCmwK3TH4NtyDRai
         dkHw==
X-Gm-Message-State: AMCzsaWrGpKcsW2IKqMgSMrCineWXpNfq2KB+HfuiiMlV1Yzel00ckuw
        mDI4hFEwi6Qm7lYnMuz56GnIDLVN6JeIRhnFRisamtZT
X-Google-Smtp-Source: AOwi7QC70hytPMpawmwvcShyVPO4twMxAVjyrZyEhZLUDXySz8fAs8V3CLF26sSOfk0OW1SXPShhIlrWbz0MnEQU3mQ=
X-Received: by 10.129.201.4 with SMTP id o4mr5179871ywi.502.1506944639790;
 Mon, 02 Oct 2017 04:43:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.43.214 with HTTP; Mon, 2 Oct 2017 04:43:59 -0700 (PDT)
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Mon, 2 Oct 2017 13:43:59 +0200
Message-ID: <CAGb4CBUrozoz9iS5pd57VrnV2e6jkSn7N=POdeUFSkvvpPDSZg@mail.gmail.com>
Subject: new contributors presentation
To:     git@vger.kernel.org
Cc:     matthieu.moy@univ-lyon1.fr, timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
me and my two other partner (Daniel and Timothee) have make the choice
to contribute to gitHub for a university project supervised by Mattieu
Moy.

The principal project is to improve the git-send-email function, for
example we will try to implement the possibility to answer to a email
by keeping the recipient list or quote properly the email body!
Do you think that it's will be usefull ?
Do you have any other proposition to improve git-send-email ?

We are new in the contributor's world and we surely need you to
succeed this project !
Do you have any tips ?

Thanks you for reading me !

Nathan, Daniel, Thimothee
