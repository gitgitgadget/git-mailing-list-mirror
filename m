Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDDD1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeHBSnC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:43:02 -0400
Received: from mout.web.de ([212.227.15.4]:47763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeHBSnB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:43:01 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDgTO-1fjZRi0KnG-00H45T; Thu, 02
 Aug 2018 18:51:00 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e18e9ebb-a78c-150c-9e63-e9249eb2e96d@web.de>
Date:   Thu, 2 Aug 2018 18:50:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UjhI2Lc71aIphR+24Fcz6H/zJfDYMORtikltDopvjo0kNAhLoim
 OopDbDXWbcpKhHxPn4oMUfyPyXpaE6ZSgqwdaT2tntgxmvAJboc7wsOSLRB9kA+kRc2OD0J
 FAxVbXxxEljvTbxa37wCnfgjA3QfQtoRMK0+Z8PQpguz+/TdSMrYwnLzQE6rG4e/MYr3JcS
 GkKE1cdFTVSdSOQ/t4cTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hY7H9pZ/OwY=:DpdrhWF5gDI5mpXqvk0/+c
 iaRW3p2QoeSziOy1nS+OdurO83zocyQ1+5mZ+p6pP04NaoehjrBaA7POFeR/IQBNTZtlxpD9O
 JkWKN9ziZaekzMTKtJfYM919XD7+J0knsxqT927NLNsh/foke6aHtj2XfnzshSsen4zFb/61A
 O9ycsI8SlyJ5uGm7SDhdM6bC/++EQ+D47b4CDklIh1lIbmO6LIzy9O846nph/kiWpfqZiTdrg
 45YYbOA/oS38B81fAsnsfOpz+TYGWtLG5BKqoey6DU+SHOYpP81D9D2j9sKQpc9n984b/3S0I
 DHX4RZZodHwHzJjRYoi+2lOXmmGRr9LBh9IgzUF7BzwNR727cDywGujip9d1TIpDdKAyXwegQ
 uCVWaMjx/+kj+GCwlsP0JUb+BB+AgVinCDdUsQQzL08Lh0o+3tAbbLjCeIFlgcbLJdzdVZ39+
 ZK1accvz/f5y3LreatKo2f8GQ5qfD2PLHD1p7pt9CgiPJzhxQtRbLior65oBE8VeT9mSFldZl
 ZUlLyO88lSBQr5zaZXq/gNZQxao2UXEAjIyD0/iBQzuG9T1UNSV/tB0TS3ziMJPi2+xuKXxGT
 CiR/tX2uJZKjHuDFz0bV58Ra+vI8fx9eMp94ovvYZGlhbVE58Nfn379t8AjrJyKASyKrZfGDC
 gDnL+Zj7me+DMdrCdIj6PHtw0JEgW0kjXQdyvJll969oAAFUQNL0Ojh014IwyP8jJOeaZBpix
 Cm4y9KoQ224P/xcrNeCDt+JnkvDTZ/+5T9rCwQ9Tm7iKcV0ksaIGBYcA/hIwhI/ZmdWCo45R0
 hDgGQ9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 17:31 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>> diff --git a/parse-options.c b/parse-options.c
>> index 7db84227ab..fadfc6a833 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
>>   static int usage_argh(const struct option *opts, FILE *outfile)
>>   {
>>   	const char *s;
>> -	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
>> +	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh ||
>> +		(opts->argh[0] == '<' && strchr(opts->argh, '>'));
> 
> You are greedier than what I thought ;-) I would have limited this
> magic to the case where argh is surrounded by "<>", but you allow
> one closing ">" anywhere, which allows us to grab more complex cases.

That's what I had initially, but only one of the current cases would
have benefited from that strict behavior, so it's not useful enough.

> The lack of escape hatch to decline this auto-literal magic makes me
> somewhat nervous, but I do not offhand think of a reason why I do
> want an arg-help string that _begins_ with '<' to be enclosed by
> another set of "<>", so perhaps this is a good kind of magic.

The escape hatch is to add the extra pair manually to the argh string.

René
