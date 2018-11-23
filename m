Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779081F87F
	for <e@80x24.org>; Fri, 23 Nov 2018 02:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbeKWMwU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 07:52:20 -0500
Received: from sonic312-26.consmr.mail.gq1.yahoo.com ([98.137.69.207]:37348
        "EHLO sonic312-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733249AbeKWMwU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Nov 2018 07:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1542939008; bh=Om8exQApnLjzflPF7TtGLPa1bOv3D1wGYM/izg5Xly8=; h=To:From:Subject:Date:From:Subject; b=PFFmt/9ERkMzcNN1tKKLVul+2s3OUWZztHtNwLG+06zhcslBMlXRAwzpkC+7oi25pjVbEnE8GCpBYupa20yxQIOffCvMyADRKuZhQs5j3hUsTTFjkQUhxK87vfQXrSwiA6ajzrFsM3CoZG6hKoCr20eGdQGrTThy67zj/KuY3qM=
X-YMail-OSG: MfJAia0VM1mtLfcBG9m0ItvLJYGiqX2BYyd0eE1PnAWAvcwyGsF8B9raQvf5WWG
 mDQDTUw3ZZJUmJbzRNP.kUYfWy5_TkKEmzjAO4lPjfR3KSYsRBZac88f83dIeSEsvR7JNaQpY2Dq
 0oAdE0sWvvDgyIyGBvCLmLXa3QDrLTMIwmhsFdks.7WkHqSvNGgHxEiBExRNJEYEkrQLvQPdJDgp
 VrOvSiy_Ecds0ujS9Ej1UxenxygPqGEc27HvF0IY6fYt8TXbuchpiYCFmAgkTXQvRl3rB0GXGANa
 B8QgUSavKek7OC4JhtMDMCphhY.aI9YtuwdS4Kf2h3UvRZ54C68NMuHBcGkpeYg8R7NfrP3M4WuU
 _hdcQZ51focTwI3Ylwwt9towIHfRmdk5ssRrTMbFZJbAveMMdp1CVzZQMu0nCMONFiBMc4Nz9hs5
 W7D4sxmijcjb2Q9U7R0u4c3HUEmvS_Qt.G..ctKf_quDwHG8AmRRS4Qz0P9qI_FSZihcuZTNjm4c
 j1H57NNj5X8pWEzCxY6B..K_kvQ2nzMLQJG42mXDoigZ57PAZMpZk_BhkIhyd6OpNdEc2O67aimL
 W8eTCNzQVcWws1T_iJW3tPYfFpau9NJbjwUMywWCOK33qE2jTPfIkslGGNDMUxBk98CgkcaQqYfC
 cUw9TbQVwYWDJlzA6DKTXitUxSCgAM9t.3HCx3Nx5CTrpALPPmNLp4SaA4faAREMu.1uQ9cCKhfT
 okkynHngxfs3Um_iG3knCFpbzucpBS0x0x_IyTtE_7GjFidLpQZvcmNXAfrrcA0VEev6UbrNRAoK
 fhK1j6n0iOEdLV9Og0nZXWsIFvLuVik.x9MkWxHs5Dvj_0DCxte5oFiqvU9Ti3NtyrZ5vVo_XCAq
 1rmECDuBdfYt7rusqLbXSmwD0KnXjscC5eLsC4wNRdXTnfamkuLzYBiOpZbsTEGDrmLlnhB.ma2S
 VQwj_LR2OmxC6RgUwkn_pIiYuFFiaHdUWjk2wj109S.Rl3Cru_WtDZHT9xpx96fWyV93P8eOrA3f
 IAWsDNonyks7sKZAdWjJFsuEI2.SbNztHtXWFOhk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 23 Nov 2018 02:10:08 +0000
Received: from 69.231.32.124 (EHLO [10.0.0.3]) ([69.231.32.124])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0452d28febddfb4b0d5918ea65c8f78
          for <git@vger.kernel.org>;
          Fri, 23 Nov 2018 02:10:04 +0000 (UTC)
To:     git@vger.kernel.org
From:   Paul Gureghian <paulgureghian@att.net>
Subject: 2.19.2 wont launch
Message-ID: <6b43658b-73e3-e009-642f-c46c5bbe2b21@att.net>
Date:   Thu, 22 Nov 2018 18:10:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I installed 2.19.2 on windows 7 , 32 bit and it wont launch.

