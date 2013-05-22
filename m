From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Wed, 22 May 2013 09:50:49 -0700
Message-ID: <7vtxlvj6vq.fsf@alter.siamese.dyndns.org>
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
	<7vr4gzlxvx.fsf@alter.siamese.dyndns.org>
	<CAMP44s2hH63rM++bG-aGeEyaL3tvF8yZYmcO7K1J66KVxyOutQ@mail.gmail.com>
	<7vehczltwu.fsf@alter.siamese.dyndns.org>
	<CAMP44s3cvCuOJfm4HhqOiwm=63wGiTMx7LO8Y5F+SAu=E0tN9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 18:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfCGE-0000Ml-P5
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 18:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab3EVQu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 12:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab3EVQuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 12:50:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C60CF21721;
	Wed, 22 May 2013 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AkMoSA4B5qBTF6fLhCbTeixZ+1E=; b=IBXInQ
	LyEfktQHy+UeIfuKNIa2IK+2vkoOuFZvUk7aRpsWhIH2SiXmfM8FPd25tFtKDQQn
	lmVDMwkLZXfM+lznH/Aonksvy2O0Y+pHFU2rH0OgAdfmxp4pI28x+FNx1kcJsYpZ
	lhFnU0dcJ3GWl7zY1XQhLbxHiys1s/zj0UrAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cu5IF4l9DMRasiFQm/vRmGDmM19q+NX4
	zCTrX70ZiGAI2mg2vZezb29GWfQ+q6duY8Ba9xDh7K9Y+wXd4+XP8OpRWd+yTAQQ
	wmnkMgPiNlLkv7Kqll9Rx4iI6aeItS6Q5gpoxQFZWke5KMKsNus/iiDn3kGqkkrI
	g/4XPdb+iDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9BC421720;
	Wed, 22 May 2013 16:50:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CAF62171D;
	Wed, 22 May 2013 16:50:50 +0000 (UTC)
In-Reply-To: <CAMP44s3cvCuOJfm4HhqOiwm=63wGiTMx7LO8Y5F+SAu=E0tN9Q@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 21 May 2013 21:57:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2873782-C2FF-11E2-8F7E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225175>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> She told Git that her local svn-branch was the basis for svn-next. She
> DIT NOT TELL Git to fetch from there. She told Git to fetch from any
> location Git thought best to fetch from, either a) or b) would fetch
> from the wrong location, but a) would be wronger, you just don't want
> to admit it.

"(a) is more wrong" is just your opinion, and you are simply wrong.

She is working on svn-ext based on her local git-svn the latter of
which has some changes of her own on top of Eric's tree.

When working on _any_ branch that bases its work on something else,
you have @{u} available, but that @{u} will not stay up-to-date if
you forked from work that is done outside your repository.  That is
what an unqualified "git fetch" is designed to help when run on a
branch that bases its work on something else.  If you happen to know
that yoru current branch is forked from git-svn that is a local
branch, then running "git fetch" becomes unnecessary for the purpose
of updating @{u} (it already and always is up to date), so doing no
object transfer and no ref update is absolutely the right thing to
do.  That is what "remote = ." gives you.

In addition, that does not break the "pull = fetch + merge"
equivalence you seem to be ignoring.

If she wants to check what Eric has been doing, she can do "git
fetch git-svn", giving the remote name she calls Eric's tree with.
At that point, she is not saying "I want to check what is happening
to the upstream of my _current_ branch" (and the fetched result is
not something she can immediately use while on her current branch).

On the other hand, an unqualified "git fetch" that slurps from my
tree, which is your (b), is just plain wrong.  My tree is not even
related to what she is working on.

Of course, when she is interested in what have been happening in my
tree, she can say "git fetch origin".
