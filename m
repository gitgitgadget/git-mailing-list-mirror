From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 11:40:27 -0800
Message-ID: <7v62svvdjo.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
 <7vvd0xvsjc.fsf@alter.siamese.dyndns.org> <4D501983.5060508@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:41:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWxJ-0005v6-GC
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab1BGTku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 14:40:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab1BGTks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 14:40:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C8C03731;
	Mon,  7 Feb 2011 14:41:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1TQQVKMy6wCCQfKtOnCISTcZkM=; b=V2ZP8x
	t6CkzzblQYB5qX4JklFudTwvPLfM5buCMuMDQ75szyIUdQnhDCrJTjWUsPVf5PVf
	ALFOTKLrJsg57q15QLzCKTzftgO6tIo2qMJx09/h7BKm3G03/kJL1URD5aIO9uKV
	1E5/VFJuBw4g+Az21n2U60grwhH4eVSS7PWXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uuAWf/0irDEWVtHrFL+hvBPm2am+UoJO
	VopsIlbbXw2Lj2jasMO0xKz0/B7V1auL5JtZMgZsLM4WfVRO9kwvg2qhtktAd4fE
	ZR1bfmiqB68j/aNlJ8jO6n4yhICqOKYS+CMBm5b6NJcgS/XN0mfKfhmNaAOnLD3r
	GJOY6f8/TsA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABB3B3727;
	Mon,  7 Feb 2011 14:41:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 03822371E; Mon,  7 Feb 2011
 14:41:26 -0500 (EST)
In-Reply-To: <4D501983.5060508@xiplink.com> (Marc Branchaud's message of
 "Mon\, 07 Feb 2011 11\:10\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 470C334A-32F2-11E0-9B33-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167258>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Tags don't become "official" until they're published according to the
> project's process.  For us git users, that means the tag appears in
> git.kernel.org/pub/scm/git/git.git.  A tag that appears somewhere else can
> have all sorts of meanings, but I don't think "official" could be one of them.

I think you are essentially saying the same thing.

Think of hiding the unofficial tags to refs/private-tags by "interim
maintainer" (or public at large for that matter); they won't be published
automatically, unless the publisher decides to publish "according to the
project's process."

As I said in my message, it feels awkward to use refs/private-tags for
tags everybody uses for his or her own purpose, so by swapping the roles
of namespaces around, we would be able to use refs/tags for private ones,
and refs/remotes/origin/tags for the ones that came from upstream.  But
then if you fetch/pull from a third party (including the "interim
maintainer"), it feels wasteful to get full set of tags that you have in
the origin namespace anyway replicated in refs/remotes/interim/tags.

And that is what bothers me---not the waste itself, but I have this
nagging feeling that the wasteful duplication is an indication of
something else designed wrong.
