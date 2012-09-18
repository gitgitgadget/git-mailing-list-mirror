From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 13:57:50 -0700
Message-ID: <7v627bkq0h.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com>
 <7v7grstlp9.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
 <7v627bq0gx.fsf@alter.siamese.dyndns.org>
 <CALkWK0kbeLtU-5_9QnmQKS1yO02SvCW3ERvami9bmCa0Vym8oQ@mail.gmail.com>
 <7vr4pzoj5a.fsf@alter.siamese.dyndns.org>
 <CALkWK0=JY3pTyyMAmFVnQatn6gd3eC7dxiBbTh0WmVwkdLTbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4rr-00044X-2y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab2IRU5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:57:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab2IRU5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:57:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D1D192F3;
	Tue, 18 Sep 2012 16:57:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aapv2MzIOWc8jRjl3pTfqt7hNgw=; b=R1qWIi
	z0Zng1jtpintMX4cdYO6pxr5DA+DyCNl1pBBZCmg36LGWC20XfKRFJmV695I0Hpf
	N+b4yqXvgwBfExd5t3G+AXZwAh8OsVRdQBfi2rbqgAzd3SoVt89pADOd+5FahPd+
	P56AefeA2/G2Kp6AFsha6PEhaWjbEvlrG8860=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTg3adu8IJhScu7KRrtzPMFu3kKVanB3
	BlWXPy9r9XqFL88Wnfm8cX9nBYJieizu1ZuICcFHRgTmm6j5mG6sY/K/NCU0tE5N
	IIRPJ0MzlgD8exNCeL6AuofF8WsO5JEz76UTn+oaIg2Ju3jkPBx7fn5zMQhyqCwR
	xuJghCT+330=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B39392F2;
	Tue, 18 Sep 2012 16:57:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9868192F1; Tue, 18 Sep 2012
 16:57:51 -0400 (EDT)
In-Reply-To: <CALkWK0=JY3pTyyMAmFVnQatn6gd3eC7dxiBbTh0WmVwkdLTbHQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 18 Sep 2012 13:37:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82A81EDA-01D3-11E2-9F48-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205874>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> Because that emits an ugly
>>> ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found
>>
>> Don't you deserve it? ;-)
>>
>> The full message would read
>>
>>     ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found
>>     error: you do not seem to have built git yet.
>>
>> which looks perfectly sensible to me.  It makes it clear where on
>> the filesystem the test script expects your "git", which is an added
>> benefit.
>
> Fair enough- use your version then.  Let me know if you want me to
> submit a revised patch.

OK, let's do this.

-- >8 --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Mon, 17 Sep 2012 22:36:19 +0530
Subject: [PATCH] t/test-lib: print pretty msg when git isn't built

When tests were run without building git, they stopped with:

    .: 54: Can't open /path/to/git/source/t/../GIT-BUILD-OPTIONS

Move the check that makes sure that git has already been built from
t0000 to test-lib, so that any test will do so before it runs.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 10 ----------
 t/test-lib.sh    |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ccb5435..741b6b6 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -18,16 +18,6 @@ swapping compression and hashing order, the person who is making the
 modification *should* take notice and update the test vectors here.
 '
 
-################################################################
-# It appears that people try to run tests without building...
-
-../git >/dev/null
-if test $? != 1
-then
-	echo >&2 'You do not seem to have built git yet.'
-	exit 1
-fi
-
 . ./test-lib.sh
 
 ################################################################
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..61930fb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,6 +51,13 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+"$GIT_BUILD_DIR/git" >/dev/null
+if test $? != 1
+then
+	echo >&2 'error: you do not seem to have built git yet.'
+	exit 1
+fi
+
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
-- 
1.7.12.563.g54818e4
