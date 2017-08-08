Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C5320899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdHHWel (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:34:41 -0400
Received: from mout.web.de ([212.227.15.3]:55631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbdHHWek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:34:40 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5x4z-1dQGf039Jp-00xo8d; Wed, 09
 Aug 2017 00:34:31 +0200
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
 <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
 <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
 <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
 <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
Date:   Wed, 9 Aug 2017 00:34:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Cv4h9e3I3NRk5y0U9Nkg/lAphS5+GTshX3sJ5rzrWowgr3lUMEQ
 YtACBAQ0afqBljnDGFOBite4tpH0AMOWK2ZQy2QQvV+UQTDJ5CA6ggsZUNr5OaE/Ut0v5kT
 Pfsxcj+4WD24VYI9TjHUN/Q9ASYNpElagUnWhcaY9eyAlbjMZYJVZ9wxpqmy4K+YMAOSSAE
 BYMsoOHTCuh3VM4aCLZ2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9N9BT7bqQ6E=:odE6PbBrLScE5wrm7yTygk
 WRHTWGeKKIagO94ySgw6mTfV84e4N6aTS4waT5986WzrIH2oxmzxKvQVD0Nl0XrNVRwpRIDdM
 Fz3CsWO+3dWZkRDlO5+56uzpexXAbY5S4J1l6kK5IbwIC+ZtK3oKn0e366SU2s5YBYtcNuwDs
 kBxzovkASccWr+++ql/kKNuA++IX17oZ82IDJgd6qKbwrcNKiN52HTLfnSlTQ9unY1iDHZJoz
 o5/JkDAaOxW9yMiBgyZsF/tCK1GqC4eIVbjr7i6hPCQxb2FjPC4tCejtfRmZrNINpZ5ot8Qg7
 BMKqwNHXsK3Q0DmKYlmlFq3A7/GZwdsO3HW6umOzTiOh149Azzc7ja0vzJaW4JgOM8clTTk9E
 Q07PiL11+e6LWSV+6X257jgirLJ99im8i1RRXhSjXDeY07p3ycwXjRPeaIpvjkBLY8LUoucxM
 IFGrlrT14cB74UbIa+sdBojadvR7bDHyRd2EPgFT5o4W5ao1zsu7f2w+bTXMf/JaWAQkcVu+G
 RkmePNezNtWH+HVcS2iLSLsFyGbqHxzFieYvk2N2mzAcHTkTu0OJrhRXNPE8y/u2YNTr7eig3
 Z8STFe12Q/M0u+lQTIPqw95nGVYHDpGJ7ZG47l6Li0nkCKMIMThZEEDoQPqEne9+CnN/yagas
 X42bOlxorJnZVpIl2NOKp/0ZsdAGWQkUqMy9S1EmjxugCHJsFyDp49FJLMhrpMZicPJ8QLsfA
 CiSrGES5bdzV0Q7cPBRjq2kapl9+69p59xNRmp54FSWpA/tKtHI52SpMBR+TlIxjqR9ZaeTCl
 MzDOdy5eLrmGoWkCNYZ5m/w1r2/ZVFf5qGasZf1axgLraI+HfY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> So I find Dscho's concern quite valid, even though I do believe you
>> when you say the code somehow segfaults.  I just can not tell
>> how/why it would segfault, though---it is possible that regexec()
>> implementation is stupid and does not realize that it can return early
>> reporting success without looking at the rest of the buffer, but
>> somehow I find it unlikely.
>>
>> Puzzled.
>>
>>> You get different results?  How is that possible?  The search string is
>>> NUL-terminated in each case, while the point of the test is that the
>>> file contents isn't, right?
> 
> Intellectual curiosity tells me we may want to find out why it
> fails, but in the meantime, I think replacing the test with "0$" to
> force the scanner to find either the end of line or the end of the
> buffer may be a good workaround.  We do not have to care how many of
> random bytes are in front of the last "0" in order to ensure that
> the regexec_buf() does not overstep to 4097th byte, while seeing
> that regexec() that does not know how long the haystack is has to do
> so, no?

Our regexec() calls strlen() (see my other reply).

Using "0$" looks like the best option to me.

René
