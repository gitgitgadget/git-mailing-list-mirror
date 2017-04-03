Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6DB20966
	for <e@80x24.org>; Mon,  3 Apr 2017 04:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdDCEV3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 00:21:29 -0400
Received: from mout.web.de ([212.227.15.4]:55541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdDCEV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 00:21:28 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McWno-1cdE5C0EbI-00HcA0; Mon, 03
 Apr 2017 06:21:22 +0200
Subject: Re: [PATCH v2 1/8] ref-filter: avoid using `unsigned long` for
 catch-all data type
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <cover.1491159939.git.johannes.schindelin@gmx.de>
 <bf91c11bd145a2f4b049ac02c02a18e58c496834.1491159939.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <342cae56-ef58-3542-202d-6dd04d5777e8@web.de>
Date:   Mon, 3 Apr 2017 06:22:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <bf91c11bd145a2f4b049ac02c02a18e58c496834.1491159939.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:S5es0NpjjRBF8QRfi6iHFUMfXVG982IASisE5iMj5jDrYq9rq+y
 DUHvarGW1lCXdt2FGSqhTaNzEvepYeTDM7pPwR9lPkuq1WKCZ4PrTmpXwIYy/HTX0Xn8+TX
 /lUlK5wqJgEBkiVdV8cGcVGjgipBpc6Xcbbi8MNB6SvWwmZjI4uHbwoiaKi/PYTtXB454MZ
 v3IiVXDbNAgyT7l3dz/bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QxJjcUiow9o=:K0lNsca/phFkyZlk0I/Q22
 xY5/cz7TNOfgnlAY6EsUibyQq10SwPjl9V2tn2yL3Ynp2c5/Fz2lEB36mu0epWajOEvN2D52U
 2DpEAW+3rZ4dfTCfhLFeAQanr4hnaM4pm+VUPY9th40A5pI5w/qzWkzAEJcvqjpdAAjBkYfZG
 7+jzlmczZedSAJuAlUlUbIcu57CCnwEQqVw1BUVm4h+/x3aqTnlqCiRVtBgAqDKy0hlWEfpf+
 VqQNnMus3/smMbqHoifha1BPQPUOT1jHT9d6jnpc4w3I//QP6mh7X8N5fMlhoIGkCWDH8uKg4
 c5KNK1TPsnVSViY6xbvNlCW6xqGFynhkxj1VBMWmoQylwtUwD0orYwbUdurrjr7unjCu92f4A
 gtzecEfhXy+YKVaJaH3WJRE+IVtFwORmQJxNH95UxZj3VFqhskryh3ix+hqwS5VPhof13KbHn
 E+tfM5muEZfAFBjdPYcGpYcyABScbTVAO6MdG7NmnbDKIYYLTVO8wgXdLFJfl1r/5o1CR0ePn
 KnIGC5G7/UzT8J0pMF32gGYRzfByGmp+io5GkyCRap5nC0s7JYmAhs4hladY3sDBGnF7VhDzu
 /05fE1absYoab5hSX6UWkE6etW5nbghfuIoOI9UaIkfx3e8pIo68LdUrzVvvaW5XuU6V77hUB
 eGpKc/9Ku4zqEGgirZ2pOAW8/2z+QwGZudl6VXrQGgwWa8vn8+TV2yeZlCug/Wt2+6rIIHBVz
 4NT4hhKKHKCh+ysBzhoVA5stuaeb0jMO9rABEHsyvMkHifPYQW8nrji5gvj7E+8v+bp9nidUV
 ZNCRa/C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/04/17 21:06, Johannes Schindelin wrote:
> In its `atom_value` struct, the ref-filter source code wants to store
> different values in a field called `ul` (for `unsigned long`), e.g.
> timestamps.
>
> However, as we are about to switch the data type of timestamps away from
> `unsigned long` (because it may be 32-bit even when `time_t` is 64-bit),
> that data type is not large enough.
>
> Simply change that field to use `uintmax_t` instead.
>
> This patch is a bit larger than the mere change of the data type
> because the field's name was tied to its data type, which has been fixed
> at the same time.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ref-filter.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 9c82b5b9d63..8538328fc7f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -351,7 +351,7 @@ struct ref_formatting_state {
>  struct atom_value {
>  	const char *s;
>  	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
> -	unsigned long ul; /* used for sorting when not FIELD_STR */
> +	uintmax_t value; /* used for sorting when not FIELD_STR */
>  	struct used_atom *atom;
>  };
>
> @@ -723,7 +723,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>  		if (!strcmp(name, "objecttype"))
>  			v->s = typename(obj->type);
>  		else if (!strcmp(name, "objectsize")) {
> -			v->ul = sz;
> +			v->value = sz;
>  			v->s = xstrfmt("%lu", sz);
>  		}
>  		else if (deref)
> @@ -770,8 +770,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
>  			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
>  		}
>  		else if (!strcmp(name, "numparent")) {
> -			v->ul = commit_list_count(commit->parents);
> -			v->s = xstrfmt("%lu", v->ul);
> +			v->value = commit_list_count(commit->parents);
> +			v->s = xstrfmt("%lu", (unsigned long)v->value);

If we want to get rid of "%lu" at some day, we can do like this:
v->s = xstrfmt("%" PRIuMAX, v->value);
Or, to make clear that under all circumstances an unsigned long is big enough to
hold the counter, for readers in the future, use something like this:
			v->s = xstrfmt("%lu", (xulong_t)v->value);

(this is more a reminder to myself, to send such a patch )
