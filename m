Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFE22018B
	for <e@80x24.org>; Wed, 20 Jul 2016 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbcGTJny (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 05:43:54 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38661 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbcGTJnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 05:43:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id o80so60140229wme.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 02:43:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kpkk+gtwHu2VV+rAVW/dvdrWNu2PaqnVpxjsoPYahho=;
        b=IP3mQlpE7FbdNrozEMtKEpOhdjVjvB/NAbAMI3ogVUHhUSk+TdQzNg/CzUxUiMkOIx
         /1MDfMDDz2oF8Jf4PwEcydyGyUdZ8RblkRe3jRa3ur4zbYgQYlBDsFuHVCWbVEAUSKNI
         w4mYfEg3PWPYKV11KioN6T06JQDeWPqo+XO+6QNXRJJfmczfkgJc5UHuvmPuW1mZQPED
         GLnihGFKlJ5VXG2QJLH7Zi4zBiIgUjYLPhI3Uh0BRqR8He7RZRvl+v3s+LZIDKKqUjkL
         yRvuXr6a/MH6gOb3CTioc1qrczucpaviGigiR92y3ct+DJHkptzq5N/YNq/faf2OIcxq
         o3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kpkk+gtwHu2VV+rAVW/dvdrWNu2PaqnVpxjsoPYahho=;
        b=hqc9CXL5I8ChII792Ce52RqGbw7WwXu81gJb8koh/x8bFBGeGiESpH3YD5xOX1kHvv
         r1qnGP9Qcb12ceGrV3tEpE7lnNF7b94wPsAQ+pgWCLCPtGsu6+7lRyvUgRCdX1xREE76
         ZsEX6S5BGUE1VH51hVsw9UbHjl58v6mXoj7zn81+/6CKIKe4xmfL1S5Mcw6ORobM1Jv5
         logW2jymJ6fHYcxf1FFmCLC+aHgm6S54xaxGAn5QhNxQZYFNkD85wtU5JeGayij0wGWv
         lPFoz2h4IriwAE7Lw/b6uX9KqefmbdFYGbsdSlcP9D2AW9H3LXRjiFuG9MXPLz9RKd94
         zhYg==
X-Gm-Message-State: ALyK8tKDvzCljDkl16G/Awnd6+tdbLtCh6/1G2s2/2KfDbeSvoHLSs68AvgNOKeOTP8apQ==
X-Received: by 10.194.25.105 with SMTP id b9mr363985wjg.20.1469007831146;
        Wed, 20 Jul 2016 02:43:51 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b186sm4148925wmg.23.2016.07.20.02.43.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 02:43:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Looking for help to understand external filter driver code
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <578F3D5E.2070201@gmail.com>
Date:	Wed, 20 Jul 2016 11:43:51 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6CD48865-8D77-4582-AB41-FCD27D41017C@gmail.com>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com> <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com> <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com> <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com> <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com> <578F3D5E.2070201@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 20 Jul 2016, at 10:59, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-19 o 23:33, Junio C Hamano pisze:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>>> Git writes --> 4 byte filename length
>>>> Git writes --> filename string
>> 
>> Why limit to 32GB?  Perhaps NUL termination is more appropriate
>> here?
> 
> Errr, I think limiting _filename_ to 32GB is a reasonable
> assumption, for forever...

Well, Java packages can get reaaaally long :D

> 
>>>> Git writes --> 4 byte content length
>>>> Git writes --> content string
> 
> ...while limiting file _content_ to 32GB might not be
> future-proof enough.
> 
> ;-)

I think this is what Junio meant to say. At least I 
interpreted it that way.


- Lars