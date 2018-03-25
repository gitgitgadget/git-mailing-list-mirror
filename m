Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0A81F404
	for <e@80x24.org>; Sun, 25 Mar 2018 02:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeCYCRz (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 22:17:55 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:47047 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCYCRy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 22:17:54 -0400
Received: by mail-qk0-f173.google.com with SMTP id o184so16789120qkd.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pqPedfen/uZ5Yi5mjHSH4d7naSiB9yzCFu1QDkFfw7o=;
        b=F3IRUyT/nexnU1yPUC2f98K7LriT2/KqLT5hjnUDti036Y98GR67i+q7b8enKIcOxP
         gHlRF/0yGQgfJcuNZFWRVKHVgnL1JUiTbMuEf0jLKq0kRIQshLlAcUWMYW8aPG4g99u0
         bH/EhIM2GXPXDFakLfUdozstacxQwTR906NN/BwGdKZfvaKM6Uhwpnzn8XXn4HXbAq12
         vZSOTu/F4ceSW9Bn1RCueoWb8WGSERf8hMDLizhHrPqF95Pv2ETVHxKdRUzJKe6Es9Uy
         hdj4/YyTgth07vPkWYbE0LwVck1IvLft+7qqhb97QuljJf3BaIzjz6EMrwegD37WSsNI
         xZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pqPedfen/uZ5Yi5mjHSH4d7naSiB9yzCFu1QDkFfw7o=;
        b=q4CedN5A2QJxSKTyIk4RB+zV+8uHsGl+Ipj2AEmpOsmSC/rQUcEGd6/qnKadRKFPXG
         ECioqRegsDDUJKVTA41a+WTulKoN7dZuDpNHiQUKhu9jf29ofKpIa8SGwJuqkep/0JD8
         1D2Dk48qzIMdOaFUUAYwlAYcrWTUW9lyb/0txVNVSVpGn1QoaMRHIvLdrEbVYqx4O+oh
         QpJIMtXyG/xntlryOEML4MTikBQ+1m0GNKl1iiKTXObIkwUkMDe2jTf5DnvO+FngwmEn
         j6YmrVokhsvWgAroFU7Yk83jDxdrpFrchWJRfNZ9RtGiW2v7GRCiZdA3F3/VbE6zJcBT
         NLLw==
X-Gm-Message-State: AElRT7FyyTZ0updcRnaTozM7M3EWx2uhvhMOAsTYsLpQxyJKI/X8bPQk
        /+H5c+tMfltl40o2ykAUK9mQii1Rm6KxGKvV9imIzw==
X-Google-Smtp-Source: AG47ELuWu+t0bQsFSR3zb5wMYtgC0dWWqoFqAPSfxJI7E53ISRWFiZ1DrIM1y0g8NhhR97n3s7kKqPudYXIWZgw1uUk=
X-Received: by 10.55.10.6 with SMTP id 6mr47594221qkk.271.1521944273491; Sat,
 24 Mar 2018 19:17:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.37.215 with HTTP; Sat, 24 Mar 2018 19:17:52 -0700 (PDT)
From:   prashant Nidgunde <pashnidgunde@gmail.com>
Date:   Sat, 24 Mar 2018 22:17:52 -0400
Message-ID: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
Subject: query on git submodule (ignore)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am new to this community ,so please ignore if I am asking anything silly.

Case :
Today when I built my submodule , and did a git status , it shows as modified.

After reading certain suggestions on web i found out that i can ignore
that adding a line in .gitmodules

But, I had to add that line manually ( which could be errorprone
because of typos )


Question:
    1. Is it feasible to build a feature like :
                   git submodule "zlib" ignore dirty ( which will
ignore submodule zlib when its built and dirty  as it has new files in
its directory)

If this feature is feasible , how do i know if its developed  (
awaiting merge ) or can I build the patch ?

Regards,
Prashant
