From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] howto/maintain-git.txt: new version numbering scheme
Date: Mon, 03 Feb 2014 15:58:12 -0800
Message-ID: <xmqqa9e7bvfv.fsf@gitster.dls.corp.google.com>
References: <xmqqfvo3hhhe.fsf@gitster.dls.corp.google.com>
	<9E6F99D96D124571897121E4227508EF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATPB-0000cf-8y
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbaBCX6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:58:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaBCX6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:58:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E2C2697EB;
	Mon,  3 Feb 2014 18:58:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LR+zy1Osfs8/xzwWqAI0mC/CZI0=; b=m7h559
	gTNTn+9ota5M4+LC5SY09Gjsm8ENQ1EbKNDRp4578QQo+svqQrDAtEXohj/phoNK
	RMStkzCCcIhBNK6YndvBflR823k+x50c9hpmkm7+Ga0CLD/pmsOHVshUdYWqQsdU
	C9ZxZBqPkBXdcgBLoDCgM6xvMSttDgsD+a17g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KXXlJGK1cvnBWZ+1JfE5DIwsrGq6yJ60
	IEu3arwt1GCvkDj2/aTKzO1t/jZN1gNPATKHGBAeFwK9XjplxQNyfgfNnge2uu9c
	jRRVCKf1cPfpBITQF9EIWFb55qC7uT+aUXPN9zYghDV+LXKj7LG3+HzZ4UPJXDle
	GwTtAlYnsxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 643F6697EA;
	Mon,  3 Feb 2014 18:58:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1CFD697E9;
	Mon,  3 Feb 2014 18:58:14 -0500 (EST)
In-Reply-To: <9E6F99D96D124571897121E4227508EF@PhilipOakley> (Philip Oakley's
	message of "Mon, 3 Feb 2014 22:03:36 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0B7965F6-8D2F-11E3-BE89-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241498>

"Philip Oakley" <philipoakley@iee.org> writes:

> If we are progressing from V1.9 to V2.0 quickly (one cycle?), which I
> understand is the plan, then mixing the minor development items (patch
> series which progress to master) with the maintenance fixes over the
> next few months, thus only having 1.9.x releases, sounds reasonable.
>
> If there is going to be separate maintenance fixes from the patch series
> developments then keeping to the previous 1.9.x.y for maintenance would
> be better.
>
> Will the new rapid counting continue after V2.0, such that we get to
> V2.9 -> V3.0 rather more quickly than V1.0 -> V2.0 ?
>
> The key discriminator would be to say when V2.0 will be out for deciding
> the V1.9 sequence.

I do not quite follow.  The time distance between v1.9 and v2.0
should not affect anything.  If it is a long road, there may be
v1.10, v1.11, v1.12, ... before we have v2.0.  If not, v2.0 may
immediately follow v1.9 as a new feature release.  There may be
maintenance releases based on v1.9 that does not add any new
features.

Right now, if you count the maintenance releases, there are
potentially four kinds of version gaps:

 - Between v1.8.5 and v1.8.5.1, there are fixes but no new features;

 - Between v1.8.5 and v1.8.6, there are new features but no
   compatibility worries;

 - Between v1.8.6 and v1.9.0, there are new features, no
   compatibility worries, but somehow the jump is larger than the
   one between v1.8.5 and v1.8.6; and

 - Between v1.9.0 and v2.0.0, there are new features and also
   compatibility concerns.

Switching to 2-digit scheme and calling the upcoming one v1.9 (and
the next major one v2.0) was meant to make the naming more flat, as
the third item in the above list "somehow the jump is larger" does
not seem to add much value to the end users.  So the logical
numbering becomes more like this:

 - Between v1.9 and v1.9.1, there are fixes but no new features;

 - Between v1.9.x and v1.10, there are new features but no
   compatibility worries;

 - Between v1.9.x and v2.0, there are new features and also
   compatibility concerns.

With a twist, though.  There seem to be many places where at least
three digits are assumed to exist in our version numbers, so in
order to make life easier, the updated document says vX.Y (a feature
release) will identify itself as vX.Y.0
