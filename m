From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Sat, 26 Apr 2014 14:28:43 -0500
Message-ID: <535c08eb8105d_5310a7730895@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
 <5356996d12ede_3e5aed7308e5@nysa.notmuch>
 <85mwfc4hab.fsf@stephe-leake.org>
 <535782d95bbed_24448772ec7a@nysa.notmuch>
 <xmqqoazrwtsc.fsf@gitster.dls.corp.google.com>
 <535864bbc3a84_3c7abff3107b@nysa.notmuch>
 <7vfvl0htys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 21:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8RV-00067f-E2
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaDZTjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 15:39:17 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62651 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaDZTjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 15:39:15 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so5529032oag.26
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=J+Rx57US5vNI+kfQ7DGXcfHhtlPKYL4B0I14tLg+pWU=;
        b=OyTzp5OR2OoCZiUft0wKytoYT3OlcaTH/tcKxEnIHooXRUi5Yu96UAWuXSgJYkeH+y
         3FLYw/Is3t+595W5tbrfV+rZGrse8DX3ZFJPdDGwQTa/bSCTC3DWbFNJ4iJCbs/0Ch7B
         HC39qwUDNuWKlLv0xhhD8hcwPRfdjpD8psB4T6yiuXhWRfOgdOYMOI8ufz48Uw65j8w0
         qvojgfiHK7QljiH/ed60aLvbGfIyFefZ8E/LZSgoXirAisuasaVf6x24fYPFdF5W4C2x
         Iuhskei3O2iEButKRvjozgzxXM7kN6wMOtxoDSIEEWRtGgXiS8i89k77q5m34KSmi3E6
         1cBw==
X-Received: by 10.182.165.73 with SMTP id yw9mr12392216obb.39.1398541155191;
        Sat, 26 Apr 2014 12:39:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a7sm18699828obf.19.2014.04.26.12.39.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Apr 2014 12:39:13 -0700 (PDT)
In-Reply-To: <7vfvl0htys.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247178>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > So you grant that there is no reason anybody can think of why we would ever
> > want a post-update-branch?
> 
> No, it only shows that you (and I) are not imaginative enough
> (and/or we didn't bother spending enough brain cycles) to come up
> with an example.

That is the same thing; nobody can think of a reason.

> Your lack of imagination and foresight does not give you any right to close
> the door to those who come after you who have real needs, or make it awkward
> to add it later for them.

No, but rationality and evidence are the only things we can use to make
decisions, and there is no reason to think something is going to happen, I
don't see why any rational person would think that it would.

> > Let's make a bet, we go for 'pre-update-branch' and five years from now, if
> > there's no 'post-update-branch', you will publicly accept thta I was right.
> >
> > Deal?
> 
> Let me get this straight.  You spent a lot of effort to argue that
> naming it update-branch is the right thing, but now you want me to
> name it pre-update-branch, only so that you can prove you are right?

That is right.

It's impossible to convince you with logic and evidence, and even when you are
shown to be wrong, you don't accept it.

There is literally nothing anybody can do to convince you that imaginary fears
are just imaginary. At the end of the day your conclusion will be that the
improbable is still possible, well anything is possible, so saying "I don't see
how A could happen, but it's possible" is really not saying anything at all.

So yes, the only thing I can do is give up, however if you have any stakes in
progress of Git you would put your money where your mouth is.

If you had already done your job you should have some certainty on whether a
'post-update-branch' is going to happen or not. If you don't have such
certainty enough to make a bet, then why should anybody trust your conclusion?

> For the rest of us, making Git better is the primary reason why we are here.
> You seem to be saying that it is more important to you, however, to "win"
> your little argument, and you are willing to even sacrifice a better Git (in
> your mind, with the hook named as update-branch) in order to "win".

I can't make Git better if you don't humble yourself. You need to accept when
you are wrong.

If I say "A is not going to happen" and I provide evidence, but you say it
would, and indeed it doesn't happen, maybe when I say "B is not going to
happen", maybe you would actually listen, and if not, maybe when I say
"C is not going to happen" you would.

But if you are only willing to accept you were wrong when it's safe, then how
is anything going to change for the future.

> With a person with such screwed-up priorities, nobody whose first
> objective is to make Git better can have a sane conversation.

You are the one with the screwed priorities.

Time and time again the #1 issue people have raised about Git is the
user-interface. We even had Git user surveys to try to find out what people
wanted.

In these surveys the last thing people wanted was better performance, yet most
Git developers are still focusing on performance.

What people said needed improvement was the user-interface and documentation,
yet *nothing* has changed in these two areas. It's not a wonder no more surveys
are launched; because the results of such surveys are ignored anyway.

If a project has screwed-up priorities, it's when the areas of improvements
users say are needed get ignored.

> if you want another example, where you try to twist words by Peff and others
> and caught in doing so.

This is plainly intellectually dishonest. One year ago I made a summary of what
others said[1], I tried to keep it verbatim, CC'ed them, and invited them to
clarify if their position was misrepresented. Nobody, not even Jeff complained
about that.

Now, my mistake was thinking that "A is better" meant "we should go for A",
however, that wasn't the case for Jeff. I didn't twist any words, I made a
wrong assumption.

However, I bet most people in that list agree that "we should go for A", and if
you want, I can ask them all again (except Jeff, because we know his answer).
But I bet you are not interested in what they (or for that matter anyone) think
on the matter.

And you know it was an easy mistake to make, to accuse me of twisting words is
just dishonest.

> It could be that your "bet" is a way for you to finally admitting
> that naming the hook with "pre-" prefix will result in a better Git
> than without, without you having to say "Yes, you are right, let's
> change it" (which I rarely if ever saw you doing).  But still that
> shows the same screwed-up priorities---winning your little argument
> (or not losing it) matters more to you than working well with
> others.  I do not think I want to work with such a person.

That is not it at all.

How am I going to convince you of anything controversial in the future, if you
are never willing to admit that you were wrong, and pay a small public face
price?

The fact of the matter is that you don't want to be wrong, you don't want to be
shown to be wrong, and you don't want to accept you were wrong. Therefore you
reject any experiment in tha direction, and you ignore things like the user
survey that shows your priorities are wrong.

*This* is what hurts the project, not my "bet".

Now, if you had any certainty on what you are saying, you would say "Sure", win
the bet, and nothing bad would happen, users would have "pre-update-branch" and
"post-update-branch", and everybody would be happy (except me a little bit
because I was wrong). But the fact of the matter is that at some level you
already know there won't be any "post-update-branch", I guess that's why you
decided to attack me personally instead of dealing with your cognitive
dissonance and accept that fact.

[1] http://article.gmane.org/gmane.comp.version-control.git/233469

-- 
Felipe Contreras
