Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA011FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932954AbcKQTSo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:18:44 -0500
Received: from mout.web.de ([212.227.15.3]:59575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbcKQTSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:18:43 -0500
Received: from [192.168.209.58] ([195.252.60.88]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M22Sh-1cvzOI19Rb-00u3Mm; Thu, 17
 Nov 2016 20:18:29 +0100
Subject: Re: merge --no-ff is NOT mentioned in help
To:     Junio C Hamano <gitster@pobox.com>,
        Mike Rappazzo <rappazzo@gmail.com>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
 <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
 <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
 <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
 <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
Cc:     "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <cff54a0c-65bb-047e-b77d-916e300b66d4@web.de>
Date:   Thu, 17 Nov 2016 20:18:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zvGGoEbue7/vM6//fAUIcwcsShGXBz8TVKnkX5GHHmPXux/KkId
 Ij/vJljkFqyjhxauD0GSK47Z6mp8ow2E6Fk4JtscGHaC4/+JGKv9YXjqMGvlAnzqn1kRKc5
 3Ng+zHdVbDO87Bp+84sS0bFQ30noVBlaVl79bFMv7k/QUNH2WKDJtUJySdSsmwjW4YJNJKV
 bEstO7KEc1OIl/Yt/ChVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lf2/oOlfpU0=:l4ZdblSFBu2Lv8DeAeOXmp
 VwvGoT9iqq22pGaDQp8aWniiPCNMuaqxrtbHKn0gZELaIF05xIuFDydKVVVIzPX7Oz2HKxpHh
 lb4j7txmSY3odaVhB7BnCO5elmge/ehMuG5rqO8/fVqvAWjORmpb2FUxoXfPvJSx7WTJNzrWA
 NAjAr7XUxKh0uQfQjUymvKXRiA+Xgqu5cV0HqvM3CQTCEQtDfIXwAlIIcc1fY9P3ifwjXAkkb
 ZksobpQOEBg08wX4nVt2w4ClvBzCORh8S+1C7w2o93PimVsJZ5cefJHDKgPVmSDd8BYUGc9O6
 zApAtJLcC7nKf2+Qe0y1W3uzwIWluyZdKAIsgUIizhGxtmtlGBvMjmWBxjeX4LJckhQxiPSNz
 0nzikqD/H4d2ptgHPE64OEVbNysnTyfJuCvoPc7Zdgzfr5ew9i6JKDdNZjyXfeliRf0m2OYV8
 peY8cmDG97DxAbr28TMmm47/pQRRMpAmC8pQEdA7dTAxnuPOamJlaeKzmVOY/4uOYK98kbtTC
 fSNFjqZkpldAuYbRSX2GtlWUteSqOI+HvJdkKwTEP2V6S9pFg1zuKNniesdggOMtpPIbF7olC
 DIIOOMx1m0Zs6rUG8RxAsFksqSaP36h4FxRfT8ZLum1iyeFUlluqJbZCqoAQMCs6EINkM/Ebx
 Cu6EKSdf4PfhsWOPVuZsGY3hbSQiAy+3b+l3WRYi4++mlPbDcNPrcTmrBShU79blwX47/OQ/X
 fUwpax/Bd1Jt+39Q7yFtSsa61A5ZJU4HgIyNdRC8DBIcagAzVLdyK9Il2UryVGuZ0kPJ52LOt
 3N2viKZwqsKabUEI2mdS5gedXY6m4AORvWlHvFG4oLHajwX1qBZVTsYcHxjjDhxZQZuc9WhgO
 IX2ga0mx2YIFdznnSnzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/11/16 18:10, Junio C Hamano wrote:
> Mike Rappazzo <rappazzo@gmail.com> writes:
>
>> (Please reply inline)
> Indeed ;-)
>
>> On Wed, Nov 16, 2016 at 10:48 AM, Vanderhoof, Tzadik
>> <tzadik.vanderhoof@optum360.com> wrote:
>>> I am running:    git version 2.10.1.windows.1
>>>
>>> I typed: git merge -h
>>>
>>> and got:
>>>
>>> usage: git merge [<options>] [<commit>...]
>>>     or: git merge [<options>] <msg> HEAD <commit>
>>>     or: git merge --abort
>>>
>>>      -n                    do not show a diffstat at the end of the merge
>>> ...
>>>      --overwrite-ignore    update ignored files (default)
>>>
>>> Notice there is NO mention of the "--no-ff" option
>> I understand.  On my system I can reproduce this by providing a bad
>> argument to `git merge`.  This is the output from the arg setup.  For
>> "boolean" arguments (like '--ff'), there is an automatic counter
>> argument with "no-" in there ('--no-ff') to disable the option.  Maybe
>> it would make sense to word the output to include both.
> I think that was a deliberate design decision to avoid cluttering
> the short help text with mention of both --option and --no-option.
>
> People interested may want to try the attached single-liner patch to
> see how the output from _ALL_ commands that use parse-options API
> looks when given "-h".  It could be that the result may not be too
> bad.
>
> I suspect that we may discover that some options that should be
> marked with NONEG are not marked along the way, which need to be
> fixed.
>
>
>   parse-options.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 312a85dbde..348be6b240 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -626,7 +626,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
>   		if (opts->long_name && opts->short_name)
>   			pos += fprintf(outfile, ", ");
>   		if (opts->long_name)
> -			pos += fprintf(outfile, "--%s", opts->long_name);
> +			pos += fprintf(outfile, "--%s%s",
> +				       (opts->flags & PARSE_OPT_NONEG) ? "" : "[no-]",
> +				       opts->long_name);
>   		if (opts->type == OPTION_NUMBER)
>   			pos += utf8_fprintf(outfile, _("-NUM"));
>   
+1 from my side
(As I once spend some time to find out that the "no--" is automatically available)

