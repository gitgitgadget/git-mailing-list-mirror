From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release
 workflow
Date: Thu, 12 Nov 2009 00:03:56 -0800
Message-ID: <7v639ggoer.fsf@alter.siamese.dyndns.org>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
 <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
 <7vzl6soniu.fsf@alter.siamese.dyndns.org> <4AFB57A3.2020002@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Uf9-0008Sl-3s
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZKLIED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 03:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbZKLIEC
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:04:02 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZKLIEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 03:04:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBEB67DC0F;
	Thu, 12 Nov 2009 03:04:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qHIrZSjsK2vvuyISkNe+Io7BQm4=; b=qW7f2aGNC4b4VczkudeBc5+
	pbkZ2Q/2PqLbHI2LuYY2KzOQjnPTEV7SmSFG6An6/6ilr2h/4C30n0E5bSQWnk7M
	LAnYf55yDMLQ5toni0Z0STzJ9pbZL7x8JgZD7GNi92FH5uyWUIFbOe6/DdADdMnb
	gLg7k9CboONStzI7tLlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sAizM7jtRaC92H+3XTADpQ7mWhW5ywuboS0E98yo1xznberkb
	5vaSSGWGQGms6r2KuT0QhJdzKvT7KyHW0gQ+3B8k0kfhlXbt/elVltdWiLGQXwL8
	V6OMJpn6/ydBaRLJ9x6ga0IEzNUFtOuZoFUQR3WaExyvqv4FWTVgsR6PDc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A05F27DC0E;
	Thu, 12 Nov 2009 03:04:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81AA57DC0D; Thu, 12 Nov
 2009 03:03:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F0CAAE8E-CF61-11DE-8A6F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132743>

Raman Gupta <rocketraman@fastmail.fm> writes:

> Junio C Hamano wrote:
>> 
>> Is this meant to show how git.git does its release to serve as an
>> inspiration to others?  The document does not seem to describe how I make
>> releases.
>
> Here is the existing intro to gitworkflows:
>
> ===================
> This document attempts to write down and motivate some of the workflow
> elements used for git.git itself. Many ideas apply in general, though
> the full workflow is rarely required for smaller projects with fewer
> people involved.
>
> We formulate a set of rules for quick reference, while the prose tries
> to motivate each of them. Do not always take them literally; you
> should value good reasons for your actions higher than manpages such
> as this one.
> ===================
>
> It is in this spirit that I am attempting to add to this document in
> relation to the release process.

Thanks for reminding me of this.

Let me address the second paragraph from the quoted part first.  The
existing document is structured as a quick reference.  Rules and recipes,
with supporting prose to explain them (I do not think "motivate" is a good
way to phrase it, though).

I am not very fond of documents with that style, but that does not mean
nobody should work on nor we should ship such a document.  It just means I
would not be a very good judge for one, and major parts of my response 
unfortunately came from my bias against such a document.

What the first paragraph says is also important.  We will talk about the
workflow elements we actually use here.  Every description of a workflow
element should be read as if we said "this is what we use and it has
worked well for us; we recommend you to imitate it." after it.  Limiting
the recommendation to what we practice ourselves and what worked well for
us keeps the document honest.

In that light, after I re-read your patch and my comments, I think I
should rescind large part of my comments on your "Release Tagging" section
and "Maintenance branch update" section.  They are mostly good as-is, and
they are in line with the goal of the document stated at the beginning.
They describe the workflow elements actually used in git.git in a
quick-reference format.

>>> +RELEASE WORKFLOW
>>> +----------------
>>> +
>>> +The maintainer may use the following release workflow:
>> 
>> Please set the tone straight.  If this is to suggest various possible
>> workflows in general vague terms, "may use" would be good. ...
>
> Ok. The current document is inconsistent. In places it uses "the
> maintainer" and in other places it uses "you". In any case, it seems
> that the "maintainer" here is not "Junio Hamano" -- rather, it is the
> reader.

I wasn't talking about the difference between these two (Junio vs you).
That is not the issue.  I was contrasting between

 - You _may_ choose to do A for release management as the maintainer, or
   do B or do C as alternatives.

and

 - In managing git.git, its maintainer _does_ A when making a release.

As we are writing down what we practice, aka "workflow elements used for
git.git itself", in my comment I was hoping the latter was what you were
writing.  Of course we could say

 - In managing git.git, its maintainer _does_ A when making a release.
   It is conceivable we _could_ also do B or C instead, but we do not
   recommend them.

but I think we are better off without such an addition.

An anti-recommendation against B and C like that does not carry the same
weight as our positive recommendation for A, which is backed by our actual
experience.

"In the past, we tried B but it did not work well for us for such and such
reasons, so we don't recommend you to use B" would be justifiable, and
that is what I mean by "keeping the document honest by limiting the
description to what we use".

But if this document is meant to be a quick reference, such
anti-recommendation should be kept to minimum for the sake of
"quick"-ness.

Also I agree with you that ...

>> 	- review RelNotes symlink, Documentation/RelNotes-X.Y.Z.txt,
>>           the stalenotes section in Documentation/git.git, and
>>           GIT-VERSION-GEN for the last time;
>>         - tag it;
>>         - review it again for the last time;
>> 	- test on buildfarm;
>> 	- cut tarball;
>>         - cut RPM on FC11 i386 and FC11 x86_64;

these (except "tag it") can safely omitted to keep the document focused on
"revision control" aspect of the system.

> The autobuilder is not git specific so should be excluded via the logic
> above -- except perhaps the hook part, which I could mention in general
> terms when discussing the push e.g.
>
> "You may decide to use a hook script on the public repository to
> initiate release-related items such as building documentation."

Again, if we are going to recommend it, we should say "We use post-update
hook in _this_ way", not "You may do ...".

A major difference is that we describe what has worked for us and exactly
how, as opposed to giving suggestions that we ourselves haven't even used
but suspect it might work in a hand-wavy way.

>>> +Maintenance branch update
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> ...
>>> +An alternative approach to updating the 'maint' branch is to run
>>> +
>>> +  $ git branch -f maint master
>> 
>> As I already said, I never do this "alternative", and I do not want
>> ...
>> mistake made.  If you use "branch -f", you will never notice.
>
> I know you do not do this alternative, however ...

Given the stated goal of the document of showing what we actually do and
what we know have worked well for us, I do not think we would want it
mentioned as a valid alternative.

> previous discussion. I quote from
> http://article.gmane.org/gmane.comp.version-control.git/115183:
>
>>> I'll add some discussion about the branch -f bit -- I hope you agree
>>> that in this document that is distributed with git, some
>>> beginner-level explanation of the difference between the branch -f and
>>> the merge approach is warranted?

Explanation of the difference would have sounded like:

    We do not use "branch -f maint master" here; it is different from
    merging master into maint in such and such way and using "branch -f"
    for this purpose only has downsides.

But is it really worth mentioning random approaches that novices might
think of as alternatives and then refuting every one of them?  Should we
also say "don't do 'checkout maint && reset --hard master'"?  Should we
say "'push . master:maint' would work equally well but don't add --force
to that command line"?

The document is an overview of recommended workflows.  If we have one best
current practice for a task, just describing it without covering other
inferiour (or equivalent but not superiour) alternatives to clutter the
text would be better for such a "quick reference" document, I think.
