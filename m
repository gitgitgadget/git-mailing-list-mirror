From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 01:22:12 +0300
Message-ID: <CAMP44s07JOVQp2xNNdPew5L5_ibyk713m7UoJ6MrKOyKEmTkGw@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
	<7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com>
	<20120406214219.GB5436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHXv-0001T4-Fx
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab2DFWWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 18:22:14 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44532 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2DFWWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 18:22:13 -0400
Received: by wgbds11 with SMTP id ds11so847607wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=na1vpgke1fNQaywVedFPS1aYHGgIqGXW0VDUlNCPY0c=;
        b=0AEJrfiO0mp64vNHGgBwA7nLVwwub2UVoRk4Dn0MN7RXxgFJiNRow4Lcllnce8+xMI
         jO2LH1MAwfIGazrY75Mrutax5pbIfDzcVL7GzERHjP+16b4UJccXFGycGrNlPe9zpKGA
         yUPmbHLWozwCDyODt9hCA5EnoKxxNk0zIjDi8Bp+cPwfyEcyfG07H9UqgcOEwLAztBNJ
         sx1LBEZLwC1q3pmXKJWTPnMJ85hnSvlV4A1s7/yYo+pCUHEwa8yI5k/o36fjRQl9uxAu
         /evTt82ttVKqj0Ty+YYVSpTqUyMwBfoEkEeHV1rpmOrFxvk/eLlQe1Zm3o9Q/0XJrXUz
         VYcA==
Received: by 10.216.138.17 with SMTP id z17mr4750657wei.18.1333750932051; Fri,
 06 Apr 2012 15:22:12 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 15:22:12 -0700 (PDT)
In-Reply-To: <20120406214219.GB5436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194918>

On Sat, Apr 7, 2012 at 12:42 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 07, 2012 at 12:28:05AM +0300, Felipe Contreras wrote:
>
>> On Fri, Apr 6, 2012 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Jeff King <peff@peff.net> writes:
>> >
>> >> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>> >>
>> >>> Something is better than nothing.
>> >>
>> >> Yes, but...
>> >
>> > ;-)
>> >
>> > This is a good example that sometimes something is worse than nothing,
>> > unless watched carefully by a competent reviewer.
>>
>> And this is a good example of why you shouldn't blindly trust what a
>> 'competent reviewer' says, as I'm pretty sure the comment is wrong.
>>
>> But hey, if you prefer nothing, fine, drop this patch; let's continue
>> to blindly modify the completion and fix regressions as they come. I
>> guess I should drop my other tests as well.
>
> Sorry, but I think you are wrong, and this is a perfect example of why
> you are sometimes frustrating to work with. Your patch is definitely a
> move in the right direction, and we would love to have something like it
> as part of git. And I'm sure it runs fine under _your_ setup. But the
> git community is much larger than just your setup, and your patch is a
> regression for other people, as it breaks "make test".
>
> Did I say "let's throw away this patch"? No. I said "here is a problem
> with your patch", and I even sketched out a fix.

My comment was to Junio, not to you; Junio said "sometimes something
is worse than nothing"; if that's not preferring nothing, I don't know
what it is.

I just sent an email where I assumed you preferred the status quo,
sorry if I misinterpreted you, but my last patches to add some tests
were never applied because you advocated the status quo; no tests.

> And nor do I think Junio was saying "let's throw it out". I think he was
> responding specifically to "something is better than nothing". It's
> _not_ better if it regresses other cases. So the patch as-is is not
> acceptable, but it could be made so.

Did you notice the "RFC" part of it? This patch was not meant to be
applied as-is.

> But instead of taking the constructive criticism and iterating on your
> patch, you are ready to withdraw your patch. That seems silly when you
> have already done the hard part, and the fix to make the patch
> acceptable is the easy part.

I have already done the "hard part" in the past and yet my patches
were dropped because of commit message wording (or whatever), and we
ended up with the status quo; no tests. So excuse me if I'm not eager
to engage in a discussion in which you provide some "constructive
criticism", Junio agrees, I disagree, and the patch never goes
anywhere.

> But maybe I am wrong. Maybe there is no problem at all with your patch,
> and my analysis is wrong, and yours is right. I am willing to admit that
> as a possibility. But let's discuss it in the other part of the thread
> and find out, shall we?

I didn't say there was no problem with the patch, I said the
*particular* problem that you pointed out was incorrect (the shebang).

But OK, I will try once more to provide a more proper solution, let's
see how it goes.

Cheers.

-- 
Felipe Contreras
