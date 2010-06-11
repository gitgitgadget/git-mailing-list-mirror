From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/18] Portability patches for git-1.7.1
Date: Thu, 10 Jun 2010 21:30:30 -0700
Message-ID: <7vhblakx7d.fsf@alter.siamese.dyndns.org>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100607154511.GA9718@thor.il.thewrittenword.com>
 <7vy6eqvhrq.fsf@alter.siamese.dyndns.org>
 <AANLkTilFx4FRa_7L2nSPNcM3RVOAKfPrhTE1tGDMKl7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jun 11 06:30:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMvtF-0005pY-27
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 06:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0FKEak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 00:30:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0FKEaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 00:30:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E36F6BBA8E;
	Fri, 11 Jun 2010 00:30:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Snt0zTjQukXMvwVH4Xo5y00jcs=; b=D9WAEl
	p++zF4g7JxviCMtaqpDdpZIMKqIaABUZrvsOH2yJnElafNmmo06nUiCz/2LEdYXr
	yKm6lvaErgRtOXQvMFejtIhAEt8o5My1CiLx4/VW6fD8yRKdad4AjMNSHr6hRX7H
	9eDnwD1Lr1kbbwv4+xOTPdbxrWJWsHfbU0qM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5i8e5bUDw/V9HwTwfVYgIeXdAr+oYan
	HNFBLAoUMWfTuqSqzPe8A26t9VdcZdtDg9fJUhXIRP/hr+JsNaBtQOfVsEGIFWOt
	/0ExcCp53XKr60emVHDJMmYw97bKXDLbT64AXZn+o0epoN8g3wA/fqysr5ghLux+
	swnRW0Ny5vc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB843BBA8D;
	Fri, 11 Jun 2010 00:30:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB59CBBA89; Fri, 11 Jun
 2010 00:30:31 -0400 (EDT)
In-Reply-To: <AANLkTilFx4FRa_7L2nSPNcM3RVOAKfPrhTE1tGDMKl7f@mail.gmail.com>
 (Tor Arntsen's message of "Wed\, 9 Jun 2010 11\:37\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 146925EA-7512-11DF-BC1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148923>

Tor Arntsen <tor@spacetec.no> writes:

> Talking about 'next' and this patch set, I have a patch that goes on
> top of Gary's patch to the Makefile, to make Tru64 compile also
> without ./configure (i.e. just 'make'). Should I post it here as a
> diff to 'next', or is it better to wait until the cooking patches are
> in mainline and take it from there? (My patch may still need some
> discussion and tweaking w.r.t. what's enabled/disabled by default).

It sounds like that your change would depend on Gary's patch (rather, if
it is done independently, it could cause unnecessary conflicts).  As the
gv/portable topic is now fully part of 'next', I think the easiest would
be to base your topic directly on top of it, iow, on top of 09ce4bb
(build: propagate $DIFF to scripts, 2010-06-05).
