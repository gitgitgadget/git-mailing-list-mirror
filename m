From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Mon, 11 Jun 2012 09:57:23 -0700
Message-ID: <7vehpl7pn0.fsf@alter.siamese.dyndns.org>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <7vr4tnab9e.fsf@alter.siamese.dyndns.org>
 <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7vt-0001Xr-GC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab2FKQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:57:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2FKQ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:57:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1DEC8C47;
	Mon, 11 Jun 2012 12:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W/LmWCAb3R2VeJm+JGqyZfziqGc=; b=xyJFIs
	RlW4Fpz8OIsCPHFfLjbrbUZTCza0fPSIiOLjD1EhbkV+ectiQEXAc3U11/qblzCz
	Exq7ZqORYWvLkZMPfRiy5tJv4EJJz3HRBsvXgqyasT3GsB0CBLBwFgwoIXrv+LUP
	CP3iuZ3h7UqLYz1xdrL6sXl+JcwgeqcPyAZIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YN0IbaMyc8aDwpIqXRrP24PST0+nn9pc
	ADf0Tfj5Zpi3KzWPQ5hqx3eqF3ksSNGUoXR2tgyNDkwDcWfsOlqx7oDK01UXHC4/
	IK9vyvCtNZyMOjjnGNO3zkM+JJUqHQBbkBeRIrSJoUjJbwPByeNLyskfK0otg144
	anOhiFpMHqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C708C46;
	Mon, 11 Jun 2012 12:57:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C8DB8C45; Mon, 11 Jun 2012
 12:57:25 -0400 (EDT)
In-Reply-To: <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com> (Leila's
 message of "Sun, 10 Jun 2012 12:02:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8502F56E-B3E6-11E1-AB9B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199677>

Leila <muhtasib@gmail.com> writes:

>> Having said all that, I personally doubt this is a useful change.  I
>> may have thought of adding a README file to a relatively new project that
>> does not yet have one while in shower but I haven't even created the
>> file in the working tree.  And I forget about it once I get to the
>> office.  Should the system remind me to create README and then add?
>> Your patch would not give me such a reminder once the top-level
>> directory is populated (because it is no longer empty).  Even if I
>> were planning to add Documentation/README instead, I would get such
>> a reminder only if the Documentation directory is empty. Once the
>> directory is populated, I wouldn't get "create README and then add".
>> Why should an empty directory so special?
>
> So there are two separate discussions here:
> 1) Should empty dirs be tracked
>
> 2) Should empty dirs appear under 'untracked' in git status

You are not answering my question by asking either these two
questions.

Please read what you quoted again.  I may have forgotten to create
and add README

 - at the toplevel directory; or

 - in the Documentation directory that already has other tracked
   files; or

 - in the Documentation directory that does not have any file yet.

Why do I get a reminder for only the last case?  Also please realize
that at no point in the scenario I am interested in adding an empty
directory.  "How does one add empty directories" is irrelevant to my
question.

A more reasonable answer would have been "the reminder is not about
a yet-to-be-created README file, but is about an empty directory you
might have wanted to place something---there is no way for Git to
guess that you wanted the new file to be README, but at least having
a totally empty directory laying around may be an indication that
you wanted to do something intereseting in it but haven't yet".  If
the proposed commit log message justified the behaviour to treat
only the third one specially that way, I suspect it may make some
sense.
