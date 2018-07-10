Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB8D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 09:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeGJJXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 05:23:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:48373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeGJJXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 05:23:19 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiTrM-1gDFc11Cl2-00cinp; Tue, 10
 Jul 2018 11:23:17 +0200
Date:   Tue, 10 Jul 2018 11:23:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] ref-filter: merge get_obj and get_object
In-Reply-To: <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
Message-ID: <nycvar.QRO.7.76.6.1807101115570.75@tvgsbejvaqbjf.bet>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com> <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HTCDM6rdHmFMbe77gH+EAMBecCFONl3XDz1axvJSmpYW3czIwBW
 +Oea0xCPek4RBpdCL1mvrxKJt+vkVQsZ87rWoF+jHYMaUnNlFWE9wNjFDzubgDHIpFISDio
 Vh+LajCwugjmzN433cIIt+EQjYExK6xTI9Q3wqGBkmr86yoKSvCIfOWRCyc7a/uumxlzSNh
 uYyXHZ/CNMSNkYlB5SNDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4SXmPJJeQkg=:Ok85s5rhKa4e/qzYYFN3z+
 mkWVhkXNr1yytzYOGiQVunv7s0CwCc/f/zpad/0rYm4T17mAMvss7PJq8opDwugg0CQLWWEWg
 MKBTRNJAiNjpp3sQvw8k/DMO1JmSOf50REiE66t1VVeS8p2qC4MjZEhluFOCg4oOY0m5u6NA1
 bA7jOI0Oo6XuEukuHUzuhiR4LTtkpkrBAXI3dMPDSq6pYjqheQAwQH2mDtXcpQ6pzo2K1xPe8
 Ah1869vtYwunxOFj146wT3tB06IGR8BRxZA1LPqKeFvL4tUFkpnAkGyU3bfvw4X4KWMT/usn4
 FWc24mPRwzTHExffIk6OxOP/CjNV0JpADFSncB+2iM7Fst0YhhbYePMCHqAP/gUi0zKGtJLX6
 hhCeC4BK5nzhEplb7B84qqomQQLK7XYxO0j9rIy2xKdBxMK7biB85PhbPmLL5B64cGp9gYobd
 wY0OHf9nzli8QHnhxa3E3zDz7joNpxwTE4kei9cg5WKXuWsQJCS5/E4q4TWjHx+BRyEX2BQ+n
 /FLnH0RJHSHJL6AckvPlZL+DN78z9L3qgQK7nGThbuN0eXxd1bTIeyItkTfIAZoyfRUeb3Yf/
 kkPEESedGxwuZBA4Zg3cp46Jtib6/p7qjUPabMj+dfXP/9BSV0al/blPRADHVGbfeFhLg6/cI
 DN1wGpvViei80/xTfJAIYKySzZBiVr31KEq96yYErI92dcFAO5fIpkLH+G8gIOGeA6wUWtbQ6
 2jmPNtBXOsGG9Khc6pudfMNRIbKj1aEVuvanv3DmqV3mYN6fu6Dmnt0DfZl6UQj4Dclun1sjc
 p6btFyf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olga,

On Mon, 9 Jul 2018, Olga Telezhnaya wrote:

> diff --git a/ref-filter.c b/ref-filter.c
> index 27733ef013bed..f04169f0ea0e3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1437,20 +1419,24 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>  }
>  
>  static int get_object(struct ref_array_item *ref, const struct object_id *oid,
> -		       int deref, struct object **obj, struct strbuf *err)
> +		      int deref, struct object **obj, struct strbuf *err)
>  {
>  	int eaten;
>  	int ret = 0;
>  	unsigned long size;
> -	void *buf = get_obj(oid, obj, &size, &eaten);

So previously, `eaten` has been assigned always... but...

> +	enum object_type type;
> +	void *buf = read_object_file(oid, &type, &size);
>  	if (!buf)
>  		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>  				      oid_to_hex(oid), ref->refname);
> -	else if (!*obj)
> -		ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> -				      oid_to_hex(oid), ref->refname);
> -	else
> -		grab_values(ref->value, deref, *obj, buf, size);
> +	else {
> +		*obj = parse_object_buffer(oid, type, size, buf, &eaten);

... now it only gets assigned in case `buf` was non-`NULL`... yet...

> +		if (!*obj)
> +			ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> +					      oid_to_hex(oid), ref->refname);
> +		else
> +			grab_values(ref->value, deref, *obj, buf, size);
> +	}
>  	if (!eaten)
>		free(buf);

... here, we still act on `eaten`. This causes GCC to complain thusly:


```
2018-07-10T04:59:38.6368270Z ref-filter.c:1477:6: error: variable 'eaten' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
2018-07-10T04:59:38.6468620Z         if (oi->info.contentp) {
2018-07-10T04:59:38.6568710Z             ^~~~~~~~~~~~~~~~~
2018-07-10T04:59:38.6669970Z ref-filter.c:1489:7: note: uninitialized use occurs here
2018-07-10T04:59:38.6774240Z         if (!eaten)
2018-07-10T04:59:38.6874860Z              ^~~~~
2018-07-10T04:59:38.6976740Z ref-filter.c:1477:2: note: remove the 'if' if its condition is always true
2018-07-10T04:59:38.7072330Z         if (oi->info.contentp) {
2018-07-10T04:59:38.7172760Z         ^~~~~~~~~~~~~~~~~~~~~~~
2018-07-10T04:59:38.7274040Z ref-filter.c:1466:11: note: initialize the variable 'eaten' to silence this warning
2018-07-10T04:59:38.7374670Z         int eaten;
2018-07-10T04:59:38.7474870Z                  ^
2018-07-10T04:59:38.7575690Z                   = 0
```

(See
https://mseng.visualstudio.com/VSOnline/_build/results?buildId=6640204&view=logs
for details)

I think that GCC is correct, and at the same time, it isn't. Because it
does not matter whether `eaten` is uninitialized here: if it is, then
`buf` is NULL, and the `free(buf);` call does nothing in particular.

However, it *is* sloppy to have a conditional block of code that acts on
an uninitialized value, whether it has adverse consequences or not. So I
would suggest to initialize `eaten` to `1` (not `0` as suggested by GCC
because we can avoid the no-op `free(buf)` while we're already touching
that code path).

Ciao,
Johannes

