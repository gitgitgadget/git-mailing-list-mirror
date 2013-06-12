From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Wed, 12 Jun 2013 15:02:43 -0700
Message-ID: <7v8v2f0yyk.fsf@alter.siamese.dyndns.org>
References: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
	<loom.20130612T154959-145@post.gmane.org>
	<20130612194956.GC4898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 13 00:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umt7z-0005fh-46
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935Ab3FLWCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:02:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779Ab3FLWCq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:02:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D50C527BBA;
	Wed, 12 Jun 2013 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1xLsurtTNgLZF+Z4FH/ekpCftmU=; b=VZlV3O
	huMndL8LuoCQfB4VVpzkfx8e8tqPxnpeBZaExIyqfw+oOtmFVGR/tedg2uuS35+8
	Vs3AOipVZp6pYypYP73vDZQXFHUhkSuofMs+c8Ck4fgBS6fzkXuMh2gN8rnt96FK
	Qq42U/gkUTmVIbHSzCuNyuoZKMoxf40d4vOL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HigqGYSJ2/BTFnAaIGBEerAoFQihTQVN
	Rurh9tExhLWnWLpn6t7AYHNiwp6bnL3xzNJhe10KPgKV6Xp6XJmjzUlTfQBwxFmS
	sl7UCjuFbd9NIuM85hN7XzwQvtGAFrTQKnW2tL6V0K7MX5YblVOssRFsDXnjbZJU
	p9daP5GS9tQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA17F27BB8;
	Wed, 12 Jun 2013 22:02:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB9E27BB7;
	Wed, 12 Jun 2013 22:02:45 +0000 (UTC)
In-Reply-To: <20130612194956.GC4898@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Jun 2013 15:49:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFC59788-D3AB-11E2-A655-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227685>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 12, 2013 at 01:56:20PM +0000, Jakub Narebski wrote:
>
>> Junio C Hamano <gitster <at> pobox.com> writes:
>> 
>> > * rr/remove-contrib-some (2013-06-02) 1 commit
>> >   (merged to 'next' on 2013-06-05 at fc15705)
>> >  + contrib: remove continuous/ and patches/
>> > 
>> >  Remove stale contrib/ material.
>> > 
>> >  Will merge to 'master'.
>> 
>> What about contrib/blameview by Aneesh Kumar K.V <aneesh.kumar@gmail.com>
>> and Jeff King <peff@peff.net>?
>
> Yeah, I mentioned it earlier in the thread as something that I consider
> clutter at this point (but somehow the thread drifted away from contrib/
> and into other topics, and I forgot).
>
> Here is a patch.

Thanks.
