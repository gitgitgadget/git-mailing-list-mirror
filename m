From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dates in Commits and other issues of style (Re: [RFC 2/5] Pretty
 Print: show tz when using DATE_LOCAL)
Date: Sun, 24 Apr 2011 20:57:50 -0700
Message-ID: <7vhb9nkmo1.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
 <7vtydrutbq.fsf@alter.siamese.dyndns.org>
 <811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
 <87sjt76rzo.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 05:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QECwG-0000To-KF
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 05:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758082Ab1DYD6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 23:58:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab1DYD6D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 23:58:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4112648ED;
	Mon, 25 Apr 2011 00:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/uE/WKQn3iedkye5Upmtql93E4=; b=twSXEC
	5tg1SgtGRvip6QoLqXFkTmEYk3gvD8072RlgdZUMBKl5Hmj1L2o9Rz0q2RPEojC/
	v8bvRD4W7QZaF3U3Ya7XA8sZksZVi0kfOX1KrdQSkh9SpwMdK+OHaGP7tKsi2BmN
	Cxn7dPy8jdtI2fJ0i8OVXOx2kbJrILcSXi1Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUiEmivzRp5hkMi2zwsA46F33M2VIJ7Q
	/7zn7c66WNsQkbl0Q8pubTepCt09nAzP/qbnyqnzrMm8wKnJVUEsc12cCfI9fegE
	ZuoZ7B/1u3hwhLgZxxpQ50Ih2D47B6Fd3fvM3W8KKDsfO9Vy/oUBPHjqPbbrXgkz
	ba9cn98lprw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5A2E48E9;
	Sun, 24 Apr 2011 23:59:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCB5448E6; Sun, 24 Apr 2011
 23:59:53 -0400 (EDT)
In-Reply-To: <87sjt76rzo.fsf@catnip.gol.com> (Miles Bader's message of "Mon,
 25 Apr 2011 10:26:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C503D00-6EF0-11E0-91AA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172014>

Miles Bader <miles@gnu.org> writes:

> Michael Witten <mfwitten@gmail.com> writes:
>> and I feel like
>> you are now
>> nitpicking.
>
> Wait, isn't nitpicking his job?!

Enforcing consistency is one of the important tasks the maintainers do in
their projects.  Besides ensuring that the intent of the change each patch
brings to the codebase is good, that the log entry describes the change in
a useful way for future readers, and that the patch correctly implements
the described change, we also need to make sure that the resulting code
matches the style of the surrounding code, and the style, structure and
tone the log messages are delivered in a consistent voice.  Otherwise it
would quickly get very tiring when you have to dig into the history of the
codebase.  The code and the history are read a lot more often than are
written.

When a casual and occasional contributor sends in a good change whose only
sin is style violation, I do not mind touching up its proposed commit log
message or the patch text, and I often do.

But I expect contributors who return here often to be more considerate
than one-time contributors, and that is why I give style reminders.

The purpose of the style reminder is so that they can help me and other
reviewers concentrate on the substance (Is what it does good? Is it
explained well? Is it implemented well?) without having to spend
unnecessary time fixing the form (Does the new code fit well with the
surrounding code? Does the message flow well in "git log" and easy to
understand?) when they submit their changes the next time.

Please do not mistake a style reminder as an opportunity to promote your
own style that would not match what we have established here.  I could
make a black-list of people I should avoid giving style reminders and
instead fix all of their submissions silently, because giving style
remainders to them will waste people's time by creating a discussion
thread like this one.

I really wish I do not have to do so.

Such an arrangement would not scale.  Given two sets of patches with equal
goodness in substance, if one also matches our style and the other
deliberately asks me to spend extra time to whip it into our style, the
latter naturally has to be assigned a lower priority.  After all, there is
only 24 hours in a day, and my time is better spent on substance not form,
and definitely not on responding to quibblings about styles.

The only two "workable" solutions are either (1) everybody tries to be
consistent with the project's style, or (2) allow everybody to stick to
their own style, making the resulting code and history unpleasant to read.

I'd be failing the community if I took the latter approach.
