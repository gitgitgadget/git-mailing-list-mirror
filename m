From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 21:35:18 +0100
Message-ID: <CAMP44s3sBj0iYsCLUpiouUB8PXRwLORDEyD_+dWKrSsMP+TOaw@mail.gmail.com>
References: <20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
	<CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
	<20121113074720.GA18746@sigill.intra.peff.net>
	<CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
	<20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNCp-0003m1-4V
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab2KMUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:35:21 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51636 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab2KMUfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:35:19 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so660338obb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GM6K3+AIlmuq0N66WUwUos3GuNJoKCbdsZPuqtDKCXk=;
        b=gkqDIHcZOwy0Ww3HMJY4X/OUokIKo5xAvcf3Oz0MpUzd8PtKoOsMrMBmrtlFUvrp85
         oXg/HmLewZtTZ6feyCQCrl86AOhYQ4wBb+NAU9C5aRSIlHiUP77rbBW3segfbzYJJrFb
         7tJA0mVOS8rg75NFsQ64Elp9D69OTXFjUYEFn34HnlFrmH2YHJnV+OgTjWZeNeD2HdBV
         tv49Td/tCdLnu0OtqIfcKX+8rJYhJJfYpOlPlNkK4cNUNdxfxWUcBfsdzVBaOCb6VB+0
         kFtCEBInKmjyfjQ/d0t58/tvnOdXTLibgon9eTFWUyki9NHftE5acivx3y7ETK/2d2Xc
         xkmA==
Received: by 10.60.12.225 with SMTP id b1mr18601409oec.96.1352838918680; Tue,
 13 Nov 2012 12:35:18 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 13 Nov 2012 12:35:18 -0800 (PST)
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209670>

On Tue, Nov 13, 2012 at 5:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 10:06:26AM +0100, Felipe Contreras wrote:

>> I think you are the one that is not understanding what I'm saying. But
>> I don't think it matters.
>>
>> This is what I'm saying; the current situation with 'git commit' is
>> not OK, _both_ 'git commit' and 'git send-email' should change.
>
> Perhaps I am being dense, but this is the first time it became apparent
> to me that you are arguing for a change in "git commit".

Miscomunication then. When you mentioned 'it has always been the case
that you can use git without setting
user.*', I directed my comments at git in general, not git send-email.

>> Indeed I would, but there's other people that would benefit from this
>> patch. I'm sure I'm not the only person that doesn't have
>> sendmail.from configured, but does have user.name/user.email, and is
>> constantly typing enter.
>>
>> And the difference is that I'm _real_, the hypothetical user that
>> sends patches with GIT_AUTHOR_NAME/EMAIL is not. I would be convinced
>> otherwise if some evidence was presented that such a user is real
>> though.
>
> Sadly we cannot poll the configuration of every user, nor expect them
> all to pay attention to this discussion on the list. So we cannot take
> the absence of comment from such users as evidence that they do not
> exist.

And we cannot take it as evidence that these users do exist either.

The absence of evidence simply means that... we don't have evidence.

> Instead we must use our judgement about what is being changed,
> and we tend to err on the side of keeping the status quo, since that is
> what the silent majority is busy _not_ complaining about.

Yes, the keyword is *tend*; this wouldn't be first or the last time
that a behavior change happens.

We have to be careful about these changes, but we do them.

> We use the same judgement on the other side, too. Right now your
> evidence is "1 user wants this, 0 users do not".

1 is infinitely greater than 0.

> But we can guess that
> there are other people who would like the intent of your patch, but did
> not care enough or are not active enough on the list to write the patch
> themselves or comment on this thread.

Yes, that would be an educated guess. IMO the fact that people use
GIT_AUTHOR_ variables to send mail is not. There's many ways to
achieve that: sendemail.from, --from, user configuration, $EMAIL,
--compose and From:, etc. each and every one of them much more likely
to be used than GIT_AUTHOR_.

But I'm tired of arguing how extremely unlikely it is that such people
don't exist. Lets agree to disagree. Either way it doesn't matter,
because nobody is proposing a patch that would affect these
hypothetical users.

>> And to balance you need to *measure*, and that means taking into
>> consideration who actually uses the features, if there's any. And it
>> looks to me this is a feature nobody uses.
>
> You said "measure" and then "it looks to me like". What did you measure?
> Did you consider systematic bias in your measurement, like the fact that
> people who are using the feature have no reason to come on the list and
> announce it?

measure != scientific measurement.

I used common sense, because that's the only tool available.

GIT_AUTHOR is plumbing, not very well known, it's cumbersome (you need
to export two variables), it can be easily confused with
GIT_COMMITTER, which wouldn't work on this case. And there's plenty of
tools that much simpler to use, starting with 'git send-email --from',
which is so user friendly it's in the --help. There's absolutely no
reason why anybody would want to use GIT_AUTHOR.

But lets agree to disagree.

>> But listen closely to what you said:
>>
>> > I actually think it would make more sense to drop the prompt entirely and just die when the user has not given us a usable ident.
>>
>> Suppose somebody has a full name, and a fully qualified domain name,
>> and he can receive mails to it directly. Such a user would not need a
>> git configuration, and would not need $EMAIL, or anything.
>>
>> Currently 'git send-email' will throw 'Felipe Contreras
>> <felipec@felipec.org>' which would actually work, but is not explicit.
>>
>> You are suggesting to break that use-case. You are introducing a
>> regression. And this case is realistic, unlike the
>> GIT_AUTHOR_NAME/EMAIL. Isn't it?
>
> Yes, dying would be a regression, in that you would have to configure
> your name via the environment and re-run rather than type it at the
> prompt. You raise a good point that for people who _could_ take the
> implicit default, hitting "enter" is working fine now, and we would lose
> that.  I'd be fine with also just continuing to prompt in the implicit
> case.
>
> But that is a much smaller issue to me than having send-email fail to
> respect environment variables and silently use user.*, which is what
> started this whole discussion. And I agree it is worth considering as a
> regression we should avoid.

It might be smaller, I don't think so. A hypothetical user that was
relying on GIT_AUTHOR for whatever reason can switch to 'git
send-email --from' (which is much easier) when they notice the
failure, the same way somebody relying on fqdn would. The difference
is that people with fqdn do exist, and they might be relying on this.

Both are small issues, that I agree with.

But the point is that you seem to be very adamant about _my_
regressions, and not pay much attention about yours.

>> I prefer to concentrate on real issues, but that's just me.
>
> To be honest, I am confused at this point what you actually want. Do you
> think we should take your original patch?  I think its regression is too
> great. And I am not sure if you agree or not. You seem to be arguing
> that the regression is not important, yet you simultaneously argue that
> we should be making all ident more strict, which would mean that we
> should indeed take my suggestion and use "git var" instead of preferring
> the config.

No, I was proposing my second patch. That's why I sent a second patch.

But forget it. I don't think it's worth trying to do the right thing
here (make both 'git commit' and 'git send-email' be stricter). I do
think that would be simpler than all the required changes to var, and
better, but that's not my itch atm.

>> > As for whether they exist, what data do you have?
>>
>> What data do _you_ have?
>>
>> When there's no evidence either way, the rational response is to don't
>> believe. That's the default position.
>
> This is not religion. It is a software project.

This has absolutely nothing to with religion, this is rationality. If
you don't want to make a distinction between the different levels at
which we _know_ something, suit yourself.

> In the absence of data,
> the sane thing is not to break existing users.

What you decide to do has absolutely nothing to do with what is true.
These hypothetical users exist, or they don't. I don't have data for
their existence, you don't have data for their non-existence. In the
absence of data the rational response is to don't believe the claim,
and this one is particularly clear because you cannot prove a
negative, so the burden of proof is clearly on your side, as it's
*impossible* for me to prove that there are no users that use certain
feature, and it's very easy for you to do so, as all you need is
*one*.

Presumably you are not interested in fulfilling your burden of proof,
which is fine, you can choose the safest action without proof that
such users exist, but that doesn't change the fact that you don't know
that if they exist or not.

And yet, you continue to say they do exist, and try to win the
argument by means of rhetoric: 'not to break existing users'; they are
not *existing* users, they are hypothetical.

> The burden is on you to
> argue that there is no such breakage.

That's impossible to prove. *Nobody* can prove that people are not
using even the most obscure feature of git.

All you do is make educated guesses, and try to minimize the damage.

>> > Are you aware that the
>> > test suite, for example, relies on setting GIT_AUTHOR_NAME but not
>> > having any user.* config?
>>
>> What tests?  My patch doesn't seem to break anything there:
>> % make -C t t9001-send-email.sh
>> # passed all 96 test(s)
>
> My point was that there is at least one known setup that uses only
> environment variables and not a config file, and that the rest of git is
> intended to work with that.  It is not a test failure, but t9001.18
> reveals the fact that your change does not handle this situation; we
> continue to prompt under the test suite's configuration. In the proper
> fix, the test needs to be adjusted.
>
> You don't see any test failures with your patch because we do not cover
> the case that you regress (GIT_AUTHOR_EMAIL and user.email both set).

Exactly, but I was not the one that brought the test suite. My patch
is not a problem for our current tests. So this hypothetical user
remains evasive.

>> > When somebody comes on the list and asks why
>> > every git program in the entire system respects GIT_* environment
>> > variables as an override to user.* configuration _except_ for
>> > send-email, what should I say?
>>
>> The same thing you say when somebody comes reporting a bug: "yeah, we
>> should probably fix that".
>
> It is a larger hassle for both the developer and the user to fix the bug
> after the fact,

*If* that happens, which in all likelihood it won't.

> ship a new version, and then have the user upgrade their
> git. Why not just not introduce the bug in the first place?

Because we are spending more time arguing about something that most
likely won't happen.

There's a chance the next time you sit the chair will break because of
a bad leg, but you don't engage in philosophical discussions each time
you are going to sit, you go ahead and sit down, and take your
chances, and 99.9% of the time you would be fine.

>> It's all about proportion. Is it possible that we all are going to die
>> tomorrow because of an asteroid? Sure... but what's the point of
>> worrying about it if it's not likely?
>
> If you want to talk about risk assessment, then the right computation is
> to compare the cost of fixing it now versus the cost of fixing it later
> times the probability of it happening. The development cost is probably
> a little higher later (because we have to refresh ourselves on the
> issue), but the deployment cost is much higher (e.g., users whose
> distros ship a broken version, or who have IT policy that does not let
> them upgrade git as soon as the bug-fix ships).

Times 0.01 (at best), and you get barely nothing.

>> >> That's right, AUTHOR_IDENT would fall back to the default email and full name.
>> >
>> > Yeah, I find that somewhat questionable in the current behavior, and I'd
>> > consider it a bug. Typically we prefer the committer ident when given a
>> > choice (e.g., for writing reflog entries).
>>
>> Yeah, but clearly the intention of the code was to use the committer
>> if the author wasn't available, which is the case here.
>
> Yes. It would make sense to me to respect an explicit committer over an
> implicit author. Though the fact that author is preferred over committer
> is inconsistent with most of the rest of git. I'm undecided whether that
> should be changed.

Indeed. And that's something I won't worry about, because I honestly
believe nobody is using neither GIT_COMMITTER, nor GIT_AUTHOR, and the
fact that nobody has found this breakage only increases my certainty.

>> >> What about after my change?
>> >>
>> >> 6.1) GIT_AUTHOR without anything else
>> >>
>> >> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
>> >> var GIT_COMMITTER_IDENT: command returned error: 128
>> >
>> > Doesn't that seem like a regression? It used to work.
>>
>> No, this is *before* my change.
>>
>> I's the same bug as 5.1):
>
> Ah, I see. We are loading both, whether or not they end up being used,
> and barfing prematurely on errors. That seems like a bug.

Yes.

>> >> And what about your proposed change?
>> >
>> > Let me be clear that I sent you a "something like this" patch to try to
>> > point you in the right direction. If it has a bug or is incomplete, that
>> > does not mean the direction is wrong, but only that I did not spend very
>> > much time on the patch.
>>
>> It doesn't matter, the idea was to use user_ident_sufficiently_given().
>
> Right. Which it sounds like now agree with me on?

No. I tried the idea, it didn't work.

I saw your patches about
{committer,author}_ident_sufficiently_given(), those might work, but I
don't think they are _needed_. They might be nice though.

>> > I think that respecting the usual ident lookup but disallowing implicit
>> > identities (either totally, or causing them to fallback to prompting) is
>> > the right direction.  I agree my patch was not a complete solution. I'm
>> > sorry if it led you astray in terms of implementation, but I also think
>> > I've been very clear in my text about what the behavior should be.
>>
>> I think that is orthogonal to what I'm trying accomplish.
>
> What is it you are trying to accomplish? Eliminating the prompt in some
> cases, as in your original patch? Dealing with implicit identities may
> be orthogonal to your goal, but your original patch is not sufficient,
> as it reverses the precedence of config and environment variables.

No, it doesn't.

Why do you hold on to my first patch? The second patch doesn't have
this issue. It does change the behavior of 'git commit', yeah, but I
think that's a benefit.

You might disagree, but there's no point in going back to discuss the
first patch.

> So you can either:
>
>   1. Reimplement the environment variable lookup that ident.c does,
>      leaving implicit ident logic out completely.
>
>   2. Modify ident.c and "git var" to let send-email reuse the logic in
>      ident.c, but avoid dropping the prompt when an implicit ident is
>      used.
>
> Doing (2) sounds a lot more maintainable to me in the long run.

Or:

3. Change the meaning of the STRICT flag so that the values are
explicit, which has benefits outside 'git send-email'. Yes, this would
change the behavior in 'git commit' and other tools, but it's worth to
investigate these changes, and most likely they would be desirable.

Or:

4. Just stop prompting

I already sent a patch for 4. with all the details of why nobody (or
very few, if any) would be affected negatively.

>> > Don't get me wrong. I think the spirit of your patch is correct, and it
>> > helps some git users. But it also hurts others. And it is not that hard
>> > to do it right.
>>
>> And I disagree, I think it hurts nobody, and I think it's hard to do it right.
>
> I am tired of talking about this. The patch series below took me less
> time to write than I have spent arguing with you. It was not that hard.
>
>   [1/6]: ident: make user_ident_explicitly_given private
>   [2/6]: ident: keep separate "explicit" flags for author and committer
>   [3/6]: var: accept multiple variables on the command line
>   [4/6]: var: provide explicit/implicit ident information
>   [5/6]: Git.pm: teach "ident" to query explicitness
>   [6/6]: send-email: do not prompt for explicit repo ident

I think this adds a lot of code that nobody would use.

The prompt will happen only if:

1) No configured user.name/user.email
2) No specified $EMAIL
3) No configured sendemail.from
4) No specified --from argument
5) A fully qualified domain name
6) A full name in the geckos field

Very, very unlikely.

And if:

* A sendmail configuration doesn't allow sending from this domain name
* The user sees the problem in the confirmation part

Then the user would see a problem anyway, so the prompt is not adding
that much value.

>> Fixing a regression that nobody would notice is not my itch either,
>
> Sorry, but it is part of your itch. The git project is at state A. With
> your patch, we are at a regressed state B.

And that's fine.

> If you then fix it, we are at
> state C. From your perspective, it may be "I do not want to make the fix
> to go from B to C". But from the project's perspective, it is "we do not
> want to go from state A to state B; state C would be acceptable". So
> from the perspective of people who do not care about your feature but do
> care about the regression in state B, it is inextricably linked to your
> itch.

No it's not. It's a conflict of interests. It's only linked as long as
people care about the "regression" in state B. If they realize this
"regression" is irrelevant, then there wouldn't be any problem. This,
is now clear is not going to happen. But I don't think your opinions
define whether or not I have an itch.

>> yet the patch I sent above does it, and it even fixes 'git commit'
>> (IMO). But it's also not good enough.
>
> I do not necessarily agree on "git commit". Moreover, I feel like it is
> a separate issue. My series above _just_ implements the "do not prompt
> when explicit" behavior. It does not deal with git-commit at all, nor
> does it address the author/committer fallback questions. Those can
> easily go on top.

Yes, at the cost of adding a lot of code. If we end up agreeing that
the changes to 'git commit' are desirable (which I hope at some point
we will), then this code would be all for nothing.

I sent another patch series that is very simple[1]. This deals with
the hypothetical GIT_AUTHOR users, but might hit another set of
hypothetical users, but the damage would be very small, and the
possibility of these users existing very low. IOW; very low risk.

I want clarify that this is merely a disagreement to at which level
should we worry about regressions. On one side of the spectrum you
have projects like GNOME, who don't have any problem breaking the
user-experience from one release to the next, I'm not proposing
anything like that. On the other side I think it's you, because I
don't recall encountering anybody with such an extreme position of
never introducing a regression ever if there's absolutely no evidence
that anybody is using certain feature. That's fine, it's your opinion,
I respectfully disagree. Personally, I think the sweet spot is between
the two, far from GNOME, but not quite to the point where no
regressions happen ever. When there's a good chance that very few
people will be hit, and the drawback is small, then it's OK to
introduce regressions. Always keeping in mind that these risk
assessments might be wrong, and there might be more people hit than
expected and/or the problems were greater, but if/when that happens,
*then* we simply deal with it.

Cheers.

[1] http://mid.gmane.org/1352834364-2674-1-git-send-email-felipe.contreras@gmail.com

-- 
Felipe Contreras
