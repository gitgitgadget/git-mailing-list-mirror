From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t4151 missing quotes
Date: Tue, 10 May 2016 15:44:32 +0200
Message-ID: <CALR6jEiFq6kjB0pQgvvd0Pc3i1ZNbGSG2a=i7Hij0HmgUNjgEA@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
	<xmqqmvnzt0yx.fsf@gitster.mtv.corp.google.com>
	<CAPig+cSRUqSQZ1G73X6szfXjJEwopaO20H_k2vrmmy1qpEftLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b07xv-0008PZ-N3
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 15:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcEJNoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 09:44:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35041 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcEJNod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 09:44:33 -0400
Received: by mail-yw0-f195.google.com with SMTP id v81so1081040ywa.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZuHoUUcx5WuBhpOYMmdzKZxfLYHKzLn+GZ4BqcnlLvs=;
        b=bIgeFWnTwWvf34dp+MkXv9fbI5aTQcXGSwLJhhx0VuN8YHz3WonszSKrTt2Pps98/5
         9vcV8p5Nt5LWGA+FskxRYtF92Jhd9HClWKf6I33E3o79wPAnHK5E1Q40B6+GG9knNIb9
         UVc9V7BiL6FV9C9gKkzf+Lb1QeNRnyoyMZBzYSRWVvu/uGIBSoLT5v1HHx/8CR8rkPXm
         qXeSnr9ADYiBuAxsuPjCTavIgOCARVXvrXYXr5e0sWZYkhpKSL57rrk4/Ph0sW6kQhVm
         vKiZgQke1IRLwFobO1wrgiMLlY131WYd9Xo6kCJQSEjbUVuRTVIZkij9FqhvR1wJzW0p
         Jv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZuHoUUcx5WuBhpOYMmdzKZxfLYHKzLn+GZ4BqcnlLvs=;
        b=bKphdAGKAIzoMHWTqeli4qK5M2CP+jcLob6g/R0pzOJA2Ey+5i02VERyUvbjL0soh1
         rsOTOx1jpZt+WIxNNfUpig2MF0Rz0GvcKvn3XuGh8t5T834I2NIgRESzXfILjtDUQiB8
         1tGk1Yjlu97n3jrJfRryGLM4jx1vSoT1S4UxaqUXBNGJ8FCN4zbYfB+jwtWuf4lu+AJM
         sNPbNSBD45fd5RYm9gQoQP4/4fH3C8opnibild0qy+XUiYAd0zjhTliF6bD6itN03xOg
         WnlnQsFDGBigS3bpxZvdsbAHeTdbnf4EjhmZ/HMUHUqE3MMlqnexmwFpkHD0uHFFgpuw
         XtfQ==
X-Gm-Message-State: AOPr4FXNE/HJvjijG9ADf7vo8DwaI+yF7KHv4GU9qw2J6CDgBEHqT2YNn+2GIup7kkyGXfqwXfCE/h1svPaJAw==
X-Received: by 10.13.204.69 with SMTP id o66mr22155359ywd.168.1462887872279;
 Tue, 10 May 2016 06:44:32 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 10 May 2016 06:44:32 -0700 (PDT)
In-Reply-To: <CAPig+cSRUqSQZ1G73X6szfXjJEwopaO20H_k2vrmmy1qpEftLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294130>

Sorry for any duplicate mails, the list blocked my html mail.
Note to self: Don't use GMail on a tablet.

On Mon, May 9, 2016 at 11:35 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> Hmph, do we have a broken &&-chain?
>
> I don't know. Unfortunately, Armin didn't provide much information in
> his initial email, saying only "skipping through some failed tests",
> which doesn't necessarily indicate if those tests failed or if he
> somehow manually skipped them.

In t4151 there was only a problem with this test. All other tests
inside t4151 were ok.
Skipping through the tests referred to all git tests, not just t4151.

>> If an earlier test fails and leaves an unmerged path, "ls-files -u"
>> would give some output, so "test -z" would get one or more non-empty
>> strings; if we feed multiple, this would fail.  But we would not have
>> even run "test -z" as long as we properly &&-chain these tests.
>>
>> I think the real issue is when the earlier step succeeds and does
>> not leave any unmerged path.  In that case, we would run "test -z"
>> without anything else on the command line, which would lead to an
>> syntax error.

Yes. While debugging the test, I saw a syntax error. I did not try to find out
why the test argument is empty. It seems not necessary.. the test logic
is still the same.

>>     Side Note: /usr/bin/test and test (built into bash and dash)
>>     seem not to care about the lack of string in "test -z <string>"
>>     and "test -n <string>".  It appears to me that they just take
>>     "-z" and "-n" without "<string>" as a special case of "test
>>     <string>" that is fed "-z" or "-n" as <string>.  Apparently, the
>>     platform Armin is working on doesn't.
>
> I also tested on Mac OS X and BSD, and they happily accept bare "test
> -n", as well (though, I don't doubt that there are old shells which
> complain).

I'm building on a quite current AIX 6.1 where /bin/sh defaults to /bin/ksh
which is a posix shell (ksh88).
Using /bin/bash doesn't work because SHELL_PATH is only used in
git scripts but not in any t* test scripts.
