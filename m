From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Wed, 30 Oct 2013 20:07:01 +0100
Message-ID: <CALKQrgdo=RP6vgCUML_L_NPsvSbg8Lyjy4HqmWYXk+NmWOjCvw@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
	<CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
	<CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
	<CAP8UFD1eTmUGt7dWAP-Ws17op=z98hOvBa_g8_y=xS8WQ1dRMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:07:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbb7G-0000VR-I8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab3J3THM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:07:12 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:40552 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab3J3THK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:07:10 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Vbb6h-0000TV-Rg
	for git@vger.kernel.org; Wed, 30 Oct 2013 20:07:07 +0100
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Vbb6h-0001Ta-5c
	for git@vger.kernel.org; Wed, 30 Oct 2013 20:07:07 +0100
Received: by mail-pa0-f46.google.com with SMTP id rd3so1391196pab.33
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 12:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1hHEJKZjmH3g3IclM+qFqbmbIQX3hIda2LD68aauf30=;
        b=aG8tk9nWKLk2dEXQPsLMmoCjwVx6sDxuy/5kTM0Xf53wDCRZN6rAS9Kxh4frLcntC4
         8x5j3KSYJd87hmKfdSPHEKeCAbkfdRCdoaQ/vHay5Ht3eiZcvZYXS+5Ce83BmSzgxgsV
         7I3U77nCyiM5tLMP4R6mluZOueBnVnO+nrLBKmqhzvWKV0akmyYOnzwXNslSnK53h1yp
         272cm9xHj+Y9J+NseZWuhjV3HVl2C6ct8quK0xwcp38LtPEVg2Fby2EMGpgxVnG1SxAy
         O6US/BFFS9jzGZzK9rXTYWq3aLXGvorcNoTJ9qGHRvO4NuM1QykPsKH2FZHiDRjBsgRK
         BrGg==
X-Received: by 10.66.121.201 with SMTP id lm9mr29233pab.80.1383160021696; Wed,
 30 Oct 2013 12:07:01 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Wed, 30 Oct 2013 12:07:01 -0700 (PDT)
In-Reply-To: <CAP8UFD1eTmUGt7dWAP-Ws17op=z98hOvBa_g8_y=xS8WQ1dRMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237057>

On Tue, Oct 29, 2013 at 7:23 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Oct 28, 2013 at 3:46 AM, Johan Herland <johan@herland.net> wrote:
>> On Sun, Oct 27, 2013 at 8:04 PM, Christian Couder <christian.couder@gmail.com> wrote:
>>> If "git commit" processes these arguments and puts the result in the
>>> commit message file that is passed to the
>>> prepare-commit-msg hook, then this hook can still get them from the
>>> file and process them however it wants.
>>>
>>> And in most cases the processing could be the same as what is done by
>>> the commit-msg hook when the user changes the "Fixes: xxx" and
>>> "Stuffed-by: yyy" lines in the editor.
>>>
>>> So it would probably be easier for people customizing the
>>> prepare-commit-msg and commit-msg if "git commit" processes the
>>> arguments instead of just passing them to the prepare-commit-msg hook.
>>>
>>> And it will be better for people who don't set up any *commit-msg hook.
>>> Even if there is no commit template, "-f Acked-by:Peff" and "-f
>>> Fixes:security-bug" could still work.
>>> I suspect most users don't setup any hook or commit template.
>>
>> Hmm. I'm not sure what you argue about which part of the system should
>> perform which function. Let's examine the above options in more
>> detail. Roughly, the flow of events look like this
>>
>>   git commit -f ack:Peff -f fix:security-bug
>>     |
>>     v
>>   builtin/commit.c (i.e. inside "git commit")
>>     |
>>     v
>>   prepare-commit-msg hook
>>     |
>>     v
>>   commit message template:
>>     Fixes: security-bug
>>     Acked-by: Peff
>
> Here it could already be:
>
>      Fixes: 1234beef56 (Commit message summmary)
>      Acked-by: Jeff King <peff@peff.net>
>
> Because builtin/commit.c hook could already have expanded everything.
>
>>     |
>>     v
>>   user edits commit message (may or may not change Fixes/Acked-by lines)
>>     |
>>     v
>>   commit-msg hook
>>     |
>>     v
>>   commit message:
>>     Fixes: 1234beef56 (Commit message summmary)
>>     Acked-by: Jeff King <peff@peff.net>
>>
>> (The above is even a bit simplified, but I believe it's sufficient for
>> the current discussion.) So, there are several expansions happening
>> between the initial "git commit" and the final commit message. They
>> are:
>>
>>  1. "fix" -> "Fixes: "
>>  2. "security-bug" -> "1234beef56 (Commit message summmary)"
>>  3. "ack" -> "Acked-by: "
>>  4. "Peff" -> "Jeff King <peff@peff.net>"
>>
>> First, I think we both agree that expansions #2 and #4 MUST be done by
>> the commit-msg hook. The reason for this is two-fold: (a) the
>> expansion must be done (at least) after the user has edited the commit
>> message (since the values entered by the user might require the same
>> expansion), and (b) how (and whether) to perform the expansion is a
>> project-specific policy question, and not something that Git can
>> dictate.
>
> I don't agree. Git doesn't need to dictate anything to be able to do
> these expansions.
> Git only needs some hints to do these expansions properly and it could
> just look at the commit template, or the config, to get those hints.
>
> For example, if there is a "Acked-by:" line in the commit template,
> then Git might decide that "ack" means "Acked-by", and then that "-by"
> means that "Peff" should be related to an author, and then that it is
> probably "Jeff King <peff@peff.net>".

I don't like putting that much Magic into core Git... Especially not
into builtin/commit.c. However, if we - as you suggest further below -
put it into a separate helper, and we make that helper available (and
usable) from elsewhere (most importantly from hooks where
people/projects can add their own more specific functionality), then I
don't have a problem with it.

[...]

>>> Supporting project specific conventions/rules would still be possible
>>> by processing lines in the commit message file without changing "git
>>> commit".
>>>
>>> If "git commit" is already able to do some processing, it only adds
>>> power to what can be done by people writing hooks.
>>>
>>> We could even have git plumbing commands used by git commit to process
>>> the -f (or whatever option) arguments and they could be reused by the
>>> *commit-msg hooks if they find them useful.
>>
>> Can you walk through an example of such reusable functionality?
>
> Ok, let's call the new plumbing command "git interpret-trailers".
> And let's suppose that "git commit" is passed "-f ack:Peff -f
> fix:security-bug" (or "--trailer ack=Peff --trailer
> fix=security-bug").
>
> "git commit" would then call something like:
>
> git interpret-trailers --file commit_message_template.txt 'ack:Peff'
> 'fix:security-bug'
>
> And this command would output:
>
> ------------------
> <<<upper part of commit_message_template.txt>>>
>
> Fixes: 1234beef56 (Commit message summmary)
> Reported-by:
> Suggested-by:
> Improved-by:
> Acked-by: Jeff King <peff@peff.net>
> Reviewed-by:
> Tested-by:
> Signed-off-by: Myself <myself@example.com>
> ------------------
>
> Because it would have looked at the commit template it is passed and
> filled in the blanks it could fill using the arguments it is also
> passed.
>
> "git commit" would then put the above lines in the file that it passes
> to the prepare-commit-msg hook.
>
> Then the prepare-commit-msg could just do nothing.
>
> After the user has edited the commit message, the commit-msg hook
> could just call:
>
> git interpret-trailers --trim-empty --file commit_message.txt
>
> so that what the user changed is interpreted again.
>
> For example if the user changed the "Reviewed-by:" line to
> "Reviewed-by: Johan", then the output would be:
>
> ------------------
> <<<upper part of commit_message.txt>>>
>
> Fixes: 1234beef56 (Commit message summmary)
> Acked-by: Jeff King <peff@peff.net>
> Reviewed-by: Johan Herland <johan@herland.net>
> Signed-off-by: Myself <myself@example.com>
> ------------------
>
> And that would be the final commit message in most cases.

This approach looks OK to me, as long as we make sure that this
functionality is (a) optional, (b) flexible/reusable from hooks, and
(c) not bound tightly to core Git (and AFAICS, your proposal is just
that). As I said above, this stuff certainly does not belong in
builtin/commit.c...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
