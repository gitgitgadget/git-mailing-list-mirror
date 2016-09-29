Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F93020986
	for <e@80x24.org>; Thu, 29 Sep 2016 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbcI2L6J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 07:58:09 -0400
Received: from mout.web.de ([217.72.192.78]:53294 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755041AbcI2L6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 07:58:07 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MduAD-1bYu3c0TnB-00Pb4t; Thu, 29 Sep 2016 13:57:49
 +0200
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
Date:   Thu, 29 Sep 2016 13:57:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jROvP4EsfMFFQo6R8hJz0RhDthEzJq2wEd4xqqCOTKbsEJN2lYa
 aqDWVcvJsIpwISQ/ZEZpd23vx5PXV4Vi3cmD0JBMasrR7rxuvQiTvrxVWdm4oLq4FVl4Eoq
 zG2xzwB3YLy6kstAEuYghcv3URQIhM2DaNy6ikBiiQOCo/0MCLPPKPXa4gzch3lhqbQmAto
 KJTsOkvaxxCFnX/1uNL4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KYyCOWv90os=:MFZxjnSgEfeQgph+afq3Jd
 8dGMvf0mBSqoh8tjauHvsXZj09SGSd1tLn9a34fIG9Eb4oFND4pNIdQo25U8lmAThxu21SLBw
 8/Oi1xZF11rz7d7WbjeoQU3sB+eftbo6MwXGQ8wGbB0H01H6TxVM+nCYjnW0QDbd8kDJ+QxqJ
 WDw/dZya+kovBfPfx04cGrbF5fzrNBoz0uSsXFIYMTbVzeyT4VTs0js73SR06VViqS0Ky9CQR
 1RciJCuoRRcq2aHX6hktEUDdkBZELbMWPFiQspPk/JU17zBUZyNX1DndIUyAP3NCtEA8CGLFC
 cCBbYa1xIIZC4akMg3x6bHt88/QFbE6H7Y8pNNuDnrPYZ68XEDJ+IO0MgDB9L1DCgA835S6RK
 xPU4g9GoMZc2dwvzztmT3L7krZvSIdYiIU84mwvNboDYy8/Xm4EOyyFGLyUfwq2xrX2S7Mph6
 NIVtZs6lu9+wWJlE3iA2mi4xzC5eRIo81iqOwKhMpcha5ug+OiTTZXb89SC8sRO56hPK+eb4R
 CzG3vgOgmU4XNMrVZukDLmj1G3YfiKkYogzBbrwvbakt/qAw4EhRmWQ5UybUgex9RzMY+pVe9
 GO8RvW32+aeZbp7HAwuYMjfwlUM1J9Bd3vl4WdSg7bAr7n0Uy7+A261VNtEZO0VO3PAqbRBUW
 9HLUKEJsd0xy5lYrVqMNMkmHoyHpCNd4dRrMQvNbhYvWkvR3ZHnoCXZUvopOcT5bEkLTOgGJ/
 eYN9hWN+t8xW5afGv1ZwwtS0XRoc8M8MrbS1FiL4XitejRi70Y8tbblaeEIeGGroGDQVfyTKy
 oTowEEUTlQp5f2QDYjGdq/5Q4JPgT61lenpLPrHQ12+fdhPXoUWIB+4VIroCxFSAi9l14S7yA
 iRFn4bKCp0XT1ExnRsag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/09/16 12:28, Lars Schneider wrote:
>> On 28 Sep 2016, at 23:49, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I suspect that you are preparing a reroll already, but the one that
>> is sitting in 'pu' seems to be flaky in t/t0021 and I seem to see
>> occasional failures from it.
>>
>> I didn't trace where the test goes wrong, but one easy mistake you
>> could make (I am not saying that is the reason of the failure) is to
>> assume your filter will not be called under certain condition (like
>> immediately after you checked out from the index to the working
>> tree), when the automated test goes fast enough and get you into a
>> "racy git" situation---the filter may be asked to filter the
>> contents from the working tree again to re-validate what's there is
>> still what is in the index.
> Thanks for the heads-up!
>
> This is what happens:
>
> 1) Git exits
> 2) The filter process receives EOF and prints "STOP" to the log
> 3) t0021 checks the content of the log
>
> Sometimes 3 happened before 2 which makes the test fail.
> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>
> I added a this to wait until the filter process terminates:
>
> +wait_for_filter_termination () {
> +	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" >/dev/null 2>&1
> +	do
> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
> +		sleep 1
> +	done
> +}
>
> Does this look OK to you?
Do we need the ps at all ?
How about this:

+wait_for_filter_termination () {
+	while ! grep "STOP"  LOGFILENAME >/dev/null
+	do
+		echo "Waiting for /t0021/rot13-filter.pl to finish..."
+		sleep 1
+	done
+}


