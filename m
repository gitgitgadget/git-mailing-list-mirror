From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Wed, 29 May 2013 14:32:59 -0500
Message-ID: <CAMP44s1ig9FvkPNBAmmBOKaH9iWoEYN5kfom_t0wpqPGrqpqVw@mail.gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
	<7vmwrezx7n.fsf@alter.siamese.dyndns.org>
	<51a56ce142986_807b33e18100084@nysa.mail>
	<7v8v2xvhbu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2-Of=AS9Jg7YAXnZ2346ozWPS4gL5irh0devwpkdBKmQ@mail.gmail.com>
	<7v61y1tymh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhm7N-0001XX-TP
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966172Ab3E2TdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:33:02 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:45384 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966032Ab3E2TdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:33:00 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so6763919wes.40
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eeLyEJrbZafmbmd9Ko8adep9fCVYqnA3gBFn/8lpLDM=;
        b=nl8jlfE/HMtqljbhPXNj0HS87y+KJrKMjiBTlV5y4jv/NnKVXbEVPaEMX9LKB0rICD
         EWGSV9K3fv7ajoDD6SOjAFGfe7J7rMzdF6o1lK+8ykbQSlIl/9+5dACYGEKCYxDyWoXR
         1iS7TVkgAkQ4nL5Kn2T1Y8koBKZuMavmK1ZoR8PZAnC9Zvpcem+NaC5IIqD7cnpqQ1DE
         e8Y9AR83qDfZHGmkljTmXrPDKzDNSUKn1HhrzWaoP/IUkkjssrvYqI0K6FOwgKMAK0VM
         7OGu6f+AhL6yQK23X2HnXCGESIbXwvdktqyZdTOgtVjz0OS5PCVdUsGcbtH2KMpCf8et
         GXug==
X-Received: by 10.180.184.101 with SMTP id et5mr2178635wic.45.1369855979232;
 Wed, 29 May 2013 12:32:59 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 12:32:59 -0700 (PDT)
In-Reply-To: <7v61y1tymh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225874>

On Wed, May 29, 2013 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 29, 2013 at 12:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> I do not see how it makes sense to copy how they deviate from us
>>>>> back to our codebase, especially if we plan to eventually move some
>>>>> of these tests out of contrib/ area, but even without such a plan in
>>>>> the future.
>>>>
>>>> They deviate from us, we deviate from them, whatever. We are a single project,
>>>> what more than one project does is more standard.
>>>
>>> We are a single project, so it is better to consistently follow the
>>> local convention established here.
>>>
>>> If your proposal were to
>>>
>>>  - Convert t/*.sh to end with .t intead, to change the project
>>>    convention, and
>>>
>>>  - Make contrib/ things also conform to that new convention.
>>>
>>> it may make some sense to discuss the pros and cons of such a move,
>>> but changing only contrib/ has no effect other than making it even
>>> less consistent with the rest of the project.
>>
>> It's already inconsistent with the rest of the project, as they are
>> not named tNNNN-foo.sh.
>
> Correct; that is why I said "even less consistent".
>
>> If you want I can give it a try at renaming all the tests in the whole
>> project to *.t, but I don't think you are truly interested in finding
>> a better extension for our tests.
>
> Again, correct.  I do not think it is worth the trouble to renaming
> them to *.t at this moment.
>
> Having said that, I suspect that in the very longer term it might
> turn out to be a good thing to do (if we want to make our test suite
> runnable under other people's tools that expect .t suffix, for
> example).  But I do not think that is the topic of this patch under
> discussion.

That's right. I just think if we didn't have the burden of so many
existing tests, and had the chance to pick the test extension from
scratch, it should be .t.

-- 
Felipe Contreras
