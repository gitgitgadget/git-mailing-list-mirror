Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920611FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbcHJSFs (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:05:48 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36450 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcHJSFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:47 -0400
Received: by mail-io0-f169.google.com with SMTP id b62so49000750iod.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:05:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HRETcZyDtwFmhzyM+CBqg7ah6rnY6QtwqMSFoYb15TE=;
        b=ignqoUr1aMRbyxikyswP5ld4s0DjMFu4eNgCTDXxvqxGZ69fRmQGv9UuGGgzZeoE49
         knBcafr6POYKoUr8texRhd8nHXDBAFDspf3E4COBDismDOnvfK/k6RBFnLQxSNQJrXe4
         9KRD6o+FFO6ImiMvkJWcDoWSNF772ApMb7BHnMl28+spm91mDm2W92F8NTWzftd1Lw3A
         IPaxmvsybJAX6sZDBhbrkE73U63G0puKEGWjHItTuU/tTbhADmY8xeFow4Yrv+ctHSL/
         vV2QpbMEbAjWwEbigEZAcXPyd3Y7VoNKz9AFcxIHTE1YTeLLmZJr8Nbx7eO7auP3Ji1E
         FO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HRETcZyDtwFmhzyM+CBqg7ah6rnY6QtwqMSFoYb15TE=;
        b=LqFZo8s5i1aBXygNN4b0yU9ErO6gVtCXoXdaFzQbcDXkgk/A54V5zM2i1w12CV+Rag
         v52vVgZb1zh5SqEHhqLPR8r2ykGgnm4Y58lPHPetAnSDiGhAA2ITDVYNcf1sJjLDd+ja
         qXiLvAvJBQLCGlUUXfBlBxwvFTZLj2/Epjvq+tfeoVNotdRH6KXo9fG2wwzFCQhpm2ID
         HvqRk/FFuX+fZ6pgdtf3gsK7oPuHNTa1vpxObW3ozDrXaN56ILVxudghIvMt2a0YSfiv
         GNCN79mYI5aJd8sZd2MfzSQFebpV/FrwW5+dnEMUKYOvtTI4VjPLQ7LI/Iy/4SBqy3b/
         lPsw==
X-Gm-Message-State: AEkooutC8WTo+sGwk0DvrMWeINMgJtogSwUzmKaHvGFQ/2o3YHkq8N8nwhDn5a0Gu5bo/jo7lR8OK7vL7taJTdx4
X-Received: by 10.107.131.38 with SMTP id f38mr6891314iod.173.1470850615694;
 Wed, 10 Aug 2016 10:36:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 10 Aug 2016 10:36:55 -0700 (PDT)
In-Reply-To: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com> <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 10 Aug 2016 10:36:55 -0700
Message-ID: <CAGZ79kai3V=pVMOsas6P9wSCyF=BXwVf2Piuci9CNt5BN=K7Wg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 10:30 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>>
>> * sb/submodule-update-dot-branch (2016-08-03) 7 commits
>>  (merged to 'next' on 2016-08-04 at 47bff41)
>> + submodule update: allow '.' for branch value
>> + submodule--helper: add remote-branch helper
>> + submodule-config: keep configured branch around
>> + submodule--helper: fix usage string for relative-path
>> + submodule update: narrow scope of local variable
>> + submodule update: respect depth in subsequent fetches
>> + t7406: future proof tests with hard coded depth
>>
>> A few updates to "git submodule update".
>>
>> Will merge to 'master'.
>
> I think "t7406: future proof tests with hard coded depth"
> breaks the tests on OSX:
>
> https://travis-ci.org/git/git/jobs/150779244
>
> Cheers,
> Lars
>


error: pathspec '4' did not match any file(s) known to git.

not ok 46 - submodule update clone shallow submodule

#
# test_when_finished "rm -rf super3" &&
# first=$(git -C cloned submodule status submodule |cut -c2-41) &&
# second=$(git -C submodule rev-parse HEAD) &&
# commit_count=$(git -C submodule rev-list $first^..$second | wc -l) &&
# git clone cloned super3 &&
# pwd=$(pwd) &&
# (
# cd super3 &&
# sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
# mv -f .gitmodules.tmp .gitmodules &&
# git submodule update --init --depth=$commit_count &&
# test 1 = $(git -C submodule log --oneline | wc -l)
# )
#


Is it possible that the "wc -l" produces  SP <NUMBER> on OSX,
such that the

# git submodule update --init --depth=$commit_count

contains "--depth= 4" which means empty depth and 4 as the pathspec
for the update command?
