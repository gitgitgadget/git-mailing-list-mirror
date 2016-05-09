From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 18:35:49 +0200
Message-ID: <CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:35:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azo9z-0002vM-3P
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbcEIQfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:35:51 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33938 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbcEIQfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:35:50 -0400
Received: by mail-yw0-f195.google.com with SMTP id i22so23705413ywc.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qkqL+l0JvSYM9Pq0KucFNmZ6Uu6uoLZhcIb5xi9IPf4=;
        b=LTlrc+heV8t7Q9wd/3uMKU9mMEHl99gCzYO3UaLDFKDK7s5D32o2b1p2y2f6zUCU7u
         4Ivwz8pMAvYVDHGPLYeKD1eYrVUNbOudiPKMQzM+cNNPBlbkdJ89jAeEGYqLyKelLgQP
         38qO6FzmqTRZHRWqcDYqbSufHFS0t1fSNqHMx/ea4CQGlovIyZWM0HNUJukMcei7hA6s
         Vph1Ij74wMZTmH3RzeMXMGnxgD8XM8DXRvrPPVrFjb5ZhZxsfXMmxvUQULl70f7AEeYt
         5dvcQkh+ZgQvODRgwhvm/l684JyTtohlXyYgsXgRaNUjTTDnmGhyV40BGoM1gtouJeFQ
         D5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qkqL+l0JvSYM9Pq0KucFNmZ6Uu6uoLZhcIb5xi9IPf4=;
        b=ZjlY8jD8nfBpZ5vKrPMSfj7iL/FM4Oc8pDlen2V5kX3mgeMC4XmhbJWL044xkmJXLc
         SzgUmettAsG8kuGqsL8g7e+NTBqLg+95krXwjKqEIXa7oIAmjS0CB8wZNjzcMp+RfSs7
         2cTRVpRBwYEbF9HnTtPXlYvFxZhOQajtiXOCKaxuhdgAJt+lgTEC7UXhrTKuqq8uTZch
         67YTRZBXfIJ8z7iiKoZc/2/IiF9VRG2RcVu706Q3pTkMgBYbXhYVbJ1p44C7Op0/8JPa
         IQgvgIvLgkDO5HEFdn+oDQfJkhkV+HqUE0/H2vv/VHICjxMyGHRSMUyVvcM5qvzGw1kI
         ZZ7w==
X-Gm-Message-State: AOPr4FXjbR89ORDXtegwWonOZF5HhHSo+gBrEBY5DfGNA6rELnhu57M/jtAPb518ZupmcMUXAdi4DP+iPL7qmA==
X-Received: by 10.129.124.8 with SMTP id x8mr19750955ywc.200.1462811749290;
 Mon, 09 May 2016 09:35:49 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 09:35:49 -0700 (PDT)
In-Reply-To: <CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294013>

Sorry, this was my first patch to the list. I'll do better :-)
You are right about the "wc -l" parts. Maybe I was a bit over
pessimistic. Throw away my last mail.
In my case test 9 ran unsuccessful because of an empty "git ls-files -u"

This reduces the diff to this one (hopefully the right way now):
*** ./t4151-am-abort.sh.orig    Fri Apr 29 23:37:00 2016
--- ./t4151-am-abort.sh Mon May  9 18:28:18 2016
***************
*** 82,88 ****
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test_cmp_rev initial HEAD &&
!       test -z $(git ls-files -u) &&
        test_path_is_missing otherfile-4
  '

--- 82,88 ----
        test 4 = "$(cat otherfile-4)" &&
        git am --abort &&
        test_cmp_rev initial HEAD &&
!       test -z "$(git ls-files -u)" &&
        test_path_is_missing otherfile-4
  '

All the other similar occurrences are correctly quoted.

On Mon, May 9, 2016 at 6:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 9, 2016 at 12:09 PM, Armin Kunaschik
> <megabreit@googlemail.com> wrote:
>> skipping through some failed tests I found more (smaller) problems
>> inside the test... when test arguments are empty they need to be
>> quoted (quite a lot test in this sentence).
>>
>> Error is like
>> t4151-am-abort.sh[5]: test: argument expected
>>
>> My patch:
>>
>> *** t4151-am-abort.sh   Mon May  9 17:51:44 2016
>> --- t4151-am-abort.sh.orig      Fri Apr 29 23:37:00 2016
>> ***************
>> *** 67,73 ****
>>   test_expect_success 'am -3 --skip removes otherfile-4' '
>>         git reset --hard initial &&
>>         test_must_fail git am -3 0003-*.patch &&
>> !       test 3 -eq "$(git ls-files -u | wc -l)" &&
>>         test 4 = "$(cat otherfile-4)" &&
>>         git am --skip &&
>>         test_cmp_rev initial HEAD &&
>> --- 67,73 ----
>>   test_expect_success 'am -3 --skip removes otherfile-4' '
>>         git reset --hard initial &&
>>         test_must_fail git am -3 0003-*.patch &&
>> !       test 3 -eq $(git ls-files -u | wc -l) &&
>>         test 4 = "$(cat otherfile-4)" &&
>>         git am --skip &&
>>         test_cmp_rev initial HEAD &&
>> ***************
>
> Some comments:
>
> Quoting the output of 'wc -l' will break the tests on Mac OS X and BSD
> since the output contains leading whitespace which won't match the "3"
> on the other side of the '='.
>
> Your diff is backward, comparing 'current' against 'original', which
> makes it difficult to read. Reviewers on this list expect to see
> 'original' compared against 'current'.
>
> Use a unified format to make the diff easier to read; or just use
> git-diff or git-format patch, which is even simpler.
>
> It's not clear how the output of 'wc -l' could ever be the empty
> string. Perhaps git-ls-files is dying and causing the pipe to abort
> before 'wc -l' ever outputs anything? Without additional information
> about the problem you're experiencing, it's difficult to judge if this
> change is a good idea.
