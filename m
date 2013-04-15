From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 07:53:48 -0700
Message-ID: <7v1uab26bn.fsf@alter.siamese.dyndns.org>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <87r4iccgdw.fsf@linux-k42r.v.cablecom.net> <vpqvc7oqh8a.fsf@grenoble-inp.fr>
 <20130415140513.GA16154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 16:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URkn7-0001dV-QY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab3DOOxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 10:53:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3DOOxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 10:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6F6514C04;
	Mon, 15 Apr 2013 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ai/xI8RqsiJPfZEmrx+uUw+W0Bw=; b=PLYx1l
	WvJ0CDfSY+9JwE8WkaADGljnggfmfNPYXwgoZ3XeUvonsIllP9JaWmc2m4R3TAlY
	Yc1w876wut92tBlca4KTpNDmH4oms9Zy8XnQWxgx9+bO8AOWDwrPTeka8MTbnBzU
	rDpGLh7Tx3VjmNH4gzBBYSaSH2r7xmU26glHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GuUecPjIGCtNjBJnGL+V1grALu0m1a8b
	B7K0du+yZyjwRTXSKb3h5NnnAu4MFjPKGxMJ6fH3TW0O15a+eI83wTgbpKDkczor
	A4i/u/hK5G10+/eI/WMggoG1JaNtcB/sYYEbXJCsbzaCzjUhwTrM0GSYzLlguUXY
	5MeqgRNzURk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEEA414C03;
	Mon, 15 Apr 2013 14:53:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A87514BFB; Mon, 15 Apr
 2013 14:53:50 +0000 (UTC)
In-Reply-To: <20130415140513.GA16154@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Apr 2013 10:05:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48FDD3A2-A5DC-11E2-B69C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221234>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 15, 2013 at 11:24:21AM +0200, Matthieu Moy wrote:
>
>> > * git pull --set-upstream
>> >
>> >   This is vaguely related to another itch that nobody has bothered to
>> >   fix: 'git fetch origin foo' should really update origin/foo.  This has
>> >   been discussed on the list a few times already:
>> >
>> >     http://thread.gmane.org/gmane.comp.version-control.git/192252
>> >     http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758
>> >
>> >   which by the way would be a *great* thing to fix, hint hint ;-)  and
>> >   since Peff already posted a POC patch in the first thread, it's
>> >   probably not that hard.  (Peff?)
>> 
>> My understanding is that this would be technically easy to fix, but a
>> migration plan is needed, which isn't easy for a one-shot, one-month
>> contribution.
>
> Yes. The concept isn't that hard, but the question was one of whether it
> would break some obscure workflows. But I don't remember all of the
> details; I think I gave some examples in past threads.

I think the one Thomas lists in $gmane/165758 is the one.

It has been the way for users to make sure that origin/master stays
put to explicitly tell Git not to update the remote tracking branch
using a refspec without colon, so that they can do

	git fetch origin master
	git log origin/master..FETCH_HEAD

(or its three-dot variant) to gauge the progress of the other side
since the last time the user observed.

Personally I doubt this trick is so relevant these days, not just
because we can look at reflog of origin/master.  The user could just
do

	old=$(git rev-parse origin/master)
        git fetch origin master
        git log $old..FETCH_HEAD

even with a modified Git that updates the remote tracking branches
without a storing refspec.

The primary reason why I do not think this is relevant these days is
because the original premise "remote tracking branches keep what the
last 'git fetch' observed" has already been broken for a long time.
The users are better off thinking that the remote tracking branches
can be updated any time (not just the last 'git fetch') when Git
observes (or could observe) the state of the remote without being
told explicitly with today's "pretend as if we fetched immediately
after we push" behaviour.
