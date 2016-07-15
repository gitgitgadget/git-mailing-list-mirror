Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D993D203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 03:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcGODA2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 23:00:28 -0400
Received: from mout.web.de ([212.227.15.14]:58095 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbcGODA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 23:00:27 -0400
Received: from [192.168.1.99] ([173.209.153.59]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MHJEh-1bbvyb1MSR-00E5S5; Fri, 15 Jul 2016 04:59:55
 +0200
Subject: Re: [PATCH v4 3/5] archive-tar: write extended headers for file sizes
 >= 8GB
To:	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090916.GC17463@sigill.intra.peff.net>
 <ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org>
Cc:	git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7ad7705a-40a1-cc2c-e7ea-47d83e1627a3@web.de>
Date:	Fri, 15 Jul 2016 04:59:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:26UtKvJ8GAUvoa5jyOO6VW0wYEeOD8njO9arQh7cMax8KHq+98y
 eyJYzUCpb4UAUbx3QFznYgn2cK+JBZOP42uzS46ZuTH38GMyz6+EdkN4KDWy7QIJIZ92q55
 uJbAXrutNxPJdB5mcF7+bzgbKhWtlO4i24x7c5PHaidiT8s5RJHP0UHYiEoSMJIVl8pPPFG
 C2xnKK0EJpPLiMYnXmd3Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QAn9C5TXTqU=:APIVXC97FrI7Ib5ixWkqMo
 DMSrWsiJUk5M22R9iXfE4xpFgb59BweJyBVVVeIbdB/jVuu5czxAr2Q2u91j6NmgSFbRAuhwg
 s+YqReVaLgXW5g0dZlv8KHWGxE3HHRrFuK2s5ApRwBGyBqU3YbH+TnX8SP8kKuo0USSoImxsH
 LwhJUqoJ+8RAS26zr0VI3QRcMHkqc7kkl3o3qugAFyFvgP7SuFLINyRw/IyoaLnq5GFRj2E5V
 Bl1VEK5IxVYfzeSahA2UhrlQs2l0ZLOH3LfRsOKM1yMqKXBUA1rxfp2G/FqfPWkjCPTXbZkEt
 Pj5WpspLC7IT7YuoUOK3lcWy37UiaCnxxmDal2MP8qlPk22EuwSe1h9cHKphUB8FxVnjD78Fi
 VOyns1S0OkhtWk3P8x2A+eLzD21HKrRvEbDV/lxDst6wLotrDTJ+GL0fy+bBLHPqfoxM4mXaF
 pSNrs6ZwexjDRd9Uvb+/XkMGJBfP3QadKwQ2Aek5t+HxGvsmiHCH1z/2CHADA8gce1P1OZYVI
 8XDBU8O+GARdxCo3h7TpBaLG1OxX/ODBDg2QG+6076Zpcthazq2QdqEEZow3rPCd4mpSJFR5m
 SBsuoaWHvKokht8mRMtrHg+jOfIRzMUDvNIf2xBdywRRUudpnuVAtkPxf6mHYciDDMlZ/qffp
 Hvzuv/VnlFuNcAzOEdYixhTl+7uz00s3RRGiw3Yn535Tr6fBFb7owASKyvW0P6e2Z+37683WY
 KAImr7mURe4itVuPJWu6BPEbcp3oAFNc8U7puJH8R/taR/9X0KRrfqnmHOLt9YqWC/Gp5IvQ2
 IZ+ywGb
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/14/2016 06:48 PM, Johannes Sixt wrote:
> Am 30.06.2016 um 11:09 schrieb Jeff King:
>> +/*
>> + * This is the max value that a ustar size header can specify, as it
>> is fixed
>> + * at 11 octal digits. POSIX specifies that we switch to extended
>> headers at
>> + * this size.
>> + */
>> +#define USTAR_MAX_SIZE 077777777777UL
>
> This is too large by one bit for our 32-bit unsigned long on Windows:
>
> archive-tar.c: In function 'write_tar_entry':
> archive-tar.c:295: warning: integer constant is too large for 'unsigned
> long' type
> archive-tar.c: In function 'write_global_extended_header':
> archive-tar.c:332: warning: integer constant is too large for 'unsigned
> long' type
> archive-tar.c:335: warning: integer constant is too large for 'unsigned
> long' type
> archive-tar.c:335: warning: overflow in implicit constant conversion
>
> -- Hannes
Similar problem on 32 Bit Linux:
  In function ‘write_global_extended_header’:
archive-tar.c:29:25: warning: overflow in implicit constant conversion 
[-Woverflow]
  #define USTAR_MAX_MTIME 077777777777UL
                          ^
archive-tar.c:335:16: note: in expansion of macro ‘USTAR_MAX_MTIME’
    args->time = USTAR_MAX_MTIME;

----------------------------------
I want to volunteer to do more tests on 32 bit Linux ;-)
Does this fix it and look as a good thing to change ?


--- a/archive-tar.c
+++ b/archive-tar.c
@@ -332,7 +332,7 @@ static void write_global_extended_header(struct 
archiver_args *args)
         if (args->time > USTAR_MAX_MTIME) {
                 strbuf_append_ext_header_uint(&ext_header, "mtime",
                                               args->time);
-               args->time = USTAR_MAX_MTIME;
+               args->time = (time_t)USTAR_MAX_MTIME;
         }
