Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E18F205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbdABST2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:19:28 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55274 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933285AbdABSTC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 13:19:02 -0500
X-AuditID: 1207440d-8b7ff700000009ba-6d-586a99947511
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BF.23.02490.4999A685; Mon,  2 Jan 2017 13:19:01 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02IIxeN007481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 13:19:00 -0500
Subject: Re: [PATCH 14/17] sha1_file: introduce an nth_packed_object_oid
 function
To:     Jeff King <peff@peff.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-15-sandals@crustytoothpaste.net>
 <8c205558-928d-42ac-d401-e73e19c96030@alum.mit.edu>
 <20170102170902.6g6bxvaanewxzm2v@sigill.intra.peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <eb8a3dad-9ca7-e0e6-3c31-9cd2e02e0bf9@alum.mit.edu>
Date:   Mon, 2 Jan 2017 19:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170102170902.6g6bxvaanewxzm2v@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqDt1ZlaEwZdFnBZdV7qZLH609DBb
        tM38weTA7LH85l8mj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4MqYvvwma0ELb8XN3uOMDYyt
        XF2MnBwSAiYSs++dZu1i5OIQErjMKHFk5Vw2COcMk8SyQ1PZQaqEBYIl9kz6yAZiiwjISnw/
        vJERougNo8TWk3+Bijg4mAW8JGYvSwGpYRPQlVjU08wEYvMK2Es0T97LCGKzCKhIbO05yAJi
        iwqESFyec5QNokZQ4uTMJ2BxTgEXibPrPzCD2MwC6hJ/5l2CsuUltr+dwzyBkX8WkpZZSMpm
        ISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkSHl3MP5fJ3OIUYCD
        UYmHtyMqK0KINbGsuDL3EKMkB5OSKO/TOqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV73GUA5
        3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEbz5Io2BRanpqRVpmTglC
        momDE2Q4D9BwV7DhxQWJucWZ6RD5U4yKUuK8q6YDJQRAEhmleXC9sCTyilEc6BVh3hMg7TzA
        BATX/QpoMBPQ4K9x6SCDSxIRUlINjMncWax9ZeW70r4+q+h6dKf1kIdnW9Eftuw1th/1l8lM
        c30tNsdOepeUBovw16VFTD1JF87Xlm2M/v6MTfmVWVvSpm2rl+uZ/zibckttAxv7p3sMt1nS
        6zLbkhI79zcfbHsi/29h4ZNu9itf97CIhcpYWt0u/lU7I9I6udhG1U6mfPKFk6YqSizFGYmG
        WsxFxYkAftBJTv0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02/2017 06:09 PM, Jeff King wrote:
> [...]
> But I think the thing that gives me the most pause is that the oid
> version of the function feels bolted-on. The nth_packed_object_sha1()
> function is there specifically to give access to the mmap'd pack-index
> data. And at least for now, that only stores sha1s, not any kind of
> struct. If and when it does learn about other hashes, I'm not sure if
> we're going to want a generic nth_packed_object_oid() function, or if
> the callers would need to handle the various cases specially.
> 
> Given that this patch only converts one caller, I'd be more inclined to
> just have the caller do its own hashcpy. Like:
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 1173071859..16345688b5 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3769,12 +3769,14 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
>  
>  	for (i = 0; i < p->num_objects; i++) {
>  		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
> +		struct object_id oid;
>  
>  		if (!sha1)
>  			return error("unable to get sha1 of object %u in %s",
>  				     i, p->pack_name);
>  
> -		r = cb(sha1, p, i, data);
> +		hashcpy(oid.hash, sha1);
> +		r = cb(&oid, p, i, data);
>  		if (r)
>  			break;
>  	}
> 
> That punts on the issue for all the other callers, but like I said, I'm
> not quite sure if, when, and how it would make sense to convert them to
> using a "struct oid".

Your change is not safe if any of the callback functions ("cb") tuck
away a copy of the pointer that they are passed, expecting it to contain
the same object id later.

Michael

