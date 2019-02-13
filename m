Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF9F1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 15:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbfBMPQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 10:16:33 -0500
Received: from sonic307-10.consmr.mail.gq1.yahoo.com ([98.137.64.34]:36968
        "EHLO sonic307-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729139AbfBMPQd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Feb 2019 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1550070991; bh=7B5brMR8Li9658DiraBBjex5cM9/+OvZ6VzVauRc0BI=; h=From:To:Cc:Subject:Date:From:Subject; b=bvLRH1Nme+iMA70zStwmsIjP0kSR/5Q6hgaIXuaz2v0FVug136Saqn8osnrKBOJfG3PFUM25uZvmco7jMIaanZVTQzahT584XzTQ/bsW9fBQpJUUknJIO3B/Y53RNhcbC5KulJgMSRHryFwv1MAT0olwuMxo56zSGYIJRWwP8iXxn6S+VVSnHUr4Xf4KGoUlS1QS9ajQNjdDjAFHCfqAZAHLU+RvHBm7d37cYbt0suMVXUOuUQlAp8HfXNQJVNIvfyCzAr1EWYOya0XoVMQUsq7sFLVaHOm25gKg3fkWfK/nSytAYliRuMG+Bqx9Rp4utzvcPTfnVio3QP7GSKQuWQ==
X-YMail-OSG: gbVdu1sVM1kw3TpJ_3ol4zzfhkNO3XBAijB46yXFQr.fAX6bow1hK1OOiRds.Kq
 bHNp2RaSZxbkv0u.jsI_47T4bGw44xUhMiRenl4BQJMOWp_csntl5L7IA5uULgjqXn6WTZciwvdw
 tAc8Uu8YiJmnCpTqtdXofugaKX3GEztjE0bHmMVMNj9Jg8MXiDq9e4aReed7k2N5P1hZnzfM3Uo8
 A3Vj1UzWDdfy28RFA5V_ahRJHV3ifM5jRYIY6TBKf0dOTHlKEIzhJjLXguAaq4hN72CbY9CWkFzZ
 1.R5OoteTzpRCbMYfgvc8si8PTf.wYTCKjTR6A_7b1bwFKqIDozoazbBiBQ9Cptl5X_eiwh3W9R_
 EEKRpwoRbBAjJPC0Daf3C_Du88KpYMeUiAqpq6GNfveKTB7awTWwaDw.aYZaLffIiCRqpcaJ9d.3
 65J06wVevW3aoKCLJlnVoXtnb5N7wKpd8xfAw9p0wOaBs1krAUtugav_JJBZ.RXkffVqjkJHSmNQ
 RCFI_fCcqEUqIC4FR8xCXIJSQvfKmXGLGaiia5zzUxwfWhWDazxADhih78IAoVxOJkQ7Xo.bCGvD
 6SiVSCZURffrCy8_QIqC86RmOG9Uo3w2gC0hQAILGamm2SJ4RT3CS_44s7cuqIrZhLuSXZckhOqV
 sMB3JGz_fK4EfUAzZ8INkCy4bTfzpWZTSUw2_h4VFpMn4OnjKMt8z0uTnaAAzDDD44_5Rd2JD3GY
 UtVrFJJjBkkQSnrOkVjJLShG7hIFI6dzVaA5Md83sk8eR2QSRA8cSA.aTFjB5hRumoQXoH8jHAB7
 gxuBU2nqxwA6JXVXVKdAi65ILVPQAWxP40_Ik_K1ArpjZq.NrCWbfEOQE7Rp0B74tiBHdmAa6sp8
 yzmAGC7egIbKpDtc.gAx4Fg6skRlV.tS6csGX2GYJEeYk0Xnfd72nLmwL71sqf6EZRf3TGdymdSJ
 Y6feE1MqCIgF8lBNEG7.W6nuPsq9WF5M3_KxRRGu8gyQc_QXGdV34xvcIUMkq54w6_5P9kGQt5d5
 800fhGexXSpP9FgymU7m5Poxq4TI6oi6uFCDwylaCN_4duZU8MaQVGUPu.0OM0MuSQSyx77Z9Vta
 ZE_OgLLaMAghYpdbaD0Q-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Feb 2019 15:16:31 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO gnash) ([99.229.179.249])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 13a37df2a76b10d255b15d99b59bb6b4;
          Wed, 13 Feb 2019 15:16:29 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Git List'" <git@vger.kernel.org>
Cc:     <max@max630.net>
Subject: Re: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in 2.21.0-rc0
Date:   Wed, 13 Feb 2019 10:16:26 -0500
Message-ID: <000501d4c3af$1748b100$45da1300$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdTDrjPWsIGtW/hbQeSrsy4F/OWadg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-02-13, Max Kirillov, wrote:
>On Mon, Feb 11, 2019 at 11:59:00AM -0500, Randall S. Becker wrote:
>> Hi All,
>> 
>> I have localized the hang in t5562 (previous thread) to the
>> invoke-with-content-length.pl script.
>
>I have yet to look at it more closely, but there have been
>one case of misbehavior due to unintended reuse of output file (see
>https://public-inbox.org/git/20181119101535.16538-1-carenas@gmail.com/ )
>Could your case be somehow related to it?

I don't think the lack of curl is an issue (one thing mentioned in the
thread), as curl works fine. We are on 7.57.0.

As far as the unintended reuse of the output file, and issues with pipes,
yes, the NonStop is very sensitive to complex use of pipes and much of the
compatibility issues we have had relate to those (usually Linux-specific
pipe assumptions). That is where I have been looking when trying to debug
this situation (not yet found anything). This could very well be directly
related.

Regards,
Randall

