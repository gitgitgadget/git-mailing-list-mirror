Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF8C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiCJTtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCJTte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:49:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA24C42BE
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:48:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l12so9219637ljh.12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KDZKCRS1AbVVpWZ9Ubx3Ajz68ocOL0e2HHkaIH+fR/g=;
        b=cS3IM74d3UVte0w+eDFQptEPW/k3xWFDeW5SJ1IsLbsiNvHo+P2KvI2hswqQHrFK4g
         23qAeZ4eG0/zFYITRMonpTCWHHw52tIYQrZk66rLdNPlndWQl2jLS31ykHK+1tLzvpUC
         PmCD55SlhEtuhYM73bmvo8wJveyDvhFAs8Syh02m4b2CMBk+uHhT1JHt91iAEmheczPv
         4l8QiT1a1UZZGMdM+23AxhX4VYUQus0EtbzfEDyN85AfNbC4waNlhW1Wsprnc9rO/sTR
         rHZtE2NwFnNJOCcNIFubLQ1MKdAM2W0K98w7ceFlIFjWsrHuWLDxooojGSEd1wivJdoQ
         Nzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KDZKCRS1AbVVpWZ9Ubx3Ajz68ocOL0e2HHkaIH+fR/g=;
        b=Wb0XiEIqK9jOfoDUrGpKB1ZmkdACCW0FYzP/+lNOym8LzNW+veFmBIYZ1fjvHtEw3e
         Y3jb7Q8GZ2ku3Lqww+kmovgGuCK60aLa4Bj/w0t7tAzhq7rdNUedDb7cWzSvQlWZv0EO
         5ag9DZwjspm6nWXLMT/zYzERLTQrRQcUTaBtNj8coQgUYw+RFIWsobog9Y11222YwYAw
         +7OdGHlnVCWnIglOHmh24CaFeZVGvCuCtMMP4XmPR+ao+TnnhNtlCAAfgHQmmLIAyxmZ
         Z7ZkcfU4sMIPlAIy4J+0YWrkNDbE1JLhffZTbd/gKh7R42LEnEND2v/qPwKdpggg4Mmc
         ZKMA==
X-Gm-Message-State: AOAM530Cp8/vVhLsXXWTpUETeGP+k6mvVg7f5oAN7K93Rs5tEzyvDfPx
        cZ5K3wsSoQm+SQAm3JZTE5g8ynLl1ApR3sn2HRNryfgQnBXGDA==
X-Google-Smtp-Source: ABdhPJzovpBlpIDaHXkkgCLdS50bKGr9+N+usW/zRpgoORb5Km2+pVNtviJElRXZH4mM+NDo/Gj1KpMxqYXz8t0h6Q8=
X-Received: by 2002:a2e:bf04:0:b0:246:7ace:e157 with SMTP id
 c4-20020a2ebf04000000b002467acee157mr4053354ljr.241.1646941711203; Thu, 10
 Mar 2022 11:48:31 -0800 (PST)
MIME-Version: 1.0
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Fri, 11 Mar 2022 01:18:20 +0530
Message-ID: <CANsrJQdTa_xJynpCrgDxdeqdxbGzg3wAgUc4DQEBrUVnoK4gpw@mail.gmail.com>
Subject: [GSOC] Applicant Introduction, ref: Unify ref-filter formats with
 other pretty formats
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am Jayati Shrivastava, a senior undergrad at Indian Institute of
Technology Roorkee where I am majoring in Electrical Engineering with
minors in Computer Science. I am interested in working on the project
'Unify ref-filter formats with other pretty formats' under GSOC'22 and
have been exploring Hariom's and Olga's prior work on it. I have
previously contributed to open-source communities like Mozilla
Firefox, Facebook's Jest, phpMyAdmin and Apache Airflow. I am very
enthusiastic about joining the Git community and would love to
contribute to this project under your mentorship. If the microproject
'Use test_path_is_* functions in test scripts' is available, I would
like to submit a patch for it. Please let me know what you think.

Regards,
Jayati
