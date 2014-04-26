From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Sat, 26 Apr 2014 10:38:19 -0700
Message-ID: <7vfvl0htys.fsf@alter.siamese.dyndns.org>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com> <53558f6269f91_640076f2f08f@nysa.notmuch>
	<857g6h5ssh.fsf@stephe-leake.org>
	<5356996d12ede_3e5aed7308e5@nysa.notmuch>
	<85mwfc4hab.fsf@stephe-leake.org>
	<535782d95bbed_24448772ec7a@nysa.notmuch>
	<xmqqoazrwtsc.fsf@gitster.dls.corp.google.com>
	<535864bbc3a84_3c7abff3107b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6Wo-00009H-Fb
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaDZRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:36:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbaDZRgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:36:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F6C779E1D;
	Sat, 26 Apr 2014 13:36:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=x5v34dyLDLMIYSfsbl6iA9ykzm8=; b=WHzoJzPI5oiCV7RKvt38
	mPWjmt+kfTt3HVyUy3Spzw4CFkwVQ2Rnw89EZsh3OuOPO9rP74LNRW795hLRU19M
	01jZInQKoIA8sl2k5UH5ChQzNw2ttgK3T8IGyA59qGshFuerBfP5IpJ6KEt6ZGyv
	beMh9MsnsCFO2dHErJXmOk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=D8NwWWzqqBAGZQ5B8XGeBv5KHF3f5JnXneB1NoBZYvEqXR
	/EYdEkTQF4O44b5gZj60jPHl3p/P846U2WbQV0Tlmg1EFyrVZ4FRPUibL94mWqw/
	Y1bCedjP2XDd7UBN6qvY5TxDBVoEyzC8FOfZFEpKWIAA8/uGQMUexoGhj5ME4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3069F79E1B;
	Sat, 26 Apr 2014 13:36:35 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25F2D79E19;
	Sat, 26 Apr 2014 13:36:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 4F019C88-CD69-11E3-8E5A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247168>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So you grant that there is no reason anybody can think of why we would ever
> want a post-update-branch?

No, it only shows that you (and I) are not imaginative enough
(and/or we didn't bother spending enough brain cycles) to come up
with an example.  Your lack of imagination and foresight does not
give you any right to close the door to those who come after you who
have real needs, or make it awkward to add it later for them.

> Let's make a bet, we go for 'pre-update-branch' and five years from now, if
> there's no 'post-update-branch', you will publicly accept thta I was right.
>
> Deal?

Let me get this straight.  You spent a lot of effort to argue that
naming it update-branch is the right thing, but now you want me to
name it pre-update-branch, only so that you can prove you are right?

Playing a silly bet among friends may be fun from time to time.  But
I do not like using Git as a plaything, I am not your friend, and I
never felt it fun having to interact with you.  I am not interested
in proving you right or wrong.  You are not that interesting.

What you said however shows clearly the reason why it is not fun to
work with you, and I think that is a lot more important point.  Your
priorities are screwed up.  For the rest of us, making Git better is
the primary reason why we are here.  You seem to be saying that it
is more important to you, however, to "win" your little argument,
and you are willing to even sacrifice a better Git (in your mind,
with the hook named as update-branch) in order to "win".

With a person with such screwed-up priorities, nobody whose first
objective is to make Git better can have a sane conversation.  Ask
those who said they do not want to work with you.  In the list
archive, there are plenty of examples to choose from, and I think
they will agree with me.

It is a pity that in all of these long flamefest, you may have meant
well to improve Git when you brought up something that needs to be
solved in your first few messages.  The rest of us may even have
agreed that it is good to address that issue on many of them.  But
the time "something needs to be done" and "the way Felipe proposes
to solve it is good" turns out to be different, i.e. when those who
agree with the former do not agree with the latter, the discussions
with you go downhill quick.  Each and every time.  See your "index
is hard to learn for people---can we do something?" topic, if you
want another example, where you try to twist words by Peff and
others and caught in doing so.

Now, I know you are going to say "that is what *you* think, and even
if they agree, that is only what *they* think. it is not true! my
priorities are right and they are wrong!".

I'd freely give you that they are only *impressions* we have on you,
that we were forced to form by observing your past and present
behaviours.  It may not be "true you".  You may be a loving an
wonderful person in reality, and you are not showing your true self
when you are on this list.  But you know something?  The project
advances by humans working together, and without telepathy, these
impression are the only thing we humans can go by.

I also know that you are going to say "that is what *you* think".  I
have nothing more to say to you at that point.

It could be that your "bet" is a way for you to finally admitting
that naming the hook with "pre-" prefix will result in a better Git
than without, without you having to say "Yes, you are right, let's
change it" (which I rarely if ever saw you doing).  But still that
shows the same screwed-up priorities---winning your little argument
(or not losing it) matters more to you than working well with
others.  I do not think I want to work with such a person.
