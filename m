From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] t6041: do not compress backup tar file
Date: Mon, 9 May 2016 12:04:38 -0700
Message-ID: <CAGZ79kZ0gVzb7aqtdFFGt1mNxgNwX+xaWOtHOQt8kB84Yxhwsg@mail.gmail.com>
References: <1462813748-27538-1-git-send-email-sbeller@google.com>
	<xmqq8tzjul0p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Armin Kunaschik <megabreit@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon May 09 21:13:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azqU0-0005O4-BL
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 21:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbcEITEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 15:04:40 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33013 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcEITEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 15:04:39 -0400
Received: by mail-io0-f172.google.com with SMTP id f89so181876369ioi.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YDUmHUuImHy+j5t1pQ3o75JZyZ6FMgeGEj80rlIlsn8=;
        b=aEiFoPQsuQaK3jBJT8Budxh2cdvdHs3gkE7SvCNW9DNfKCsdQASKS0IflDXESFKMF9
         T2Et6/j/OiCQyqeXD2nLChpKeddMwfndN13mBX85EHHpAcOsYq1GhRwi7H06UDJ5olYC
         TjN/tDQlJfLQLvTb1s8izi7mUcWemxPPbNfTbO7YhU6XCduIfDavGrljzPVy9HxvdrUE
         yesnb0OauY4i1yy233w+Ukz2k+c0WESz9PhvAAZP/PqFVkGzbZQx6jZ2kVNLYBd2glfj
         I7xn5r0GNMVS1P50hkNp3Nplc5FpjS5yiXmfROzRCgASAjK5DKcwfGMokBDwO1U7sld2
         u3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YDUmHUuImHy+j5t1pQ3o75JZyZ6FMgeGEj80rlIlsn8=;
        b=Oflb73MOppb+g7uQBtMBwRuRjYVH6ikdw+dKlIqLyNyJf77YXpmgJ2tK/cS2WEebqO
         1/z6jDgLQq1W1+7tfRuJfNKUh7wxGLoJTy6Olja/k58p/sboBwHYUqD0qnZZpDG7U5wu
         3xyp8DW/6wixbTrurkdiYjPTbmSfz995bF8njfG1f1HVxw3I/ZPCJSnY518XlW4O0QMb
         d2gnQ/gQToVqTKGxEBBGcJM0Zrks1IU/GhvvCrPh5XM3mLhU4e8TOJIquga3WNL1ps8G
         IBv2qYNw8MAq93gbGo0hWRbFUuJ6X+XqW4bsclPldSo54V0YGMxSFT+kx/RY63u0PR00
         FCrg==
X-Gm-Message-State: AOPr4FVX3fntfjbufat33wTtUn15dy8+xaR4nERiwA1GhJdMgzkqkWK1iM+oSZjdRzgHtB/0G20JDWCBkzIIQ9IQ
X-Received: by 10.36.14.71 with SMTP id 68mr371356ite.98.1462820678368; Mon,
 09 May 2016 12:04:38 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 9 May 2016 12:04:38 -0700 (PDT)
In-Reply-To: <xmqq8tzjul0p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294040>

+ cc Jens as he authored both t6041 as well as t3513 in
the series leading to ad25da009e2a3730 (2014-07-21,
Merge branch 'jl/submodule-tests')

On Mon, May 9, 2016 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
>> index c6b7aa6..62b8a2e 100755
>> --- a/t/t6041-bisect-submodule.sh
>> +++ b/t/t6041-bisect-submodule.sh
>> @@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
>>  git_bisect () {
>>       git status -su >expect &&
>>       ls -1pR * >>expect &&
>> -     tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
>> +     tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
>>       GOOD=$(git rev-parse --verify HEAD) &&
>>       git checkout "$1" &&
>>       echo "foo" >bar &&
>> @@ -20,7 +20,7 @@ git_bisect () {
>>       git bisect start &&
>>       git bisect good $GOOD &&
>>       rm -rf * &&
>> -     tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
>> +     tar xf "$TRASH_DIRECTORY/tmp.tar" &&
>>       git status -su >actual &&
>>       ls -1pR * >>actual &&
>>       test_cmp expect actual &&
>
> While I am fine with taking this (and the other) change, which are
> the only sensible response to these bug reports, this makes me
> wonder two things and a half.
>
>  * Why do we even run "tar", especially without having a
>    test_when_finished clean-up?  Can't there be better ways to test
>    this and the other one without creating a copy of everything in
>    the test directory?

I think some of the submodule testing is a test machinery on its own.
Any submodule test that is not in t74* follows the pattern to
provide a short function for its testing and then call  test_submodule_switch
with some long option, e.g.
KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1

I haven't attempted to look into these tests yet as they seem to test
fundamentals ("submodules as files" in other commands), whereas
I am more interested in some new features currently.

>
>  * Are we sure the trash directory contents is kept manageable size?

The testing in lib-submodule-update.sh do not seem to take care of
these tarballs. And the small testing scripts do not either, but there
we could inject a

    test_when_finished "rm ..."

snippet IIUC.

>    I am primarily worried about this "we are not sure what we will
>    be clobbering, so let's blindly tar up everything and restore it
>    later" pattern spreading and people mistakenly use it in tests
>    that simulate our behaviour on a huge blob with a sparse but
>    gigantic file.
>
>  * Is an addition of 'test_snapshot $tarball *' and 'test_restore
>    $tarball' pair too much unnecessary refactoring to cater to only
>    two users of this "let's tar up everything" pattern, given that
>    we want to _discourage_ use of this pattern in the longer term?

As said before, I did not yet dive into these test areas myself.

>From a birds eye, there was not a lot of discussion around that series
(as compared to submodule groups for example). Maybe I am missing
prior or later series though.

http://thread.gmane.org/gmane.comp.version-control.git/251682


>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
