Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796462098B
	for <e@80x24.org>; Mon, 17 Oct 2016 04:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbcJQEY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 00:24:59 -0400
Received: from mout.web.de ([212.227.17.11]:54129 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbcJQEY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 00:24:58 -0400
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Md4pC-1cE4I21YFW-00IApr; Mon, 17 Oct 2016 06:24:28
 +0200
Subject: Re: [RFC] Case insensitive Git attributes
To:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
 <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
Cc:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8df71a3a-64a6-2ec4-fd04-ae4f9bd4c2f5@web.de>
Date:   Mon, 17 Oct 2016 06:24:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:u8Nr0PfDmvpxCuaSqOsjj6BDG+i9WpRjmkWoBEbsB65zUJgAtbU
 /ynuwOmsL1iMFc9a9ApXm7kn0FQzuQVIplFqaZsNkdd1Vwp+Vpkt75VaHcM4CUiQ/UdmMb1
 wZ+Gxkhc8b7rGUNEBktDho4uZ5CXYpNoEINBdiVUuA+6Hb+MIak2eabVC4uKhDJkQD8lSbq
 5UVknyvI1bM5vTJ1QxFRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:57Rmos+VMiA=:HpV2zpGcH4c1W9jnTqe9sF
 PzMQFZ96bWqLeD2OKP05hn/XGYrP7rpwQiA3ilqAw4jV/uZMG0AWZR/DDMnEcqUJUXMiD+4FE
 G1Wy6qHYt0AA5rz9FNgnF7pjTPXaY70bo7DDCjP1vNRNRWWpwyqLHNSsN2/ECSDHOgCEmr1n3
 Jho+2vwJ4wEPpT1nX6XnLBZFf28cM/H6cmL0SWC0iG6tTmw8ALIImxEMJvI5TDHXNARLUYT3g
 NSHdm8vCsNsdioZUX5RToZlqGSoKFOEi8is7+vvFgaTnzjMZYwFs1jfL/m8kO+qMYPttjJ302
 sjIoR1E5kn4PF81dmVbSa9+JNx5ARFwg/axmbGzWjAF5jOC9IjCDHqE3NnXZXvI3kCQZNdZZr
 7CGbpPUWtmhQQZiZwH3yq2UpxA4oJWDq/AojLo5/aQ2h3WjVSKva4GwEEC0yvnILS893rUlpf
 lDpcFsi+5gpGH/28UPCAuCXW5w/AP8GDoqbwx5PREUCDn9zFbmznWQ/+18GXoKkOAUR3WcuxK
 uIKKWS0PDDeX1szboA3x328Gl6JXHlEMRr7oARx9xKYHDpV/Co7dh6HDhJduA72iRZvnBhR08
 CemZA4j7812+2yyePB+poVZzac05P6WoXukgUfP+PUmVexbMkw9YRhJT3L5ClCJmZD8TyWlvw
 skDisL88ZJIEc1aXjzMoHDsymwRold2BBy9M/H8oc0xmDgOxe9iQzc6wluVK7Nd20SrIIroqG
 Smk2/21wP9g+HM8cjyk7MEI2eDayXfG+NwW8e1+avFHV+00iWMQGWtuHG+2MZ3L3iDZG+6g80
 2WmQYGZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/10/16 05:07, Stefan Beller wrote:
> On Sun, Oct 16, 2016 at 6:04 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>
>> Git attributes for path names are generally case sensitive. However, on
>> a case insensitive file system (e.g. macOS/Windows) they appear to be
>> case insensitive (`*.bar` would match `foo.bar` and `foo.BAR`).
This feels like a bug:

$ git diff
diff --git a/.gitattributes b/.gitattributes
index 5e98806..1419867 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,4 @@
  * whitespace=!indent,trail,space
  *.[ch] whitespace=indent,trail,space
  *.sh whitespace=indent,trail,space
+*.C text

-----------
$ git -c core.ignorecase=false check-attr --all git.c
git.c: whitespace: indent,trail,space

#But running on a case insensitve FS I get:
$ git  check-attr --all git.c
git.c: text: set
git.c: whitespace: indent,trail,space


>> That
>> works great until a Git users joins the party with a case sensitive file
>> system. For this Git user only files that match the exact case of the
>> attribute pattern get the attributes (only `foo.bar`).
>>
>> This inconsistent behavior can confuse Git users. An advanced Git user
>> could use a glob pattern (e.g. `*.[bB][aA][rR]) to match files in a
>> case insensitive way. However, this can get confusing quickly, too.
>>
>> I wonder if we can do something about this. One idea could be to add an
>> attribute "case-sensitive" (or "caseSensitive") and set it to false
>> (if desired) for all files in .gitattributes for a given repo.
> FYI: I am currently refactoring the attr subsystem (e.g.
> https://public-inbox.org/git/20161012224109.23410-1-sbeller@google.com/
> "attr: convert to new threadsafe API")
>
>> ### .gitattributes example ###
>>
>> * case-sensitive=false
How about
* ignorecase=true
  ?

> Would this modify the current file only or the whole stack of attrs?
> (In just one way or the whole stack, i.e. can you add this in .git/info/exclude
> and the attribute file in the home dir also behaves differently? Or rather the
> other way round when the system wide attr file enables case insensitivity,
> each repository local config is set automatically? both ways?)
>
>> *.bar something
>>
>> ###
>>
>> I haven't looked into the feasibility of an implementation, yet. However,
>> would that be an acceptable approach?
> Conceptually I would prefer if we had a single switch that indicates a
> case insensitive FS. That could be used for different purposes as well,
> that are FS relevant such as checking in, checking out/renaming files
> in the working tree? (does any such switch already exist for case
> sensitivity?)
>
> Thanks,
> Stefan
>
>> Thanks,
>> Lars
>>
>>
>>

