From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 01 Mar 2012 23:03:28 -0800
Message-ID: <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 08:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3MWh-00072s-LF
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 08:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab2CBHDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 02:03:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756414Ab2CBHDb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 02:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8BE07378;
	Fri,  2 Mar 2012 02:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2qX+udO2IHdUCIcH8RryVevewwY=; b=gAIIyT
	8wmZhwTVrLBnogL26btzdpZYR8yLEqy5go5/dJAf3WPGR16DgtMc546nCEJob/gT
	AxW1x5DXO8Ye0hdMrVbX8nOUoc42z75sZq2qnzEJ0C8tLR+4dk0Pw3ocuVoerYNh
	27GVZDmLLa8mPUQehgFlgEyOokL0dIa0Un0UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z2Qe2FpgodeJexYl7xZxCb7RKVF7HDag
	qTR7rs7bYB5Hfa2oX/KkaUrXjOitaUb/NzniYsh3PfiRcGxAKldkuJJurJ+7V6HX
	F2Lnw0jFChNoxabusNcBxbkmyLqVPxtGdveuGsc5znCCsv6JTyYu0eQ04OI2XilV
	y+G32P7f74M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4A67377;
	Fri,  2 Mar 2012 02:03:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0251D7376; Fri,  2 Mar 2012
 02:03:29 -0500 (EST)
In-Reply-To: <4F505F8C.70802@gmail.com> (Neal Kreitzinger's message of "Thu,
 01 Mar 2012 23:50:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D106A362-6435-11E1-A58A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192008>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I realize this is not an exact match of the git-workflow, but you get
> the idea.  I'm also new to mailinglists so I'm not sure if you can
> change part of the subject line.  If not, a header in the body could
> possibly be used.

The most important information is missing from your discussion: who are
you trying to help, and what problem are you trying to solve?

When somebody posts a bug report to the list, with the current workflow,
one of these things happens:

 1. It is an already solved issue. People who are familiar with the
    existing fix may immediately answer, after running "git log", with "It
    is fixed in v1.7.6". Or somebody not so familiar with the fix may
    start "Does not reproduce for me who use the 'master' version. Git
    from what era are you using?" conversation. I do not think a bug
    tracker will help much in this case [*1*].

 2. It is an already answered non-issue. People who are familiar with the
    previous discussion may point at the list archive, or somebody may dig
    up the answer in the gmane archive. I do not know if a bug tracker
    will help much in this case. Having a place to point people at is
    better than having to write everything from scratch every time, but
    (1) looking for the previous discussion is the more time consuming
    part, and (2) once the previous discussion is found in the list
    archive, we already have the necessary pointer.

 3. People who are familiar with the area of the problem may start "Need
    more info" conversation. This may result in either finding the report
    a non-issue (#1 or #2), or it may turn out to be a real issue, and
    after further analysis, design and coding, may result in a fix.  Once
    this flow starts rolling, the current workflow works very well.

 4. It falls through cracks, because nobody even categorizes it into the
    above three.

I think the primary thing people want out of a bug tracker is to reduce
the frequency of #4.  The real solution for it is to free up time from
people who can do the later part of #3 so that they can spend more time to
turn #4 into #3.

A way to do so is for members of the community who are capable of doing #1
and #2 but not familiar enough with the code to do the later part of #3 to
help with earlier part of #3 (i.e. triaging).

As I already said. the mailing-list based workflow serves us reasonably
well once the ball is rolling in #3, and that was the reason why I
suggested some heuristics to catch #4 in my previous message.  There are
cases where the original reporter disappears during the "need more info"
exchange, and in such a case a tracking system _may_ be able to help us
remember that the issue is unresolved because of reporter inaction, but
the tracker won't respond to "need more info" itself, and people tend to
ignore automated nag mails, so there is still a need for warm body human
bug secretary who interfaces with the reporter in such a case.

In any case, any solution that demands more things to be done by people
near the core developers than they currently are already doing will make
things worse by exacerbating the problem that comes from a bottleneck in
the process.  I do not think your "The maintainer triages and assigns
issues to other developers" or "The assigned developer marks the issue as
'done' after fixing it" will fly very well, regardless of the use of any
bug tracker.


[Footnote]

 *1* If the symptom is so straightforward that a simple search in a bug
     tracker can produce hits for an already solved issue, grepping in
     Release Notes should equally work well.

 *2* I do not know if this happens too often to be a real problem, though.
