From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 05:45:27 +0530
Message-ID: <CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeAjs-0004Ww-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 01:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbcCKAP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 19:15:29 -0500
Received: from mail-yk0-f193.google.com ([209.85.160.193]:35732 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbcCKAP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 19:15:28 -0500
Received: by mail-yk0-f193.google.com with SMTP id p128so2735939ykc.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 16:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Wwd1WtsmgrjMFYFRnyWm2E+/Zua94iTYJKIuPVc0UF0=;
        b=itw+Ug+l0/mjIL12VU+XVkMkC8Tn3YEDHI3hkkMwgpfr3KA7X0SMZrYAcHntIKucN4
         COfzSFix5CWJL1lpWjSGu+xkSI9MZkJXrwdX/YPTQJCexamjq5ihVKBArdYdOKOKGqSI
         zKXhKRKUV7GZFOJxuzQwGG3JorVsFjnLBB0qW4AVW+R4+1w7q0L5EHW8X8ralc9LyvST
         kk8fywwTWG53n6p+XTJiSlO7Vzi8ej3WJRnsazXHRERfwO+BDHkgy0dm9e7P4g32U0vQ
         ZeXopSVhMnMP4inEepI0ECMY75Ef60bZJhV+xaoMXelueQjWhpbhxiN8I4y9qDVcYQqd
         PqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Wwd1WtsmgrjMFYFRnyWm2E+/Zua94iTYJKIuPVc0UF0=;
        b=I+SPdzkOr8vURd+HMvycNSQrqEQGe68Lx/Y6oA+4Ck3ijWHd+cvWHsnEcW+LpmBsEE
         jd0AZ0s0f2wuwga6vqaODfMhCAkJaoLPz2sBQl4JqCBQyFEk17abNT7pXnhT1JyLE+X1
         fFchTFMg2cs0Cbba9Os9CWkKAdUhdPcx9FKuhQIeNhFXfQ2yBkGILdhtbFlYVs9E+Sur
         X4Zt5RwShJT+bMXs4yL0ObA3S0r1OLZm4bPywLZyyJIja4CtRHcLTH/AfFVwpz5p0e7b
         6Ngap7bLIqRTiN93y/9Q58PX3WhPGNFHHbC6doy/+2WLJVxI6Lg/Mmh1LON+rajcvv0w
         4BsQ==
X-Gm-Message-State: AD7BkJKItTwYm+bN2j4c+hQ/5JGLchywsPqcKEVUDkbrCjYPdAtM5aFYuF8C9t/f//H//fGMjfJ8AWJVXRCptg==
X-Received: by 10.37.24.138 with SMTP id 132mr3720036yby.21.1457655327309;
 Thu, 10 Mar 2016 16:15:27 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 16:15:27 -0800 (PST)
In-Reply-To: <CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288665>

On Fri, Mar 11, 2016 at 4:31 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>     Add commit.verbose configuration variable as a convenience
>     for those who always prefer --verbose.
>
> or something.

Sure!

> As a convenience to reviewers, please use this area below the "---"
> line to provide links and explain what changed since the previous
> round rather than doing so in a separate email.

Actually I am sending the patches with submitGit herokuapp because my
institute proxy does not allow IMAP/POP3 connections.


> The "permanently" bit sounds scary. A more concise way to state this might be:
>
>     See the `commit.verbose` configuration variable in
>     linkgit:git-config[1].
>
> which doesn't bother spelling out what the intelligent reader should
> infer from the reference.
> Style: space before {

Sure!

>> +test_expect_success 'commit with commit.verbose true and no arguments' '
>
> "no arguments" doesn't convey much; how about "--verbose omitted" or
> something? Ditto for the titles of other tests.

Will change the language construct.
>> +       echo content >file &&
>> +       git add file &&
>> +       test_config commit.verbose true &&
>> +       (
>> +               GIT_EDITOR=cat &&
>> +               export GIT_EDITOR &&
>> +               test_must_fail git commit >output
>> +       ) &&
>> +       test_i18ngrep "diff --git" output
>> +'
>
> Making git-commit fail unconditionally with "aborting due to empty
> commit message" is a rather sneaky way to perform this test. I would
> have expected to see these new tests re-use the existing machinery
> provided by this script (the check-for-diff "editor") rather than
> inventing an entirely new and unintuitive mechanism. Doing so would
> also reduce the size of each new test.

I agree on the fact that making git-commit fail unconditionally is not
a good way to perform the test. "check-for-diff" is not really an
"editor" and it checks for the commit message after it has been
written to the history. The verbose output is stripped when it is
written to the history so we won't be able to test whether this patch
works. This is where purposely breaking the code is required as when
the commit fails, it gives the output of the contents present at that
time (which will contain the verbose output). More over the
'check-for-diff' uses grep which is not preferred. Many tests are now
using test_i18ngrep (eg. f79ce8db). I had planned on using
'check-for-diff' before but it took me some time to figure out this
behavior and thus I began searching for another mechanism (breaking
code).

> Some additional tests[1][2] are probably warranted.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/288648
> [2]: http://article.gmane.org/gmane.comp.version-control.git/288657

I think these tests also are better included in this file as this
patch triggers it and it would not make much of a difference between
t7507 and t7502 but in fact improve its readability.
>>  test_done
