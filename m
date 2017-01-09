Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E340B20756
	for <e@80x24.org>; Mon,  9 Jan 2017 07:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750773AbdAIHtX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 02:49:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:54358 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdAIHtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 02:49:23 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcxtm-1c8HKT2vtS-00IEyf; Mon, 09
 Jan 2017 08:49:16 +0100
Date:   Mon, 9 Jan 2017 08:49:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d
 git_exec_path()
In-Reply-To: <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701090848520.3469@virtualbox>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de> <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de> <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
 <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EC08dXYUlQvHKxjDrZT2Sl3Qwtvkt89uoKx9ryNBHFz1Nql53b7
 kwlhOX8ei8p2w0MZkqieIajSL6mObThodNJGVNITJfFzQRekexo4BgM25SvZPTR/0DQwEf6
 P/kr7oKApL19qvsIc+ikPYhlt4m5IddpTb0pwZ7oACqghT+k+BwS1kPGNaKbJh39ZCuz6tU
 fDUVPbq1I483ijqSqWNTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NoCtoNcdcpI=:z9gyKqNMwvK1mUXL3e16h8
 jSMIYt0zp5B0DHuN9pfKBQsNgPBif5XtCyz8aFLsozuMp6g5d7Y1MpZ71WjhoYzJ43qWJGjeS
 8Us+AssmKRgrn2+9MFRQgGwIrsm+ws876th0vQaJ3mu3R+EHaWB0bA5hp8meLRCtLflgo9q9K
 zU2kPIigPu8JdAxVJqRnwvtQ947ASt03000guGy+JmE4FtEDjU0FY6Ric9eedOnyPCGK2I4KG
 5ZsIT3onvNJ/eytnlcv0SUGk7ZtsrZN+uH57HmPt2Df/zzUsC8lU9EMQNbKfq0+9/mXO3E2a8
 GRGNAoG7y36fUrsTll9q5lqXX4zw3oOZn9Lo43ai32ytY9vQ/qq6fvfIvz+MuS2oCzq9ecq4D
 5NlOmVMydUInRjGqLG8XxpsqzSJs0Q0xltlK7+/OGmqLmLnwwg4cyBmPHZBMraLG215Sj8oUI
 6C3iBmsHt8Ni3/vdPwJ++WrvlZmC8X9DFpqAR15zbDYgzC5oyly49sRKN0kerCZenPRCB6mO1
 WeUszCP+Ca+q5/N6pJUhoGijomh1EuUNEVdRKknDyICtWlC6ANjhpPhq2j+9Secx/peCtQEjT
 DZbu9XDnHk1SXXa/IbSt4vmj3ou+4U8PaWIAkZB41IHtlWLSsDDkupVmeFFkzmAdeaAIy/Uu3
 GkfoGm6Bt7a2Sy5dNwR03OCZMW6NSfLrtUD49fUDJPMq2Dy64lmd8PmO9zXNRmzRJdUwrAD/a
 AxcfhvNqknFQSCFoXZOgHaPNVC2R1dXYnPHK3YXCYqu8+p0Ha5Ae0UGcvdDnKnlLsESr8E8C6
 5BJGM/5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> How about explaining it like this then?
> 
> (only the log message has been corrected; diff is from the original).
> 
> commit c9bb5d101ca657fa466afa8c4368c43ea7b7aca8
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Mon Jan 2 17:22:33 2017 +0100
> 
>     git_exec_path: avoid Coverity warning about unfree()d result
>     
>     Technically, it is correct that git_exec_path() returns a possibly
>     malloc()ed string returned from system_path(), and it is sometimes
>     not allocated.  Cache the result in a static variable and make sure
>     that we call system_path() only once, which plugs a potential leak.
>     
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Sounds good to me.

Ciao,
Dscho
