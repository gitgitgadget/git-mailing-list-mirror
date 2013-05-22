From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 17:50:25 -0700
Message-ID: <7vehczltwu.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 02:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UexGE-0008Gy-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab3EVAu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 20:50:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab3EVAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 20:50:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F28A1A2F8;
	Wed, 22 May 2013 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zxpucXo8vl6uJ/YXCWJIOItewiw=; b=oauGYV
	TJ/7pNN+/G0Ks/sGW52EixKJQx2mUnCwzWDU7mxAFuwpRjLuLCiU76C+OYeGZre3
	IKs2bwBwPTkMgPOgjnocMXK/kctQSOlK9nbcnuJ5BPzbds+io9/FRUHLCSseLyjh
	PAxqKTdR8PWI5JOESnTfVV3Ip6WC7QPaNBXsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yAxDoxtpd969rfW6Y/sMJx7PgEBCxRoP
	MXVsZOEtbLjsZFvtuh9eVa03rxk6zEFwdNKJhAnTrK4PIEk/UVaskbN0JA32wH/e
	SzqYQ2J6EM6pabBGrfKsRruRI6Sn2z9mpZr/mpjaf25e4cJtPjIMyrE3uDt6NmWX
	iCMjEZSjL7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 267EA1A2F7;
	Wed, 22 May 2013 00:50:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 821281A2F2;
	Wed, 22 May 2013 00:50:27 +0000 (UTC)
In-Reply-To: <CAMP44s2hH63rM++bG-aGeEyaL3tvF8yZYmcO7K1J66KVxyOutQ@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 21 May 2013 19:27:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98483466-C279-11E2-B14F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225103>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 21, 2013 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> I still haven't received a response: which makes more sense?
>>>
>>> a)
>>>
>>>       % git checkout svn-ext
>>>       % git fetch
>>>       From .
>>>        * branch            master     -> FETCH_HEAD
>>>       # oops
>>>       % git fetch git-svn
>>>       % git log ..FETCH_HEAD
>>>       % git merge FETCH_HEAD
>>>
>>> b)
>>>
>>>       % git checkout svn-ext
>>>       % git fetch
>>>       From git://git.kernel.org/pub/scm/git/git
>>>          680ed3e..de3a5c6  master     -> origin/master
>>>       # oops
>>>       % git fetch svn-ext
>>>       % git log ..FETCH_HEAD
>>>       % git merge FETCH_HEAD
>>
>> I think with the scenario you are following, a) would prepare the
>> FETCH_HEAD with her local git-svn branch which is her svn-ext topic
>> is based on, but you illustrated it to fetch 'master', which I think
>> is a minor typo.
>>
>> Modulo that typo, the step before the #oops makes perfect sense.  It
>> fetched where she told Git her work on svn-ext is based on.
>>
>> But the step after that does not make much sense in that flow.
>
> You don't get to decide what Sally (I'm naming her) does, all you get
> to decide is what Git does.
>
> Sally wants to fetch from the true upstream: svn-ext, but in the
> process does by mistake a 'git fetch' *without arguments* (WHICH IS
> WHAT THIS WHOLE DISCUSSION IS ABOUT). So now is the time you answer:
> a) or b).

Heh, that was my example.

In any case, my pick is still a).  She *TOLD* Git that her local
git-svn branch is what forms the base of her local svn-ext work.

I won't even read the remainder.  You are not even worth wasting
time on discussing this.
