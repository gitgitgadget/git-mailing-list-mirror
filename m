From: Stefan Beller <sbeller@google.com>
Subject: Re: git.git as of tonight
Date: Mon, 2 Nov 2015 15:06:44 -0800
Message-ID: <CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 00:06:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtOBd-00059o-WD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 00:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbKBXGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 18:06:46 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34331 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbKBXGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 18:06:45 -0500
Received: by ykdr3 with SMTP id r3so155599260ykd.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VbDJHRO1ofvCqTgfpYWMjRjZ5T0jB1bcdxAkRmPotDI=;
        b=Bz7Gl/MBGa5b2ij6yYsoMbNslFPrUJxiKutGhHcr7SiV2xP9sYdAKMNUcXTSvbK10K
         i+p/P/qoJh2QXY/GyRPlbH9Zy7PeUBvzeOh30DaHV0HCx4K4eae54U/p+6V8sAMoxF8R
         DPgW8ihVtTvTRhV+CXPUn8WnOy/lqB/7Sfa4fDrfw8XGIDlyu8AI7jDyHySgrOh3vD1r
         JmdhxsoUeancEKxvTR6YOXMN/4gdcJ7JnHIrgppsulV8yoTgEvjtEyg05cU4VhVIJhN9
         qGFAXhhNVhvI5ImklXVV5JgjNmwBK4v07YACqvctJyzJ3OzLWjRNtm9rDHsfh71gRYKN
         IPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VbDJHRO1ofvCqTgfpYWMjRjZ5T0jB1bcdxAkRmPotDI=;
        b=a5XntUQLpDmFM+WMAxyDhbre7jXHS9abCW4Dkm1Nou9s+sl3DirTB1cYCajgXarvUG
         i9fwfe9/Thv0NMZ75FjTlVxmBLlarlnBqNtOZ+/Ud4TsCv4RBLdnLRlKd6jAisV8Xlvr
         XZ7Acd39kDHR97hgDUhz+okHT3MwCfC9CWVafgZe4g9rhHbYz5NdllV/vs5hQfIh9CEM
         AyijeuoIMosKsTJMVw1CdC7llVCJd0oOSv5/oTUskoYpF68fo8/lJ7PZXThoDEm1C3Oa
         UC4Y7hF+aYcqOHN9xkzoM0OzpzVIiF6F4G9157AbQgFuLYorDxG7t/j40wLo6sJL6tWK
         muqQ==
X-Gm-Message-State: ALoCoQkvuTyFxb/Oq6doF//FLmCxajdBnn6+2w5Bj8Js/FdCF1trnHfEGUJE4K+Mhr3USYNm5Sl0
X-Received: by 10.129.155.130 with SMTP id s124mr18722239ywg.68.1446505604523;
 Mon, 02 Nov 2015 15:06:44 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Mon, 2 Nov 2015 15:06:44 -0800 (PST)
In-Reply-To: <5637D266.4060904@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280736>

On Mon, Nov 2, 2015 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.11.2015 um 03:58 schrieb Junio C Hamano:
>> * sb/submodule-parallel-fetch (2015-10-21) 14 commits
>>    (merged to 'next' on 2015-10-23 at 8f04bbd)
>>   + run-command: fix missing output from late callbacks
>>   + test-run-command: increase test coverage
>>   + test-run-command: test for gracefully aborting
>>   + run-command: initialize the shutdown flag
>>   + run-command: clear leftover state from child_process structure
>>   + run-command: fix early shutdown
>>    (merged to 'next' on 2015-10-15 at df63590)
>>   + submodules: allow parallel fetching, add tests and documentation
>>   + fetch_populated_submodules: use new parallel job processing
>>   + run-command: add an asynchronous parallel child processor
>>   + sigchain: add command to pop all common signals
>>   + strbuf: add strbuf_read_once to read without blocking
>>   + xread_nonblock: add functionality to read from fds without blocking
>>   + xread: poll on non blocking fds
>>   + submodule.c: write "Fetching submodule <foo>" to stderr
>>   (this branch is used by rs/daemon-leak-fix and sb/submodule-parallel-update.)
>>
>>   Add a framework to spawn a group of processes in parallel, and use
>>   it to run "git fetch --recurse-submodules" in parallel.
>>
>>   Will merge to 'master'.
>
> Please don't, yet. This series does not build on Windows:
>
> run-command.c: In function 'set_nonblocking':
> run-command.c:1011: error: 'F_GETFL' undeclared (first use in this function)
> run-command.c:1011: error: (Each undeclared identifier is reported only once
> run-command.c:1011: error: for each function it appears in.)
> run-command.c:1015: error: 'F_SETFL' undeclared (first use in this function)
> run-command.c:1015: error: 'O_NONBLOCK' undeclared (first use in this function)
> make: *** [run-command.o] Error 1

Going by a quick search http://stackoverflow.com/a/22756664
I'd hope we only need to modify the set_nonblocking function using #ifdefs ?

>
> I have to investigate whether we can have some sort of Posixy
> non-blocking IO on Windows or whether we have to opt-out from this
> parallel-process facility. Any help from Windows experts would be
> appreciated.
>
> -- Hannes
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
