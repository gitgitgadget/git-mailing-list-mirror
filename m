From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 16:24:34 -0700
Message-ID: <7vr4gzlxvx.fsf@alter.siamese.dyndns.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
	<7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
	<CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
	<7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
	<CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 01:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uevv8-0002gi-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 01:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab3EUXYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 19:24:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab3EUXYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 19:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5B0A21E80;
	Tue, 21 May 2013 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSeGQDzUVuAWmR3d1MTrGEQnLug=; b=yI98g4
	yiHKZie7mhz9h7GElVAN9zGT/pmSddhymOcEDtMk1+DvWN+07Z0eXfxog73Zkpcb
	j5I7sSL01882BYab5dzc2xkAa5rs879qovwd/Y0ZxjdH5BZjsvQMYhvArWgqnV0q
	KbUuwy8QqsWQDZ2RyHudBEc6uuHSMl/GiFjzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cGJeQmSIR4veSk8eAjST0zIH84geJsJ7
	/AdAvXqR92VzdTBnimFO77yTPG7Lfjo1BWLa8BRsys4T+/duzAXgh9Kua+J025M1
	Jw0Ff1mx6VMy/0xcFhft4LpW7zuWUa8qTiPxgZG9MKMZR8ycqe+U7aCCHeyexDGk
	INKkdos8koQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD1AD21E7F;
	Tue, 21 May 2013 23:24:36 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FC2D21E7B;
	Tue, 21 May 2013 23:24:36 +0000 (UTC)
In-Reply-To: <CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 21 May 2013 18:03:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99CC29FC-C26D-11E2-8DE1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225093>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I still haven't received a response: which makes more sense?
>
> a)
>
> 	% git checkout svn-ext
> 	% git fetch
> 	From .
> 	 * branch            master     -> FETCH_HEAD
> 	# oops
> 	% git fetch git-svn
> 	% git log ..FETCH_HEAD
> 	% git merge FETCH_HEAD
>
> b)
>
> 	% git checkout svn-ext
> 	% git fetch
> 	From git://git.kernel.org/pub/scm/git/git
> 	   680ed3e..de3a5c6  master     -> origin/master
> 	# oops
> 	% git fetch svn-ext
> 	% git log ..FETCH_HEAD
> 	% git merge FETCH_HEAD

I think with the scenario you are following, a) would prepare the
FETCH_HEAD with her local git-svn branch which is her svn-ext topic
is based on, but you illustrated it to fetch 'master', which I think
is a minor typo.

Modulo that typo, the step before the #oops makes perfect sense.  It
fetched where she told Git her work on svn-ext is based on.

But the step after that does not make much sense in that flow.

"git fetch git-svn" to get from Eric might make sense but running
log with FETCH_HEAD while she is on her svn-ext does not make any
sense, let alone merging with it.  Her svn-ext is based on her local
git-svn branch for a reason---her branches are cascaded this way:

    Eric --> her local git-svn --> her local svn-ext

Hecking out her git-svn to update/rebase it on top of Eric's latest
and then update her svn-ext that is based on her git-svn may make
sense.  But fetching from Eric and merging it into her svn-ext
directly does not.

And what happens before #oops in b) is an utter nonsense.  Her
svn-ext is not even related to my tree.  I think the step after that
is a typo of "git fetch git-svn" to fetch from Eric, but again,
because svn-ext is fork from her local git-svn (which is ahead of
Eric's tree with her own changes, but the changes are not related
to her svn-ext work), these "fetch from Eric, integrate svn-ext directly
with it" makes no sense. 

So, the short answer is neither, but a) can be fixed (not in code
but in the typescript) to make more sense, perhaps like this:

    % git checkout svn-ext
    % git fetch
    % git log ..FETCH_HEAD
    % git rebase FETCH_HEAD
    # The last three can be "git pull --rebase".

    # ok, did Eric do something in the meantime?
    % git checkout git-svn
    % git fetch
    From git://git.bogomips.org/git-svn.git/
     * branch  master -> git-svn/master
    % git rebase FETCH_HEAD

    # now let's rebuild the svn-ext on top
    % git checkout svn-ext
    % git pull --rebase

The last step can be "git rebase git-svn", and the step to update
git-svn from Eric after checking it out can be "git pull --rebase",
but the whole point of having @{u}, even for branches that fork from
a local branch, is so that the user does not have to remember what
forks from what, so I did not force her to say "git rebase git-svn"
in that step.
