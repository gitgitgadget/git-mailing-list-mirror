From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 11:19:46 -0700
Message-ID: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
 <7vy6n065os.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 20:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1lDh-0004LH-QF
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 20:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZJXSTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 14:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZJXSTz
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 14:19:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZJXSTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 14:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9B265520;
	Sat, 24 Oct 2009 14:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zwzc083o8GYblntuR7yiGjC5Q5U=; b=dDDMJt
	TpOjrlZCVDJYZRAic7yYfoNBd3uCwStYmMzBgBnaVn4aHfNnYKcm4DfF2ZwiRn72
	nbcpdNfrM6XtxOuWNl4btnfG8pcjtkYjJjmF1bt6wQYcalF/Y69zZqecNelXv0Sj
	DY5JwVULuJhy6hajIM5QJlWz6q/z0jS2uDsAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obVEshb7I6y8qlE0TiE3Vo+pk53yVOlj
	mSWHWkPoi5bWK35FHn5tKLSNhbKcrjmL3F1UxDNXqauo0C3pyCKai5M7PCMCsa3D
	FjUCqLYk4ti6ebgecvKy4Y14BRkEzDsYOCq8tQhfuaOVSXhs+dTQvayKAGAFDyvM
	icZ3wzgFTKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D72646551F;
	Sat, 24 Oct 2009 14:19:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC0DA6551E; Sat, 24 Oct
 2009 14:19:47 -0400 (EDT)
In-Reply-To: <7vy6n065os.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 24 Oct 2009 10\:51\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D396B494-C0C9-11DE-8336-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131171>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Reworded the getting started section based on comments from Michael J Gruber,
>> Jonathan Nieder and Junio C Hamano.
>
> Hmm, I thought JBF also had some input...

Ah, nevermind. Yes, he did have input, and I tend to agree with him, and
more importantly trust his judgement on the manual.

I think a "Getting started" section that only covers "git config" looks
way out of place in the beginning of this document.

Manuals by other people that teach "here is how you would do a hello-world
repository" would want to teach user.name before reaching that point, but
because the user-manual is written in such a way that it first introduces
concepts to understand what is going on without changing anything, we do
not have much need user.name until it gets to "Developing with git"
section.

"Many people prefer to teach it this way" does not justify "everybody must
teach it this way" an iota, when teaching "config user.name" upfront will
fit the flow of how they teach but does not fit the flow of how this
manual teaches [*1*].

I'm inclined to to discard the first patch.

The point of the original text the second patch touches was to show how
simple the contents of the configuration file is and give the users that
there is nothing magic there.  While I do not like the second patch as-is,
because it destroys that nice property and treats the end users mindless
"cut-and-paste without thinking" sheeples, I think that it is rather vague
and unhelpful to the current target audience to say:

    ...  The easiest way to do so is to make sure the following lines
    appear in a file named .gitconfig in your home directory:

and the parts can use some improvement.  For example, "home directory"
does not hold true for people on platforms that lack the concept.  Keeping
the current "the following lines appear", rewording "in a file named
.gitconfig in your home directory" with "in your per-user configuration
file", keeping the display that shows how the config snippet should look
like, and using "config --global -e" might be a better approach.


[Footnote]

*1* Unless you are changing the flow of how this manual teaches at the
same time, that is.  And no, I am not suggesting that we should start from
"let's do a hello-world repository from scratch".  I think the current
"start from read-only and then learn how to grow history later" is one
valid way to teach.
