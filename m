Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876281FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 17:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935503AbcKQRK2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 12:10:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933967AbcKQRK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 12:10:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BC9B4FF7D;
        Thu, 17 Nov 2016 12:10:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vH6zRcdCMK1U5J4yWW5p2m+7G7w=; b=J2CYwZ
        YrwMLK/lxAC8ELRvRJnCD5h5e9XxmMjPQOVZkajmdruMl0sIDEQqJsDBkpkUgoXH
        LtrEZ0VKGG6WODh0Zhs70FTsBhiLTusBj7/SnKG6ddN0kNNkBxrooKgnZoBzyiL7
        0nEl6Xjk7B4clEZoJH87R2GiIHx+xjK4spRsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHvAFJxC4uTrUmZe9c9bxT2I3ARJMFK+
        m5Rnthj+iYbHZ1B6aJwT8N1HkAzQdvMm0AQqIHPnj/yiRCyqwv4wG+wVLEVq1LJh
        H2TmVDshBouct89hK6fIywdCkv+TzfQbqsQgOfdF0UjQRVcmYtXrqcMdT3907/Es
        XDI2izN7388=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2354A4FF7C;
        Thu, 17 Nov 2016 12:10:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FF5E4FF7B;
        Thu, 17 Nov 2016 12:10:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     "Vanderhoof\, Tzadik" <tzadik.vanderhoof@optum360.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: merge --no-ff is NOT mentioned in help
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
        <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
        <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
        <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
Date:   Thu, 17 Nov 2016 09:10:22 -0800
In-Reply-To: <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
        (Mike Rappazzo's message of "Wed, 16 Nov 2016 10:57:52 -0500")
Message-ID: <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA10A382-ACE8-11E6-AD92-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Rappazzo <rappazzo@gmail.com> writes:

> (Please reply inline)

Indeed ;-)

> On Wed, Nov 16, 2016 at 10:48 AM, Vanderhoof, Tzadik
> <tzadik.vanderhoof@optum360.com> wrote:
>> I am running:    git version 2.10.1.windows.1
>>
>> I typed: git merge -h
>>
>> and got:
>>
>> usage: git merge [<options>] [<commit>...]
>>    or: git merge [<options>] <msg> HEAD <commit>
>>    or: git merge --abort
>>
>>     -n                    do not show a diffstat at the end of the merge
>>...
>>     --overwrite-ignore    update ignored files (default)
>>
>> Notice there is NO mention of the "--no-ff" option
>
> I understand.  On my system I can reproduce this by providing a bad
> argument to `git merge`.  This is the output from the arg setup.  For
> "boolean" arguments (like '--ff'), there is an automatic counter
> argument with "no-" in there ('--no-ff') to disable the option.  Maybe
> it would make sense to word the output to include both.

I think that was a deliberate design decision to avoid cluttering
the short help text with mention of both --option and --no-option.

People interested may want to try the attached single-liner patch to
see how the output from _ALL_ commands that use parse-options API
looks when given "-h".  It could be that the result may not be too
bad.

I suspect that we may discover that some options that should be
marked with NONEG are not marked along the way, which need to be
fixed.


 parse-options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 312a85dbde..348be6b240 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -626,7 +626,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (opts->long_name && opts->short_name)
 			pos += fprintf(outfile, ", ");
 		if (opts->long_name)
-			pos += fprintf(outfile, "--%s", opts->long_name);
+			pos += fprintf(outfile, "--%s%s", 
+				       (opts->flags & PARSE_OPT_NONEG) ? "" : "[no-]",
+				       opts->long_name);
 		if (opts->type == OPTION_NUMBER)
 			pos += utf8_fprintf(outfile, _("-NUM"));
 


