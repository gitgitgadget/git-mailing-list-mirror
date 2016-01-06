From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 11/15] ref-filter: convert variable 'width' to an
 unsigned int
Date: Wed, 6 Jan 2016 15:47:59 +0530
Message-ID: <CAOLa=ZT=_t62eKpkPbf+5k9TC0MoeN63+nwVTWLccG0rJF09kQ@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-12-git-send-email-Karthik.188@gmail.com> <xmqqmvsjivcv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 11:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGlAo-0006a6-HI
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 11:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcAFKSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 05:18:31 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32769 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbcAFKS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 05:18:29 -0500
Received: by mail-vk0-f68.google.com with SMTP id f2so23869574vkb.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kiGNAZmrE7sJ9A4HgU5rZuqH7hTqZvgZBf891XNyJE0=;
        b=L6S6DX93wGfU4XqA5xBQ98V6ubstDQgY1Se723Ljy5rBMFqbJI2I0gofhNnstbijzD
         oxywb2G/AC9nBqFDfBn0k7N+5F2Lmi78CnNRKu/q0GKtzkK7aLU2EL2MKXU8iRNetuCj
         x9zYXqcctOvaynv8ew7aVjaGCqhxnJexi/iVzR0D+sdtyFU0PMpIavUrYO9Kir1u5U5U
         cyIWa0I+EU4RjHw46+0ccz0Vb0qFjXvFzAlf2Y1WS0ET1ukoRV5g+I5lHSrutDbK7Y4p
         r4Zt/Um0838jtEZbfd4R0uwKxCs/36oDEF3tGas60UIz7rZS6nVWppWCpoZ69COoKKVT
         vldg==
X-Received: by 10.31.16.140 with SMTP id 12mr64044211vkq.106.1452075509050;
 Wed, 06 Jan 2016 02:18:29 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Wed, 6 Jan 2016 02:17:59 -0800 (PST)
In-Reply-To: <xmqqmvsjivcv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283433>

On Wed, Jan 6, 2016 at 2:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In align_atom_parser() the 'width' variable is an int, which requires
>> an explicit type conversion when used in strtoul_ui(). Hence make it
>> an unsigned int.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>
> Shouldn't this be done in [09/15] from the beginning?  As it's not
> like [09/15] was a pure code movement, this step looks like "Oops,
> I screwed up earlier, and here is a fixup".
>
> If we want to do this as a separate step, it would be easier to
> follow if it is done _before_ 09/15 to the original of the code
> movement, I think.
>

Haha, does seem that way. Will merge it in.

-- 
Regards,
Karthik Nayak
