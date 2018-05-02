Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B05721847
	for <e@80x24.org>; Wed,  2 May 2018 02:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeEBC2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 22:28:22 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40518 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeEBC2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 22:28:21 -0400
Received: by mail-qt0-f169.google.com with SMTP id h2-v6so16652747qtp.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=fy/bkru8oQyw5Gm7gTUzRiXRXDl6RW2C6JR9h+G0gD5fKZqGq74smGkLpbtymnVrGY
         k6mh5nwIbfkeq/LIP3Nd7KNTvBNlVKWS6ngzQKv0ClZUWMjvzfItvf5s+yCL0zlOA6Ld
         G0Ade53hCNgHqPRQpLp/pbXoblgycc4HMBJ5P6LTdi9adm1tGXXivutzCmpdz2BiMMBn
         xvKAYY3elqDWzMd7gcwz1IA5F2CkrtqTM4J1XmMLyK4o3Xow1s4lehjAcnhnaQ3NyldJ
         zrm/6BTcKF41cM5akyPlonyH9Sa0Ukn9/jUrKP49Zl5NgljkhmT1GSFl0Gu2Df64xrdj
         dpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=VymPz3kFJdJLXfeFiLkuikkEjVHAHO5lj6Fq4mMw2w7niA5LYRDCiBQCLj7eUFL0tQ
         DWrGZ/zwtymVm6kkK8TGyfb6+fkYDH5Vp8NO9+sDLo3Ym9/DR0pz8me2F/Wec2c+nvob
         M2L+XyRgHDy+bL/CMhS/vjJ5Q8M/RPREyU6P3wU38fzi3BzodKZ5U5rbvvlfM7dCj3Xr
         NtWixDQf29yqfFsFET44mfqANoc9Q/JfhHQK+/h5v1n8u2Oj1xGTQ9QVqfiMkt9mF8vn
         srxGlL6Ytskk73iByws5xyFSz2xAQBz4TjBeGJZd7gST7wSTjRCu+dmLGyHKFdp8Eshs
         nJvw==
X-Gm-Message-State: ALQs6tD/KMAGO68hQXIIN9n4YO4Vy7knOT9B9vVIZjJ2BoH2E9Cyudat
        1chCWiyu1YZnpPLrvhsALbCQXsAT
X-Google-Smtp-Source: AB8JxZrB4t6CL4bFNoDZ++zLEbCxkcRFELIn+Ba2fS1LMMeiqzJEzuHLjcdOUl9kSm6s90JS+hhFkw==
X-Received: by 2002:aed:3641:: with SMTP id e59-v6mr14939783qtb.341.1525228100978;
        Tue, 01 May 2018 19:28:20 -0700 (PDT)
Received: from [192.168.0.100] (modemcable130.160-161-184.mc.videotron.ca. [184.161.160.130])
        by smtp.gmail.com with ESMTPSA id u22-v6sm11000295qte.36.2018.05.01.19.28.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 19:28:20 -0700 (PDT)
To:     git@vger.kernel.org
From:   Daniel Villeneuve <dvilleneuve.4142@gmail.com>
Message-ID: <8e8b1b1d-9c66-d30d-8d10-c23dce533dd0@gmail.com>
Date:   Tue, 1 May 2018 22:28:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe
