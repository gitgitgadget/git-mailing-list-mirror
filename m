From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 11:52:28 -0700
Message-ID: <7vlihmk2ab.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
 <20120810174605.GA29113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzuK6-0000Pc-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236Ab2HJSwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab2HJSwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01A599DC9;
	Fri, 10 Aug 2012 14:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mam1EjeRAYHJI2S9uXKXpLbUUUs=; b=D24N7j
	0Wqm+Dmm2tOXykUO3eqfMlAtcJxOvXv51wZGmCg2PulVN1uJ31tgCWgzJa3ZX9dG
	PDHpuXYSUdKpq4IyeTV4rLW+B8tmJ/L+BSHB8uqsGrYBEz0G4MfMwvvcpExqmfjZ
	ptCM0acwYkN1gkvkKnN6wE02gY0fc5imry6so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VYuxqU79kLAr1L7dT2wxpAFC5/wwl8zy
	p2Vg+fmVYjp48XiLDvPR/PK5cYDaHtVfteuFGf42m7VvLONQNRBpaAVSDJia8RSx
	8MEYADPEMSrlMyzkX5Wz7Bf0SRJ2qDqo/fIiDnB4SfUWOXDrnUayVzyHFdvFVemt
	GVbBFmBJK24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F339DC8;
	Fri, 10 Aug 2012 14:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63B609DC7; Fri, 10 Aug 2012
 14:52:30 -0400 (EDT)
In-Reply-To: <20120810174605.GA29113@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 13:46:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 898D76D0-E31C-11E1-9169-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203247>

Jeff King <peff@peff.net> writes:

> Thanks for confirming the push side. I have been running with the patch
> for months, but only recently happened to try cloning something from
> code.google.com.

Note that I didn't "confirm" the fix.  I only confirmed the
existence of the breakage (not that I have any reason to doubt the
competence your "fix" patches were made with).

When evaluating a change in the interoperability area, it does not
add much more confidence to the correctness that the change has been
in use for months with the same partner than that it has been used
to talk to many different partners even for a short period of time,
I guess.

> It was pure coincidence that it happened at the same time you were
> graduating the topic to next. But I'm glad I was able to catch it before
> anybody started complaining. :)

Yeah, the problematic one is not in 'master'.
