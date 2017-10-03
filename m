Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDDA202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdJCQ0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 12:26:32 -0400
Received: from mout.web.de ([212.227.15.3]:63528 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdJCQ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 12:26:30 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lbrk4-1dZxA03XLY-00jHEh; Tue, 03
 Oct 2017 18:26:28 +0200
Subject: Re: Line ending normalization doesn't work as expected
To:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
Date:   Tue, 3 Oct 2017 18:26:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tpSGBKYdWB7f/fOF4KpsSProPHAMUI9U4YKY86bsBM4IurHy1WZ
 UxXFWZp6kVp074YyDEEwo1WHdkIzapSX2jyPX+7IZE6/vtMLieQAlyJH2JJ8Z8UlaCKDuKY
 BZQJTELwTmbEHL9f1hf6Y2j+oXe5kxhtIOWGSUnNyExaSiSdt0bGaaRs5YDyTFe6y89K7iu
 ptXTphrueTaT4O+f6JsNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hKukepipN+g=:55zffz7VwGym+y3DHnPQmr
 zBuMWiGjcMqn+v2wdLb2H3LnrspO5/om5bvcjio5nh/EWRS9hVOikB+FZJ2FAF9+15vbPk82t
 FQtxqjI5HDgNzG7EtlaKeAOvJN2gT4DVVIN7R8/9o+C/9Us3amsZSzNmFNQpIG6zgBY4GGfnG
 RpeFkJ/q2/juJojclZqFZ2+wSQblCGMCUqeyffEEJopdyfbtqjE1Wotwfey2W9P3erf0Ry47L
 qBd+ULJ7oQYjrvAHTznRftXwGjOSZYLaREWqS8JQm3KRVc+ZTWJgrwqZvc+3VdhlrboTKKoTu
 UtlHnVUemaMRjm0cytuKsJwlTFk9+AJI1F79gcoJtvw726bt+WvGgKlcMvci61Jonik4rBEgN
 B3fyv/TCR8vyNjuS9ADDSXUTTMl0x+GUtHmzjAEgkmX9rbnM9WR/4P6RWto+w7Rf/CuzW4XA8
 TRWkOtxlWYPhbVNCUkTAO+60xH7TUHQ3om7zaR1G+ctKEeNPO++HV0ceP1z8pjX9swzE4A9ae
 vGSIb0pVtnDc1FifmOn1eMKD68omTlwCH4wOTPVeNzpDoMNjMa45z8xtJdfMRGFYbXqpPIVOi
 rpZckTySl3rG4zSDz3vkYP3Fh5EKXSJMQRFcA/rA7T2K4V1PNIUXjixZogULiMYOgpbKwIJsr
 dVCZ9c82xECmXo2//4Ow1bLYiOunk4N4zKW4ii374CsFufXrfSFaTLsrKuZSMlJWNUq+tqnkO
 QS6BQ90Qgx5qNQSLwUfrZXY47qDbIoAZHdpk8zOdF2edyR23ogjT2HNTSDlBVVk83UhY3SKjF
 r4Sf90YtRQAMFJ2qku+OSuismTE/YQCWgdJyU5iSGljSt81Y6U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-03 17:00, Robert Dailey wrote:
> I'm on Windows using Git for Windows v2.13.1. Following github's
> recommended process for fixing line endings after adding a
> `.gitattributes` file[1], I run the following:
> 
> $ rm .git/index && git reset
> 
> Once I run `git status`, I see that no files have changed. Note that I
> know for a fact in my repository, files were committed using CRLF line
> endings (the files in question are C# code files, and no
> .gitattributes was present at the time).
> 
> I also tried this:
> 
> $ git rm -r --cached . && git reset --hard
> 
> However, again `git status` shows no working copy modifications. The
> one thing that *did* work (and I tried this on accident actually) is:
> 
> $ git rm -r --cached . && git add .
> 
> This properly showed all files in my index with line ending
> modifications (I ran `git diff --cached -R` to be sure; the output
> shows `^M` at the end of each line in the diff in this case). Note
> that my global git config has `core.autocrlf` set to `false`, but I
> also tried the top 2 commands above with it set to `true` but it made
> no difference.
> 
> So my question is: Why do the top 2 commands not work, but the third
> one does? To me this all feels like magic / nondeterministic, so I'm
> hoping someone here knows what is going on and can explain the logic
> of it. Also if this is a git config issue, I'm not sure what it could
> be. Note my `.gitattributes` just has this in it:

The short version is, that the instructions on Github are outdated.
This is the official procedure (since 2016, Git v2.12 or so)
But it should work even with older version of Git.

$ echo "* text=auto" >.gitattributes
$ git read-tree --empty   # Clean index, force re-scan of working directory
$ git add .
$ git status        # Show files that will be normalized
$ git commit -m "Introduce end-of-line normalization"


Could you open an issue on Github ?
(Or can someone @github fix this ?)

> 
> * text=auto
> 
> Thanks in advance.
> 
> 
> [1]: https://help.github.com/articles/dealing-with-line-endings/
> 

