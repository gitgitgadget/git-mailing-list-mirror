From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 14:26:27 +0530
Message-ID: <CALkWK0mWA_aWuWYYV8O5QKUMB_GWXRKB1X_TGuoG-ESgN5fjOg@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B5D9A1.1080900@ensimag.fr> <vpqhah6hxjm.fsf@anie.imag.fr>
 <robbat2-20130610T162316-152176477Z@orbis-terrarum.net> <7vzjuxj21b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 10:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmKOA-0006v3-JF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 10:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab3FKI5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 04:57:09 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:51316 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab3FKI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 04:57:07 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so19503956iea.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dKUeJ1WQLALjFtQtQqX1vuy5tq8MpdOU8UK1bXrw3HY=;
        b=dR+FevoeLCjyL2BWy2Uw89vQuBi8rrqTrRo7S7cZVFhWFyVMH1k7S4Ks8mOStBRzkh
         bx/DpOpwz80fiX+EhcTXVXS6hNtKZMg4ha5jU8kzTPzeM7oOt3Bl0cJtwkQ3x4Vc9ikD
         o4zuT+/4e4cdakj4JMl0azWlu++rQ3QFsRiHbGozRKIZDdO9ZsRcxr0jHU47kLOjmda6
         HaKp5VH5pY0Z8Fy8m6WIaD0iDYPpbSy0nWSbY56X1HyTc+GSGaACnLHLsL8cesUZemfF
         PQ2gGN8D8tfMosAyhRCQrlNhPnEUBo2LHb6CmFcRW0al4imy6sQwYa1FH4Gxumo1Lx1z
         7p8w==
X-Received: by 10.42.73.138 with SMTP id s10mr965543icj.10.1370941027363; Tue,
 11 Jun 2013 01:57:07 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 11 Jun 2013 01:56:27 -0700 (PDT)
In-Reply-To: <7vzjuxj21b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227424>

Junio C Hamano wrote:
> The intent behind the document might be a noble one, but I am afraid
> that the text is too broad and vague and does not address the real
> issue to be of practical use.

Drafting something like this is shit work, which explains why nobody
has attempted it yet.  I have no intent of collecting feedback and
doing iterations: it's going to be an extraordinarily hard and boring
task; _much_ worse than any technical documentation.

Let me be clear that I have no hopes of landing this "patch": I just
wanted to create a calm and rational atmosphere for people to discuss
the problem, in the hopes of minimizing the chances of large frequent
fires.  If you think we should put _something_ in our tree, I suggest
dumping a few raw emails from this thread into
contrib/CommunityGuidelines/ (or something).

> Taking one bullet point from the top for example:
>
>     0. You do not take offense, no matter what.  If someone attacks
>     you irrationally, you do not respond.  This is a public mailing
>     list, and we are all rational people: the attacker has already
>     humiliated herself in public, and everyone can see that.
>
> What does saying "we are all rational people" help when "the
> attacker" poses a risk to destroy the community?  What does "we are
> all rational people" even mean in this sentence?

I intended it as a way to reassure everyone that we will make
unbiased, rational judgements to the extent possible.

> It does not address the real cause of flamewars---why do rational
> people feel the need to respond when an irrational comment is made,
> e.g. when a reasonable review comments were responded not with
> either "Yeah, you are right, thanks." or "Not really, because you
> missed this case, I think..."  but with nitpicks with immaterial
> details or repetition without justification that takes account that
> the reviewer is in disagreement and there must be some reason behind
> it, i.e. a poisonous behaviour?

There is no great truth about some hidden "real cause" to be found.
For instance, in the one we just had, I would argue that it "started"
with your non-patch "administriva" email with a huge number of people
marked in the initial CC.  Disaster waiting to happen, if you ask me.
I'm not "blaming" you, but the lesson to be learnt is: avoid non-patch
emails, and CC conservatively; if you want to discuss some changes,
send a patch.  That would explain why this very email is disguised as
a "[PATCH]", with exactly one person in the initial CC.

In short, the "reason" is a complex mix of various people's
interactions under the current circumstances.  Fires happen, and that
is a fact; we can only look for common patterns and attempt to avoid
fires by documenting these patterns as violations.  Which is exactly
what I have done (or attempted to do).

> I suspect it mostly has to do with the desire to make sure that
> bystanders do not get an impression that the one who speaks last
> gives the conclusion to the discussion, so stating "The attacker
> being the one who speaks last in the discussion does not mean the
> conclusion is his." explicitly might be one way to make it more
> practically useful by alleviating the urge to respond, instead of
> saying "no matter what".

That is one pattern, but by no means the only one or even the "most
important" one.  I thought 0 was a nice generalization.
