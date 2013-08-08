From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message (gitml: message 5 of 20) (gitml: message 6 of 20)
Date: Thu, 08 Aug 2013 10:38:53 -0700
Message-ID: <7vsiyk9j6a.fsf@alter.siamese.dyndns.org>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
	<vpqfvukfgr5.fsf@anie.imag.fr>
	<edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
	<87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com>
	<87txj0i4mc.fsf@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Stefan Beller" <stefanbeller@googlemail.com>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:39:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UB2-0006t1-S9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966017Ab3HHRjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:39:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965827Ab3HHRi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70F3037EE0;
	Thu,  8 Aug 2013 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h++bBDXTIDDrWNsaQ79mitJiKkg=; b=w2JzkL
	ud4thszKZT1zO/pA0FLKjWKOEwBmEaMv5N2xqGefeTz1Mj5v2b+DqgyCp8MYV49a
	SusqcKpD1qbP/jMmp2nyit8DM2d/HCaWomwadeTu9IpqX3Ui5TUB5N9CCLj0fB8m
	3cmPwkdhdRd5d/Px/H0ZkgmziQKqnMhCjDPZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oM9qriHXNrReJuMVsIy+2KpDVS2+PuAz
	Gb4SBgZCYcu2BuUSpKH8JZdR+S5kx10u0iZoPwvbnK9/RNfFTPy/vCGYqmt2wHhm
	DkRpQ6DZxULUbnI3PiUw60CNeEXuWcMO4Z2v/3Fc/7IS3oCV/0Zw9YQt5B6HCMw0
	iGQ8qCC3Xbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105E537EDD;
	Thu,  8 Aug 2013 17:38:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7678C37ED4;
	Thu,  8 Aug 2013 17:38:55 +0000 (UTC)
In-Reply-To: <87txj0i4mc.fsf@inf.ethz.ch> (Thomas Rast's message of "Thu, 8
	Aug 2013 17:28:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 662741F0-0051-11E3-941E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231908>

Thomas Rast <trast@inf.ethz.ch> writes:

> Ben Tebulin <tebulin@googlemail.com> writes:
>
>> Am 08.08.2013 16:20, schrieb Thomas Rast - trast@inf.ethz.ch:
>>> Can you try to reproduce with a version older than v1.8.3?
>>> E.g. v1.8.2.3.
>>> I'm asking because the above points at packed_object_info(), which I
>>> recently rewrote to be nonrecursive.
>>
>> It seems to run 'much better' 
>>   v1.8.2.3 : 3/10 runs do fail
>>   fb56570  : 9/10 runs do fail
>
> The good news is that this shifts the blame away from my commit ;-) as
> the problem clearly existed even before that.
>
> The bad news, of course, is that this is another hunch that turned out
> to be wrong.  I'm running out of ideas.
>
>> They always fail on a big blob (39MB) as I wrote in my first e-mail:
>>
>> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
>> error: sha1 mismatch 49cdd0b21a351f3366008615d2cf8d03ca943978
>> fatal: bad object 49cdd0b21a351f3366008615d2cf8d03ca943978
>> 0
>> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
>> 39517156

Hmm, from this, and a later one ...

> Ben Tebulin <tebulin@googlemail.com> writes:
>
> I was unable to reproduce the error with the same repo and same Git
> version on a different machine (Debian Squeeze x64 on a AMD Phenom x6
> 1045T).

... I am reading that (1) the packfile and repository is basically
OK, (2) reading that object sometimes fails, and (3) the symptom is
not limited to fsck but anything that reads the object with
parse_object().  And that symptom exists only on that single machine
(I am assuming that the repository was bit-for-bit copied, not
"cloned", for the purpose of testing it on the other machine).  That
makes me suspect something outside the control of Git (e.g. faulty
memory or disk controller cable).

Are there other big blobs in the repository, and would "show | wc" fail
if you attempt to read it on that machine?

Thanks all for helping to track this, by the way.
