From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 15:13:24 +0200
Message-ID: <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com> <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org> <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org> <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
 <87egzwtthf.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 15:14:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkZ0R-0002lG-Km
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 15:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbaENNNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 09:13:55 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:57305 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaENNNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 09:13:55 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so2124641oag.16
        for <git@vger.kernel.org>; Wed, 14 May 2014 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xqFxi7ymg1ZFFUt7fR11z+11mvztVT8wspRdGdvM4xY=;
        b=pUtPWS+AQ6nWTfxuwyMhF5mxoKGuIYxYgCRaKzs0PGc4Bl41bA/jYYK+sCaLgWhjjM
         4SQOICjiqgyp9U5VwT60nayWM2QVsJ9srDsSEx7QDteEtH8jJNldSkfzRA+flSTohYlC
         xUmFnpTAsK5Y0ufG9zIUgjonwbpH4LkHk3rFpGo/3M1/rWaZ9NKwPh6ygXS+Y2OJt96p
         /gNyYP+orW/7fDgzd4CDhRsSJHQpBy7IA/V8OCpLf3iUEvhMt7Og1CLHOukjDLM9Mrvw
         JyU7PijYvW8nR5rHaXRjFuKaNVLC4rP7IpJUHEMsKwLFUeGrEYtHTIqmj4do6N0cHV4K
         ROYA==
X-Received: by 10.182.241.9 with SMTP id we9mr2233062obc.81.1400073234350;
 Wed, 14 May 2014 06:13:54 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 06:13:24 -0700 (PDT)
In-Reply-To: <87egzwtthf.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248915>

>> My point was more that it's very hard to produce high quality commits
>> without social interaction with others explaining what you missed,
>> stuffs you overlooked, etc.
>
> You are overgeneralizing.  You are assuming that it's easier for
> everybody to interact with humans rather than the Tao of Computing.

No, what I'm saying is that most non-trivial patches go through a
review process involving human interactions. It is very hard to
produce a very good non-trivial patch without going through human
interactions, just because someone might ask a question about your
patch. To be honest I'm not interested in fighting over this so let's
agree to disagree.


>> Anyway, I think we are speaking about different things. All I'm saying
>> is that humans are social creatures and that thinking you can
>> contribute to projects ran by humans without according a high
>> importance to social behaviors (like Felipe thinks) is not possible.
>
> You are assuming that "according a high importance to social behaviors"
> is all that it takes for anybody.  Do you tell the beggar on the next
> street corner that "according a high importance to earning millions"
> would be all that would be necessary for him to afford anything to drink
> that he'd like?

I'm sorry that my words aren't clear enough for you to infer the point
I'm trying to make. Let's try something simpler: what I was saying is
that bad behavior will get you into trouble when contributing (and
thus it's important to behave nicely), where Felipe usualy says bad
behavior is irrelevant because only truth/quality is important.


> And programming and social skills tend to be packaged separately.  So
> not everybody is gifted with being able to contribute _gracefully_.

Yes it's unfortunate. The amount of talent in our societies that is
wasted because of communication problems is probably quite high. I
didn't find a way around "being social" in any human based community
yet, but if you have an idea please share. The only way I can see
working is that for someone to act as a mediator between the grumpy
contributor and the community, but the role of this person is not very
pleasant. That or maybe have merges done by some kind of robot with
some AI about patch quality, but I doubt it is technically feasible
yet.

Philippe
