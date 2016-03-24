From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Thu, 24 Mar 2016 19:57:11 -0400
Message-ID: <CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:57:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajF7u-0001gV-BW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbcCXX5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 19:57:14 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36435 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbcCXX5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 19:57:12 -0400
Received: by mail-vk0-f65.google.com with SMTP id z68so6617001vkg.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=nOVaHk2NMDd/wR76aGXBur4XBoknHFy/ch1qOd+8aAQ=;
        b=RFBvNXkNPBy53E1r8tRFgEmnpweczZ33dKTqNzo9yCmkaouFQzqEj5AY6vooJg7CAW
         yM7BEfzvoGKGTMTec/D6MliheNkOTjuapkCUTeX2EpIktY9BpVpuRh08SWTCcxMMa2fo
         inLw202ZoChzw4VOlZL8aoDFq6pCMLBB89zrMUQLNPXsL0aDW0Xn7MqFmFGdE5l35Bhc
         eis1mEMMAu7Hd77EucqqhUdu8OJtue8xR6ybgZvLUGOEa7B50JM0Qm+SulsvI+cfFjt2
         lyMXOLhH8W9jDpXNN9YBCSZKzIAc5mX3XBJpspjWDMFHyfl1ciPK6zr3jMTlxark9aou
         YbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=nOVaHk2NMDd/wR76aGXBur4XBoknHFy/ch1qOd+8aAQ=;
        b=HHZPvSDz1AAN6/27e0ET026E7sq6QqM8l1mXIZp7H/yQwXxiDMPxGP6QfHIwoiLKwY
         onTTQr8j8Q1M7oxx3Xs3TlvM8fI/Ox6Ma/nlhvEOkoA63UtT1vx0p9XqOVYPIenJC7ce
         KCNOiRZh+s1PFZJw1FBoNkxL42kYRLnjpd9hnjkrCxV6Py+122EoXrihHxlFn4LcdxhU
         3BTLkA+fNq6iPiUuxZzIB6ZG/6wjKeKEVyozYEW/y+hPIc0OfrBGYWKS0h4+m5ipE7x6
         91pE1cFVUpdvZvzH/seBk1lg4rL0xHMTxq0lPbgaJVeY3ZKS5CSQXJJSRP0nGaNq+EEc
         cUuA==
X-Gm-Message-State: AD7BkJLqhhfIceiXNMB/xVk/XsfIVAojLU34F66Q0+0n+uHw+OLAuDEk3yCstwVSgu9aIzl4uKTnfzLpJ9/CYw==
X-Received: by 10.176.3.48 with SMTP id 45mr6177984uat.123.1458863831696; Thu,
 24 Mar 2016 16:57:11 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 16:57:11 -0700 (PDT)
In-Reply-To: <1458817259-11675-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: w9dleZPhTuffzHYQx95L7uwXuVo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289832>

On Thu, Mar 24, 2016 at 7:00 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> Also remove test_set_editor from global scope and use it in whicheve=
r
>> test it is required.
>
> Why?
>
> test_set_editor sets and exports shell variables.  Since you don't
> invoke test_set_editor in a subshell, after the first invocation the
> editor will be part of the global scope anyway.

Agreed that this needs proper justification in the commit message.
And, the justification is to make each test more self-contained,
particularly because a subsequent patch will introduce a second fake
"editor", and by making tests responsible for setting the editor they
need, they don't have to worry about bad interactions from "editors"
set by earlier tests[1][2].

Another issue is that the commit message is backward. The subject
("t7507-commit-verbose: make test suite use write_script") tries to
sell this as primarily being about write_script(), but the real gist
of the patch is that it is making each test more self-contained, and
the subject should say so. The write_script() bit is just a minor
aside which can be introduced with a "While here let's use
write_script to..." at the end of the commit message.

>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> index 2ddf28c..cf95efb 100755
>> --- a/t/t7507-commit-verbose.sh
>> +++ b/t/t7507-commit-verbose.sh
>> @@ -3,12 +3,11 @@
>>  test_description=3D'verbose commit template'
>>  . ./test-lib.sh
>>
>> -cat >check-for-diff <<EOF
>> -#!$SHELL_PATH
>> -exec grep '^diff --git' "\$1"
>> +write_script "check-for-diff" <<-\EOF &&
>> +grep '^diff --git' "$1" >out &&
>> +test $(wc -l <out) =3D 1
>
> Our test lib offers the test_line_count helper function, which
> outputs a helpful error message in case the number of lines do not
> match.

test_line_count() was mentioned in [2], however, this line counting is
done in the fake "editor" script, not in the test script proper, so
the spelled-out form $(wc ...) was proposed[2].

> The original didn't check the number of lines.  This change is not
> mentioned at all in the commit message.

Right, and this particular change really belongs in patch 3/3 where
it's needed[2], and should be properly explained by the 3/3 commit
message.

>>  EOF
>>  chmod +x check-for-diff

Drop the 'chmod' line; write_script() does this for you.

>> -test_set_editor "$PWD/check-for-diff"
>>
>>  cat >message <<'EOF'
>>  subject

[1]: http://article.gmane.org/gmane.comp.version-control.git/289329
[2]: http://article.gmane.org/gmane.comp.version-control.git/289370
