From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Fri, 22 Jan 2016 10:51:09 -0800
Message-ID: <CAGZ79kYOQ1sphdozTXGf+Q2n=kNpmGx1pvzLD5SHBqfhWDBA3Q@mail.gmail.com>
References: <20151216032639.GA1901@LykOS>
	<20151218231032.GA16904@thunk.org>
	<20151219173018.GA1178@LykOS>
	<20151220012835.GA3013@thunk.org>
	<20160112182137.GE27334@LykOS>
	<CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
	<20160114171639.GB25541@LykOS>
	<CAGZ79ka51e+-24RyMgUGAOUkBYXxnWZb8Pg7vrgjGHvvWU770Q@mail.gmail.com>
	<20160122180007.GB28871@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:51:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgnj-0002Zu-MK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbcAVSvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:51:11 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34678 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcAVSvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:51:10 -0500
Received: by mail-io0-f171.google.com with SMTP id 1so97222345ion.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IH2xAdKH4twZoccAKEXkY1mOM5h2SkxNbKG9vTXViao=;
        b=ZZmLWRzmrdc6zVyd8Pg8wouTiPqPOVas9nURGhmt3o8mDZolwG2wZUfGqroCo14btr
         UpCyLWAybpxKmhJ7esW1tkMPLRAnAoqbdeGzdx6FLOPgAT14U3y9fiKAFWdEfJ3kiizz
         r6/B7LVWNElpWq/4A5YjuiskYSZNxqOfGJya5BqgZHGaw0U7UDt8xof/sIA0/RhQ9VlT
         6E80HWwAefQGzbxczgVQnGyNvq0VOwv8qL64wvQvsgUBFagtpUE5eBvVFSG+Lr3k30hS
         m0XCfanhrY8vwaIZ8V0h5xDmnE2BBmmQqPbWXxIwHmVn7+M+F3oWt7iP64wqEZ2qjpJ/
         xM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IH2xAdKH4twZoccAKEXkY1mOM5h2SkxNbKG9vTXViao=;
        b=RsJLXJ0MehBeZ9kghJ/sRK98m7lXt6IZwTKf9V03PeAkuxqCMoeECxmsohXXlDCybX
         lvB16IP79Cp70/yLwGz/+Qs6h8cetXGxVJPpKcYO/cnXSXlTFCXdIXyR4gQqOK7or4+9
         cLas22D60OaPVUk69AmxWK8WFbtY4wpCLhhJ/KiCgmG5EdZTkRyNp406Nc8hRZyQxaai
         bCGhjH3u74+HYGx65/dLmbWf48SJlFL98pw5cMVjW0ZQVIo7QbnkHnGiksJ8AlO04rlE
         +4KMFJQUDqKp/laBDYA75AeC/CkX0Ux0GlatyUwVNebuYR1QEJQ9KzvZu4vZEJ2B392x
         1W3Q==
X-Gm-Message-State: AG10YOR1+BWz2eRIdo/efebfJfnEHEdnOkXMxEgmIu3HKYey58EkeUxcr+aGoOXOkpPIisfpVbXal+Q5JaJaMGix
X-Received: by 10.107.168.203 with SMTP id e72mr5021220ioj.96.1453488669780;
 Fri, 22 Jan 2016 10:51:09 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 22 Jan 2016 10:51:09 -0800 (PST)
In-Reply-To: <20160122180007.GB28871@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284581>

On Fri, Jan 22, 2016 at 10:00 AM, Santiago Torres <santiago@nyu.edu> wrote:
> On Thu, Jan 14, 2016 at 09:21:28AM -0800, Stefan Beller wrote:
>> On Thu, Jan 14, 2016 at 9:16 AM, Santiago Torres <santiago@nyu.edu> wrote:
>> > Hello Stefan, thanks for your feedback again.
>> >
>> >> This is what push certs ought to solve already?
>> >
>> > Yes, they aim to solve the same issue. Unfortunately, push certificates
>> > don't solve all posible scenarios of metadata manipulation (e.g., a
>> > malicious server changing branch pointers to trick a user into merging
>> > unwanted changes).
>> >
>> >> AFAIU the main issue with untrustworthy servers is holding back the latest push.
>> >> As Ted said, usually there is problem in the code and then the fix is pushed,
>> >> but the malicious server would not advertise the update, but deliver the old
>> >> unfixed version.
>> >>
>> >> This attack cannot be mitigated by having either a side channel (email
>> >> announcements)
>> >> or time outs (state is only good if push cert is newer than <amount of
>> >> time>, but this may
>> >> require empty pushes)
>> >>
>> >
>> > I'm sorry, did you mean to say "can"?
>>
>> Yes, formulating that sentence took a while and I did not proofread it.
>
> Sorry, Stefan. I didn't mean to come off as rude; I just wanted to make
> sure I understood correctly what you were proposing.

Not at all, I just made a typo. :)

>
> Do you have any further insight? I think that, besides the supporting
> multiple workflows, maybe synchronizing concurrent fetches might be an
> issue to our solution.

I did not think further about any issues there.

Thanks,
Stefan

>
> Thanks a lot!
> -Santiago.
