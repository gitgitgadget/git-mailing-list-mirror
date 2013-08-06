From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: clarify some details of the patch format
Date: Tue, 06 Aug 2013 12:22:35 -0700
Message-ID: <7vmwoufwuc.fsf@alter.siamese.dyndns.org>
References: <201308061833.r76IXr6R026692@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Tue Aug 06 21:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6mqC-00036q-6J
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 21:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3HFTWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 15:22:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254Ab3HFTWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 15:22:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FBD36721;
	Tue,  6 Aug 2013 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=izV/bdDlDL7FXT4bGGR7wL5ufP8=; b=nL4nGx
	+mLjxZj2q/sEuaC/8jOhILiAJ0WHh4psSP8irUyxbvJsoEAe+T42F6cEwcMA4/tk
	yREiFF67GYCD+sVCT+7wFheHeFZYq2OPeS+/Oqpt5Gi5O8L04Xjgq8xqPkUSpqOM
	vpEUdVblbdiUgIpgrRgHgVSwC0L42KY+cJTmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIYS8/cgrr8KIs4BvfCGNXAahSkLMnpg
	rpTycphkjsWmEQFhKKWeCxQuD6lUnz8TMXJNdTHHRzNNRPG9LJj9Fgf84YMo97Y2
	IsJcDTlyLanLDPVKL9uKgNTMEmK8z9Do7D2KFVpQRAsbUZosVp1dLMHgbLHRdLtp
	RpEpo+oDwTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6B63671F;
	Tue,  6 Aug 2013 19:22:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09A023671B;
	Tue,  6 Aug 2013 19:22:36 +0000 (UTC)
In-Reply-To: <201308061833.r76IXr6R026692@freeze.ariadne.com> (Dale
	R. Worley's message of "Tue, 6 Aug 2013 14:20:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D8378DE-FECD-11E2-8EA5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231780>

worley@alum.mit.edu (Dale R. Worley) writes:

> ---
> This is a first draft of a patch that clarifies a number of points
> about how patches should be formatted that have tripped me up.  I have
> re-filled a few of the paragraphs, which makes it hard to see from the
> diff what I've changed.  This listing shows the changed words between
> { ... }:
>
>      { This first line should be a separate paragraph, that is, it should be
>     followed by an empty line, which is then followed by the body of the
>     commit message } .

Correct; I tend to prefer phrasing that avoid "that is", though.

	the first line should be followed by an empty line to form a
	separate paragraph on its own and give a summary of the change.

>      { At the end of the commit message should be a Signed-off-by line giving
>     your name.  This can be added to the commit message automatically by
>     giving "git commit" the "--signoff" option.  This line has legal
>     implications, see "Sign your work" below } .

OK.

>     People on the Git mailing list need to be able to read and comment on
>     the changes you are submitting.  It is important for a developer to be
>     able to "quote" your changes, using standard e-mail tools, so that
>     they may comment on specific portions of your code.  For this reason,
>     all patches should be submitted "inline" { rather than as message
>     attachments } .  If your log message (including your name on the
>     Signed-off-by line) is not writable in ASCII, make sure that you send
>     off { the } message in the correct encoding.

OK.

>     "git format-patch" command follows the best current practice to
>     format the { patch for transmission as an e-mail message.  The files
>     that it outputs are sample e-mail messages in "mh" format.  The

Not "mh", but "mbox".

>     initial lines are sample From, To, Date, and Subject headers, which
>     you will likely have to remove or revise, depending on how your MUA
>     operates } .

Correct.  They are designed to be "moved" to your MUA header fields
(so they will disappear from the body but you do not have to type
them to your MUA).
>
>     At the beginning of the patch should come your commit message ( { the
>     first line in the Subject header, the remainder in the body of the
>     message } ), ending with the Signed-off-by: lines, and a line that
>     consists of three dashes, followed by the diffstat information and the
>     patch itself.  If you are forwarding a patch from somebody else,
>     optionally, at the beginning of the e-mail message just before the
>     commit message starts, you can put a "From: " line to name that
>     person.

... followed by an empty line?

>     You often want to add additional explanation about the patch,
>     other than the commit message itself.  Place such "cover letter"
>     material between the three-dash { line } and the diffstat. Git-notes
>     can also be inserted using the `--notes` option.

OK.

>> From: Junio C Hamano <gitster@pobox.com>
>> 
>> I am not sure if SubmittingPatches is a good place, though.
>> The document is a guidance for people who contribute to _this_
>> project.
>> 
>> But the specialness of the first paragraph applies to any project
>> that uses Git, so people other than those who contribute to this
>> project should be aware of it.
>
> All of that is true.  But what can we do to ensure that someone who
> submits a patch does so with the right format?  The special treatment
> of the first line is not a requirement.  See, e.g., the git-commit
> manual page:
>
>        Though not required, it’s a good idea to begin the commit message with
>        a single short (less than 50 character) line summarizing the change,
>        followed by a blank line and then a more thorough description. Tools
>        that turn commits into email, for example, use the first line on the
>        Subject: line and the rest of the commit in the body.

This is one of the thing I explained in the "Originally we literally
used" background story in the previous message.  The paragraph's
"use the first line" is no longer correct, afaik.

We take the first paragraph and make it a logical single line if/as
necessary, using RFC2822 header "folding" to put it on the "Subject:"
line.

This project requires you to have a short single-line paragraph as
the first paragraph of the log message, and stating it in SubP
document is good.

> -People on the Git mailing list need to be able to read and
> -comment on the changes you are submitting.  It is important for
> -a developer to be able to "quote" your changes, using standard
> -e-mail tools, so that they may comment on specific portions of
> -your code.  For this reason, all patches should be submitted
> -"inline".  If your log message (including your name on the
> -Signed-off-by line) is not writable in ASCII, make sure that
> -you send off a message in the correct encoding.
> +People on the Git mailing list need to be able to read and comment on
> +the changes you are submitting.  It is important for a developer to be
> +able to "quote" your changes, using standard e-mail tools, so that
> +they may comment on specific portions of your code.  For this reason,
> +all patches should be submitted "inline" rather than as message
> +attachments.  If your log message (including your name on the
> +Signed-off-by line) is not writable in ASCII, make sure that you send
> +off the message in the correct encoding.

Rewrapping the existing text was unwarranted burden to reviewers.
Please learn to avoid it in your future submissions.
