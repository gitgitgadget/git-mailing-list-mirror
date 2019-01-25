Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7C61F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfAYTmG (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:42:06 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34304 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:42:06 -0500
Received: by mail-ed1-f41.google.com with SMTP id b3so8297563ede.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iFw7AgTLuKOmoyAG3FrHw+s29z19Ti1XhRLFat2+nuY=;
        b=oOU+lICtAwv+UjLHEG6UgR2GoWsTgqr3dVXlopaycpocKlYO+Ku4648MNYCwueK1kf
         yOVG+pBZXEcPh8GX284Bve804i2E1TwL4PNCZnBAgfHqF1FR9f89mhtqNNRLx9NXhIUL
         Sr4O2PGuk52kAAYhKyuiwzxSKMpjOeU9YPn0ESm03eYF6t63s6+Qk7NnStj8G5pX29Gk
         mZHGNzUusmuMOJTmUTu4SA1q6DMJRw4teQOxHUi2NES6BI0/Y85iFVr63DogCjFW832J
         tyvrNrj+VR4v+i+YOP9gOSD8dL2q4jlJe1IqSQAIuHwJQOQJX+e9sRYDUmkJ7ubGmueD
         z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iFw7AgTLuKOmoyAG3FrHw+s29z19Ti1XhRLFat2+nuY=;
        b=U9+40KfmyybHvPS5rYMefVqqXnZbTpdRfwns9j+p1KxT2mgSDkwMIUStWDPwgtKlD4
         r0Smb3B/TLRuFKqPaRIIDAqdplP5gyuvmMKacbFC9G1MiJWZ2Q2qga9BqZRgu23/xhGm
         iLxJj9Ap2CsIt0wqKDaGxjQrCYRfUVaE+/R5K4hybbrc3KPDppQt1ft1IGdC8AD33IKV
         8ayeMuv+WLeNGnDOH6CfEuOCZ/CRzvTDGZjgvLrTEivH/qMJ4UUOhSPpqv3M6W2qHFKC
         6MB4ezPN85qbh9vd1+SjUf3c0EaPfOLX/J0dFmpR3UNBTuNqMlCq2yaZEd8fKo8YIBvw
         2azQ==
X-Gm-Message-State: AJcUukcvUDT2T5YqSF+hn7uWbQD+YcpYIxbK5MFFplOICfG/qximh95c
        SVPDHfYtbihIif2+XRUyL7BlsSV5TYC9OxXONUGvqunDYpWSVg==
X-Google-Smtp-Source: ALg8bN5D5mEgWov2W4qjT8xWAE9HdRCEwJWUDDBGrJMBIZKu3txNue8C7xQ5Rxie0bpKDcxsaP5aEzlpa1Uu0sFnOvM=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr11859808edc.76.1548445324093;
 Fri, 25 Jan 2019 11:42:04 -0800 (PST)
MIME-Version: 1.0
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Jan 2019 11:41:53 -0800
Message-ID: <CAGZ79kaUg3NTRPRi5mLk6ag87iDB_Ltq_kEiLwZ2HGZ+-Vsd8w@mail.gmail.com>
Subject: Compiling pu fails: diff.c:4695:19: error: unused function 'short_opt'
To:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see it is fixed in
https://public-inbox.org/git/20190122003020.9672-3-pclouds@gmail.com/
but not in 2722d068deb (SQUASH???, 2019-01-18)
