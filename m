Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5468120193
	for <e@80x24.org>; Wed,  2 Nov 2016 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932488AbcKBVpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 17:45:08 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58014 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754510AbcKBVpH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2016 17:45:07 -0400
X-AuditID: 12074413-9a9ff70000000a14-15-581a5e5c3b71
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.00.02580.C5E5A185; Wed,  2 Nov 2016 17:45:02 -0400 (EDT)
Received: from [192.168.69.190] (p579066FE.dip0.t-ipconnect.de [87.144.102.254])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uA2LiwTi012821
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 2 Nov 2016 17:44:59 -0400
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
 <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
 <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
 <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
 <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8dbbd28b-af60-5e66-ae27-d7cddca233dc@alum.mit.edu>
Date:   Wed, 2 Nov 2016 22:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqBsXJxVh8OakkEXXlW4mi4beK8wW
        uxf3M1v8aOlhtti8uZ3FgdVj56y77B4LNpV6POvdw+hx8ZKyx+dNcgGsUVw2Kak5mWWpRfp2
        CVwZ25oPsRYsF6l42dnP1sC4TqCLkZNDQsBE4tuixaxdjFwcQgKXGSXOPdjNCOGcZ5JYfGo6
        I0iVsIC6xLHeTcwgtoiAo8SJB9ehOg4ySWzbdIAFJMEskCtxofkMO4jNJqArsainmQnE5hWw
        lzh64jdYDYuAisSa93vABokKhEh8e9POBlEjKHFy5hOwGk4Ba4mpmy8zQszUk9hx/RcrhC0v
        sf3tHOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSml
        mxghoSy8g3HXSblDjAIcjEo8vBk/JCOEWBPLiitzDzFKcjApifJ+fgoU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMJbHysVIcSbklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQ
        kuBdC9IoWJSanlqRlplTgpBm4uAEGc4DNPwi2PDigsTc4sx0iPwpRkUpcd6aGKCEAEgiozQP
        rheWal4xigO9Isz7EaSKB5im4LpfAQ1mAhpsniQBMrgkESEl1cA44e8naf//u1pSr76zbVfM
        DpWJU/jQp/+0Ym/+7+vlZ846V/v7ndz/bIvfJD/+RV2+Hsy9CVdVDbMW/Jvz8GzCbt97vUzi
        J3d6XspWzY6xCZll9XeN48qDEyY0Klz7U/L+GveD48HCoV8EO9eIOl47OOPSmQecTJHawVNa
        s33UfAr9dkm1bFJQYinOSDTUYi4qTgQAwGVsjxADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01/2016 10:38 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If it involves renaming and swapping, however, we may be talking
>> about a change that we cannot deliver with confidence in less than a
>> week before -rc1, which sounds, eh, suboptimal.
>>
>> FWIW, here is how the removal of compaction without renaming looks
>> like.
> 
> And here is _with_ renaming.  I think "compaction heuristics" is a
> much better phrase to call "heuristics used during the diff hunk
> compaction process" without specifying how that heuristics work
> (like taking hints in the indentation levels).  If we are to retire
> one while keeping the other, compaction-heuristics should be the
> name we give and keep for the surviving one.

Personally, I'm not a fan of the name "compaction heuristics".

The name *seems* to make sense because it affects the behavior of a
function called `xdl_change_compact()`. But that means nothing to end
users. The option doesn't affect how the diff is "compacted" in the
usual sense of the word; the slider optimization usually doesn't change
the number of lines in the diff at all [1].

Moreover, if we ever want to add another heuristic (for example, imagine
a language-aware algorithm that is based on parsing the file), we would
want a different name for that option, at least temporarily. From that
point of view, it makes a little bit of sense for the name of the option
to hint at the particular heuristic being used.

That being said, I don't think it is a big deal either way, and I can
live with either name. I rather hope that this option will become the
default soon, and hopefully after that hardly anybody will need to learn
its name.

Regarding making it the default: given that it is presumably too late in
this release cycle to make this option the default behavior, I suggest
that it be made the default early in the next release cycle so that it
gets a lot of testing, and people have enough time to voice any objections.

Regarding your patches themselves, once the old compaction heuristic is
removed (with or without renaming), you can also get rid of the
`blank_lines` local variable in `xdl_change_compact()`, and also the
function `is_blank_line()` in the same source file.

Michael

[1] The only exceptions are when it causes context lines for adjacent
diff hunks to join/split, or makes the context lines for a diff hunk
extend past the beginning/end of the file. But these are uninteresting
side-effects; it doesn't *try* to do or avoid either of these things.

