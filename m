From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 15:19:52 -0700
Message-ID: <xmqqioq12eif.fsf@gitster.dls.corp.google.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<vpqlhux3yhr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcj3G-0006ba-Al
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbaDVWUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:20:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbaDVWT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:19:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EEC27F8D3;
	Tue, 22 Apr 2014 18:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P7G5p7bJmYiOZMJyjSMC84cPjtE=; b=aH1TaJ
	TENFYwGw8G+hHuOrC6oVWOBfbwu+2cUp5SnR5b4KH2kHo5vz9Q1etKafK3CBgWDh
	01gj2tUU0KYdB7aIPX3CsfJkga3AR/+jKTXk82RS77lLmJr++J3ZZCB186M6Kq7I
	oykk0OMEh2ZRWkHIlA6g9MnaPQLG+l9+ZJhDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUW6hfiQv5G/SC4/PYSSyIiEKO31Nafg
	S/njXTthOOlFIMQVIhFxzEG4KAUco7syy3W4C8Fu+Vmr+vC3n9TvilrJ+0/8uscj
	94vcLS5a5bFky6LLxX8OyceL2LFe0UF4sYY/eAd44cKJM2EF1Ah6ruSvfk6jOEHq
	ELFCro42SQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BAF7F8D2;
	Tue, 22 Apr 2014 18:19:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E49F37F8CF;
	Tue, 22 Apr 2014 18:19:53 -0400 (EDT)
In-Reply-To: <vpqlhux3yhr.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	22 Apr 2014 22:22:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A9A46A0-CA6C-11E3-B0A9-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246794>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Why is not material for v2.0? Because you say so? Are you going to wait another
>> ten years to introduce this to v3.0?
>
> There's no need to wait for a 3.0 to introduce this. If these would
> be low-priority compared to user-defined aliases, there's no backward
> compatibility issue, it can very well be a 2.1, or whatever number comes
> after 2.0.

I do not think the discussion has analysed the issue deeply enough
for us to tell what the final proposal would look like, in order to
judge what kind of issues, whether related to backward compatibility
or not, are involved.  My hunch is that this may not have to wait
for a big version bump, but I am not sure about that at this point.

Also I do not think 3.0 has to wait for ten years, either.

We started discussing incompatible updates for 2.0 in earnest during
the v1.8.2 timeframe, which was tagged mid-March 2013 with a release
notes with a "B/c notes for 2.0" section, but IIRC the discussion of
many of the "let's make things consistent (even if that means we
have to break existing users), and devise ways to make the transtion
for them as smooth as possible" changes that finally is going to
happen in v2.0 have been in the works since the v1.7.x era (tagged
late January 2012).  While I do not want to rush things late in a
cycle (notice how many topics are still cooking in 'next' and will
continue to be in preparation for 2.1 right now), I do not think it
is warranted to have a panic "3.0 will be ten years out, and we will
miss the boat if we do not cram this in some shape into 2.0"---that
kind of haste simply is not necessary.

Even if we end up having to wait for 3.0, it will happen within two
years max, if not earlier.
