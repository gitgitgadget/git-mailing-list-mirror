From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 10:06:26 +0100
Message-ID: <CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
	<CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
	<20121113074720.GA18746@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 10:06:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYCSF-00067P-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 10:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab2KMJGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 04:06:32 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54008 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab2KMJG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 04:06:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7158490obb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jXW6xHgEgGkg0R4BXaz6ePZMuTEikv5EcUvZdgwZDh8=;
        b=LLLfGIi6ibHrINJCIc4GNisej2yyqO1Ogs9Baf+vZFmaD0KWObXBXSYT7PTgtKE/Tb
         BgHnlJ5oAxiOKsPVTbYmliC3MXslUmFoQt1pZ64Sr5i56e2NJSFYJwckbGCdnoiEn7V0
         s2LgDs1oZpuuW5iBM7sBx2XbLEQ1PNlT6bvfVPgReFi6fbQr2mmFmHEsKNHgIkH57l0o
         yktdlEc481YVATO473348r2g+Fyk92XPu2EqUfyHWKj2lAboOzFCROOGSVkez1O9R8+N
         sgTQ4aq9MXlVhTilWTwmOenZW4X/mtcIwBh2i2Wcx9EyMh8vhHSZt6apoHNQQk4r6JZ7
         f7iw==
Received: by 10.182.116.6 with SMTP id js6mr17225189obb.82.1352797586414; Tue,
 13 Nov 2012 01:06:26 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 13 Nov 2012 01:06:26 -0800 (PST)
In-Reply-To: <20121113074720.GA18746@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209590>

On Tue, Nov 13, 2012 at 8:47 AM, Jeff King <peff@peff.net> wrote:

> But I still don't see how that has anything to do with what send-email
> does or should do. That is why I said "strawman" above. You seem to
> think I am saying that send-email should use the system that generated
> those broken names, when I am saying the opposite.

No, I'm saying none should use that system, and that in fact 'git
commit' should be stricter... both should be stricter.

> Those people would also not be using a new version of git-send-email,
> and it will always prompt. I thought we were talking about what
> send-email should do in future versions. Namely, loosening that safety
> valve (the prompt) because it is inconvenient, but tightening the checks
> so that losing the safety valve is not a problem.

Yeah, but all I'm saying is that the issue happens, you seemed to
suggest that it doesn't.

>> I'm not talking about git send-email, I'm talking about your comment
>> 'it has always been the case that you can use git without setting
>> user.*', which has caused issues with wrong author/commmitter names in
>> commits, and will probably continue to do so.
>
> The second half of that sentence that you quoted above is "...instead
> only using the environment." As in, environment variables like
> GIT_AUTHOR_EMAIL, GIT_COMMITTER_EMAIL, and EMAIL. _Not_ implicit
> generation of the email from the username and hostname.

That sentence was *not* about 'git send-email', it was about git in
general, and 'git commit' is perfectly happy with implicit generation
of the email from the username and hostname.

I don't thin 'git commit' should do that, and I don't think 'git
send-email' should do that. I'm criticizing the whole approach.

> I am tempted to fault myself for not communicating well, but I feel like
> I have made that point at least 3 times in this conversation now. Is
> that the source of the confusion?

I think you are the one that is not understanding what I'm saying. But
I don't think it matters.

This is what I'm saying; the current situation with 'git commit' is
not OK, _both_ 'git commit' and 'git send-email' should change.

> And you will survive if upstream git (whether it is me today or Junio
> tomorrow) does not pick up your patch.

Indeed I would, but there's other people that would benefit from this
patch. I'm sure I'm not the only person that doesn't have
sendmail.from configured, but does have user.name/user.email, and is
constantly typing enter.

And the difference is that I'm _real_, the hypothetical user that
sends patches with GIT_AUTHOR_NAME/EMAIL is not. I would be convinced
otherwise if some evidence was presented that such a user is real
though.

> I remember writing you a long
> email recently about how one of the responsibilities of the maintainer
> is to balance features versus regressions. I'll not bother repeating
> myself here.

And to balance you need to *measure*, and that means taking into
consideration who actually uses the features, if there's any. And it
looks to me this is a feature nobody uses.

But listen closely to what you said:

> I actually think it would make more sense to drop the prompt entirely and just die when the user has not given us a usable ident.

Suppose somebody has a full name, and a fully qualified domain name,
and he can receive mails to it directly. Such a user would not need a
git configuration, and would not need $EMAIL, or anything.

Currently 'git send-email' will throw 'Felipe Contreras
<felipec@felipec.org>' which would actually work, but is not explicit.

You are suggesting to break that use-case. You are introducing a
regression. And this case is realistic, unlike the
GIT_AUTHOR_NAME/EMAIL. Isn't it?

I prefer to concentrate on real issues, but that's just me.

> As for whether they exist, what data do you have?

What data do _you_ have?

When there's no evidence either way, the rational response is to don't
believe. That's the default position.

> Are you aware that the
> test suite, for example, relies on setting GIT_AUTHOR_NAME but not
> having any user.* config?

What tests?  My patch doesn't seem to break anything there:
% make -C t t9001-send-email.sh
# passed all 96 test(s)

> When somebody comes on the list and asks why
> every git program in the entire system respects GIT_* environment
> variables as an override to user.* configuration _except_ for
> send-email, what should I say?

The same thing you say when somebody comes reporting a bug: "yeah, we
should probably fix that".

But that's not going to happen. And in the unlikely event that it
does, it's not going to be a major issue.

It's all about proportion. Is it possible that we all are going to die
tomorrow because of an asteroid? Sure... but what's the point of
worrying about it if it's not likely?

>> But let's look at the current situation closely:
>>
>> PERL5LIB=~/dev/git/perl ./git-send-email.perl --confirm=always -1
>>
>> 1) No information at all
>>
>> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
>
> That is dependent on your system. If you have a non-empty name in your
> GECOS field, and if your machine has a FQDN, it will currently work (and
> prompt).

Yes, that's point 2).

>> 2) Full Name + full hostname
>>
>> Who should the emails appear to be from? [Felipe Contreras
>> <felipec@nysa.felipec.org>]
>>
>> That's right, ident doesn't fail, and that's not the mail address I
>> specified, it's *implicit*.
>
> Right. I never said it did. I said it currently rejected obviously bogus
> stuff (like the ".(none)" above) due to IDENT_STRICT, but currently
> allowed implicit definitions. And I also said that if we get rid of the
> prompt, we should disallow implicit definitions like this, because the
> prompt is the safety valve on sending out mails with broken from
> addresses. I even wrote a patch that let you find out whether the ident
> was generated implicitly.

Correct.

>> 3) Full Name + EMAIL
>>
>> Who should the emails appear to be from? [Felipe Contreras
>> <felipe.contreras@gmail.com>]
>
> Which sounds fine to me. EMAIL is considered explicit, and I have not
> seen any evidence that people are putting bogus values in their EMAIL
> variable and complaining that it is git's fault for respecting it.

Agreed.

>> 5) GIT_COMMITTER
>>
>> Who should the emails appear to be from? [Felipe Contreras 2nd
>> <felipe.contreras+2@gmail.com>]
>>
>> Whoa, what happened there?
>>
>> Well:
>>
>>   $sender = $repoauthor || $repocommitter || '';
>>   ($repoauthor) = Git::ident_person(@repo, 'author');
>>   % ./git var GIT_AUTHOR_IDENT
>>   Felipe Contreras 2nd <felipe.contreras+2@gmail.com> 1352783223 +0100
>>
>> That's right, AUTHOR_IDENT would fall back to the default email and full name.
>
> Yeah, I find that somewhat questionable in the current behavior, and I'd
> consider it a bug. Typically we prefer the committer ident when given a
> choice (e.g., for writing reflog entries).

Yeah, but clearly the intention of the code was to use the committer
if the author wasn't available, which is the case here.

>> 5.1) GIT_COMMITER without anything else
>>
>> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
>> var GIT_AUTHOR_IDENT: command returned error: 128
>
> Right. Same bug as above.

No, this is a different bug.

The bug above 5) is here:

$sender = $repoauthor || $repocommitter || '';

$repoauthor will always evaluate to true.

This one 5.1) is there:

($repoauthor) = Git::ident_person(@repo, 'author');
($repocommitter) = Git::ident_person(@repo, 'committer'); <-

>> So $repoauthor || $repocommiter is pointless.
>
> Agreed.

Good.

>> 6) GIT_AUTHOR
>>
>> Who should the emails appear to be from? [Felipe Contreras 4th
>> <felipe.contreras+4@gmail.com>]
>
> Right, that's what I'd expect.

You mean without the input question?

>> What about after my change?
>>
>> 6.1) GIT_AUTHOR without anything else
>>
>> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
>> var GIT_COMMITTER_IDENT: command returned error: 128
>
> Doesn't that seem like a regression? It used to work.

No, this is *before* my change.

I's the same bug as 5.1):

($repoauthor) = Git::ident_person(@repo, 'author'); <- here
($repocommitter) = Git::ident_person(@repo, 'committer');

>> 4) config user
>>
>> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>
>
> OK.
>
>> 5) GIT_COMMITTER
>>
>> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>
>
> OK.
>
>> 6) GIT_AUTHOR
>>
>> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>
>
> Doesn't that seem like a regression? It used to use a different address,
> and in every other git program, the environment takes precedence over
> config.

Yes, it is a regression (that won't affect anybody).

>> And what about your proposed change?
>
> Let me be clear that I sent you a "something like this" patch to try to
> point you in the right direction. If it has a bug or is incomplete, that
> does not mean the direction is wrong, but only that I did not spend very
> much time on the patch.

It doesn't matter, the idea was to use user_ident_sufficiently_given().

>> 6.1) GIT_AUTHOR without anything else
>>
>> Even if the previous problem was solved:
>>
>> export GIT_AUTHOR_NAME='Felipe Contreras 4th'; export
>> GIT_AUTHOR_EMAIL='felipe.contreras+4@gmail.com'
>> ./git var GIT_EXPLICIT_IDENT
>> 0
>>
>> No explicit ident? This is most certainly not what the user would expect.
>
> Yes, it looks like we do not set up the explicit ident flags when
> parsing the author. So my patch is insufficient.

Indeed.

>> 5.2) GIT_COMMITTER with Full Name and full hostname
>>
>> export GIT_COMMITTER_NAME='Felipe Contreras 3nd'; export
>> GIT_COMMITTER_EMAIL='felipe.contreras+3@gmail.com'
>> ./git var GIT_EXPLICIT_IDENT
>> 1
>>
>> From: Felipe Contreras <felipec@nysa.felipec.org>
>>
>> It is explicit, yeah, but 'git send-email' would not be picking the
>> committer, it would pick the author.
>
> Yep.
>
> The explicitness needs to be tied to the specific ident we grabbed.
> Probably adding a "git var GIT_AUTHOR_EXPLICIT" would be enough, or
> alternatively, adding a flag to "git var" to error out rather than
> return a non-explicit ident (this may need to adjust the error
> handling of the "git var" calls from send-email).

I think strictess should be tied to explicitness, and 'git var' should
error out, and not die.

>> > I tried to help you by pointing you in the right direction and even
>> > providing a sample "git var" patch.
>>
>> Are you 100% sure that was the right direction?
>
> I think that respecting the usual ident lookup but disallowing implicit
> identities (either totally, or causing them to fallback to prompting) is
> the right direction.  I agree my patch was not a complete solution. I'm
> sorry if it led you astray in terms of implementation, but I also think
> I've been very clear in my text about what the behavior should be.

I think that is orthogonal to what I'm trying accomplish.

>> I think the right approach is more along these lines:
>
> I think that is moving in the right direction, but...
>
>> --- a/ident.c
>> +++ b/ident.c
>> @@ -291,9 +291,9 @@ const char *fmt_ident(const char *name, const char *email,
>>         }
>>
>>         if (strict && email == git_default_email.buf &&
>> -           strstr(email, "(none)")) {
>> +               !(user_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
>>                 fputs(env_hint, stderr);
>> -               die("unable to auto-detect email address (got '%s')", email);
>> +               die("no explicit email address");
>
> I think this needs to be optional, otherwise you are breaking callers
> who use IDENT_STRICT but are OK with the implicit ident (e.g.,
> commit, format-patch with threading).
>
> You can argue whether "git commit" should disallow such addresses, but
> that is a separate topic from how send-email should behave.

Yes, that's exactly what I would argue.

>> Not only will this fix 'git send-email', but it will also fix 'git
>> commit' so that we don't end up with authors such as 'Felipe Contreras
>> <felipec@nysa.felipec.org>' ever again.
>
> While simultaneously breaking "git commit" for people who are happily
> using the implicit generation. I can see the appeal of doing so; I was
> tempted to suggest it when I cleaned up IDENT_STRICT a few months back.
> But do we have any data on how many people are currently using that
> feature that would be annoyed by it?

No, but it can also be considered a bug... do we have any data on how
many people are being affected by this? If the '(none)' commits are
any indication of it, probably a lot. At least the ones that do have a
fqdn.

>> > But it is not my itch to scratch.
>>
>> Suit yourself, it's only git users that would get hurt. I can always
>> use my own 'git send-email' (as I am doing right now).
>
> Don't get me wrong. I think the spirit of your patch is correct, and it
> helps some git users. But it also hurts others. And it is not that hard
> to do it right.

And I disagree, I think it hurts nobody, and I think it's hard to do it right.

> It may be something I would work on myself in the future, but I have
> other things to work on at the moment, and since you are interested in
> the topic, I thought you would be a good candidate to polish it enough
> to be suitable upstream. But instead I see a lot of push-back on what I
> considered to be a fairly straightforward technical comment on a
> regression.

I'm just trying to be pragmatic. I don't see the point in wasting my
time for people that don't exist. As I said, I don't think anybody
would be hit by this.

> And now I have wasted a large chunk of the evening responding to you,
> neither accomplishing my other tasks nor polishing this topic. I do not
> mind reviewing patches or responding to discussions, nor do I consider
> them time wasted; they are an important part of the development process.
> But I feel like I am fighting an uphill battle just to convince you that
> regressions are bad, and that I am having to make the same points
> repeatedly.  That makes me frustrated and less excited about reviewing
> your patches; and when I say "it is not my itch", that is my most polite
> way of saying "If that is going to be your attitude, then I do not feel
> like dealing with you anymore on this topic".

Fixing a regression that nobody would notice is not my itch either,
yet the patch I sent above does it, and it even fixes 'git commit'
(IMO). But it's also not good enough.

I scratched my itch with the original patch, anything after that is to
help other people.

I think it would be much easier to just remove the question input. The
only "regression" would be the people that have a fqdn and full name
_and_ expect the question. But Junio suggested to just die in those
cases, and trying to send an email that would probably fail is not
that different.

Fixing all the var and ident infrastructure seems way, *way* far from
what I intended to do.

Cheers.

-- 
Felipe Contreras
