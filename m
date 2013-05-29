From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 06:23:48 -0500
Message-ID: <CAMP44s0U65oxCVy3EwQxF+4ZgRc31z29mwwdO=4x--oFVTFW+g@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<20130528110014.GA1264@hmsreliant.think-freely.org>
	<7vobbv2fze.fsf@alter.siamese.dyndns.org>
	<51a568db9c9b8_807b33e18996fa@nysa.mail>
	<ko4jf7$e4d$1@ger.gmane.org>
	<CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>
	<001601ce5c5d$89974830$9cc5d890$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed May 29 13:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheTy-00016x-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965683Ab3E2LXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:23:50 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37592 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965525Ab3E2LXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:23:50 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so8914678lbh.27
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s/u9ksYFIW4EfhAei5KOC8+RBEBDwz+x5ceoKP5nFPE=;
        b=CJu8zl7qltYUzVbgrYKvjRlSaQDVa4fCV4TzM9wwJKkHvqR/TFZtohKDLmSRf6kvb9
         CO6dii1ShDURca6ucVP5G7a3gc1Esn+GIzz0Jzv+96kwwcV6N6X/nDr6pMdFUQDS1ubl
         DNPXn9al3Z8VuGKKsmvnsnx9D8wtF3JC3VzgftqR+tkQkHBCO7tKecfHE9/DdiVcJXMO
         /o3mi0jNoyUA33T2wsjuLCQAziVw9Dx0lF8l5krlBwuKksYgH0YgECXKC9oukxuI+z9J
         0PNXrZO7uWWX0pgOnywS43Pvs3KaloqYtBGc/4hzwq3CQC6utgdkDu8TzVK0+SThcoct
         +ylw==
X-Received: by 10.152.1.137 with SMTP id 9mr1142309lam.10.1369826628473; Wed,
 29 May 2013 04:23:48 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 04:23:48 -0700 (PDT)
In-Reply-To: <001601ce5c5d$89974830$9cc5d890$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225789>

On Wed, May 29, 2013 at 6:13 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
>> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>> Sent: Wednesday, May 29, 2013 12:52 PM
>> To: Joachim Schmitz
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH 1/2] sequencer: trivial fix
>>
>> On Wed, May 29, 2013 at 4:58 AM, Joachim Schmitz
>> <jojo@schmitz-digital.de> wrote:
>> > Felipe Contreras wrote:
>> >>
>> >> Junio C Hamano wrote:
>>
>> >>> It probably is better to fold this patch into the other one when it
>> >>> is rerolled to correct the option name gotcha "on the tin".
>> >>
>> >>
>> >> Why? This patch is standalone and fixes an issue that is independent
>> >> of the other patch. Why squash two patches that do *two* different
>> >> things?
>> >>
>> >> Anyway, I'll happily drop this patch if you want this memory leak to
>> >> remain. But then I'll do the same in the other patch.
>> >>
>> >> This mantra of avodiing 'goto' is not helping anybody.
>> >
>> >
>> > adding 5 letters (to change the next "if" into an "else if") versus your
>> > addition of several lines and some 15 additional letters (ignoring the
>> > whitsspace)  is IMHO enough to see what is better?
>>
>> This has nothing to do with what Junio said.
>
> Well, it has, but you had snipped it. But replied to the goto issue regardless

I didn't snip anything, this is a different context.

>> This is better done without "goto" in general.

He din't say:

__
It probably is better to fold this patch into the other one when it
is rerolled to correct the option name gotcha "on the tin", AND you
fix the goto issue.
__

You added that last part in your mind. Moreover, he didn't say goto
was an issue, he simply stated an opinion about some generality.

-- 
Felipe Contreras
