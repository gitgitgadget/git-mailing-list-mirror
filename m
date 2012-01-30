From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 13:55:33 +0200
Message-ID: <CAMP44s3a05dZqOqpDFDnWQ_C03EODgeP1eRhko-Mc8OjGXj6FQ@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
	<CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
	<7vd3a1erwf.fsf@alter.siamese.dyndns.org>
	<CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
	<CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:55:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrppl-0004d7-3q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab2A3Lzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:55:36 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49808 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752477Ab2A3Lzf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 06:55:35 -0500
Received: by lagu2 with SMTP id u2so2136999lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fl3eDr6g34xqiEmtiXSnYIGVej+ElFZJMJV+vI6+xXE=;
        b=HP6VXryx8RYnXDUQC3SC0TO0mdZX5SLETsxpZwFkYGga+JXfhYp6CPqRnRxaYBqzHF
         ruNuxifgZlwQXmtKsqiM9LHnmnwh6Af9R6XgWW1otGKhZpFM5qCuFW3Icj+32cySR0+k
         5fOrvuwJzhBdOGtHm67OuWxiiRHw98fURa3fs=
Received: by 10.112.82.226 with SMTP id l2mr4463267lby.102.1327924533852; Mon,
 30 Jan 2012 03:55:33 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 03:55:33 -0800 (PST)
In-Reply-To: <CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189354>

On Mon, Jan 30, 2012 at 1:19 PM, Frans Klaver <fransklaver@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 11:51 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Jan 30, 2012 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> OK, maybe some people use it, but most likely they are using an old
>>>> version of git, and thus an old version of the completion script.
>>>
>>> Please adjust your attitude about backward compatibility to match the
>>> standard used for other parts of Git.
>>
>> What attitude?
>
> This attitude:
>
>> I am simply stating a fact. How much percentage of
>> people do you think still have .git/remotes around? How many people do
>> you think have clones more than 3 years old? And how many of these
>> people would complain if remotes were not properly completed for these
>> repos?
>>
>> I doubt anybody would have complained, but I guess we would never
>> know, because I already proposed a solution that would work for them
>> and only uses a *single* line of code, unlike the current 40 ones.
>>
>> I don't see what is the problem with the attitude of sending a patch
>> to remove code that most likely nobody cares about (neither you or I
>> have numbers on this), and then finding an alternative when people do
>> care about it.
>
> I don't think Junio actually meant an "attitude", but just your angle
> of approach (== attitude) on backwards compatibility.

We are not talking about backwards compatibility; we are talking about
compatibility of remotes completion of the bash completion script of
repositories more than 3 years old with remotes that haven't been
migrated.

This barely resembles the git-foo -> 'git foo', which truly broke
backwards compatibility, and at the time I proposed many different
approaches to deal with these type of problems, which seem to be
followed now (although probably not because of my recommendations).

But this has nothing to do with _attitude_; I am merely stating fact.
I have never expressed any opinion or attitude with respect to how
backwards compatibility should be handled in this thread, have I?

> Maybe numbers for this could be generated from the next git user
> survey. If numbers justify this change, maybe this or something like
> it could be scheduled for a major release of git.

Maybe, but I doubt this issue hardly deserves much discussion.

Nobody is proposing to break backwards compatibility--as you can see,
I already proposed a simple solution that should work.

And FTR, when I wrote 'We don't need to check for GIT_DIR/remotes,
right? This was removed long time ago." I clearly wasn't sure if
.git/remotes was still used or not, after Jonathan Nieder replied, I
checked the source code of remotes.c, and I found that it was still
supported, so I wrote the proposed alternative.

-- 
Felipe Contreras
