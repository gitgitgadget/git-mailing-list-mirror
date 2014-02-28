From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: add archive.restrictRemote option
Date: Fri, 28 Feb 2014 09:51:42 -0800
Message-ID: <xmqqa9dbw2fl.fsf@gitster.dls.corp.google.com>
References: <20140227040504.GA2242@sigill.intra.peff.net>
	<xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
	<20140228090709.GB11709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:51:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRbC-00009T-7O
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbaB1Rvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:51:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbaB1Rvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 12:51:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A06DB6E38A;
	Fri, 28 Feb 2014 12:51:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WoQRgCIR2KDnVHOtpUzTAEjIk38=; b=pkXRV1
	+CB+HJlieZq0mi6UlIyav1gwvhbVO2y+l03mDHWWM+QRXQR9lloU4CbhnAm4pXqB
	P3Xr02BuyIIe3M1RbPrlUkTafTKRml7j39IeJhgFfFNRlxj/NOgpJ9TlSfrgEK9U
	SB2+rsEznTfIvaXWfzrcK3l7mXQ5cghyd0D8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gRezYk2vBE2X4y1w+vUIXAD0h8sGmusz
	bO+Cbs6TA7FQgnAxNGe5/S95rhXPo25fPqwOqcmtrmBvB0BNkR1VsRNMGt3IerTL
	xPQHBbbibFAjzg9acOlfCiSJYiVPzhh/m2/c+hZW42MjOT5W7G91OtVeFujCDfGl
	hk6Pd3FWuzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D04B6E389;
	Fri, 28 Feb 2014 12:51:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C92B36E388;
	Fri, 28 Feb 2014 12:51:43 -0500 (EST)
In-Reply-To: <20140228090709.GB11709@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Feb 2014 04:07:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC3D86AA-A0A0-11E3-B667-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242996>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 27, 2014 at 10:37:30AM -0800, Junio C Hamano wrote:
>
>> > Signed-off-by: Jeff King <peff@peff.net>
>> 
>> Thanks.
>> 
>> Do GitHub people have general aversion against signing off (or
>> sending out, for that matter) their own patches, unless they were
>> already active here before they joined GitHub, by the way?
>
> Mostly it is that I clean up the patches and commit messages before
> sending them out. Michael sends out his own patches because they are
> already perfect by the time I see them. :)
>
> I can certainly get S-O-B from GitHubbers, but my impression of the DCO
> is that it does not matter...
> ... A S-O-B from the
> author would perhaps make it more obvious what happened.

Oh, I was not saying the practice was not legit.  It was just that I
expected a bit more from GitHub, a leading company that evangelises
use of Git ;-)

> I was hoping to be vague. If we really want to get into specifics, we
> should probably document the current rules (refnames, and sub-trees of
> refnames). It might be a good thing to document that anyway, though. And
> by doing so, it would become obvious why one would want to set this
> option. I'll see what I can come up with.

Thanks.
