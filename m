From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: do not require write permission
Date: Tue, 19 Jan 2010 16:39:13 -0800
Message-ID: <7vhbqh7gpa.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
 <20100120002836.GA16824@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXObd-0006Tu-WE
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0ATAj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608Ab0ATAj2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:39:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0ATAj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:39:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33396921C4;
	Tue, 19 Jan 2010 19:39:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ra2rITx+bIqlzST2SWKGVMlBtAU=; b=U9FR/W
	9BkuyqZ8YqTwmFX0ODoWUuvqmx5fskaKDuIK6fgiN6ZiGF4/GjDGIZtzCuWFxYaA
	ycV5baF+UPWyb4Ndp6N2WVZxaucaYkU8xZn0/4yV3hciQCWT2Sdo0jo7h8enx1PP
	Q470+oIzs4qPVpykfMUnt9CdfvyMoJnXLTnVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLQZEZsSfWH+FpFEijNeJzI7EMCOuJ6Z
	YjpGUufiHXuJf81BAGZcCB6nXKXbqWW3ebKE7l2zxXPPiSMmc25V/7dDGuhPkTFf
	YVZovnZM3qwc9tmdRJaE6t3AJGNEw3cIIW9RRCtwu8uZ3II/MJp1+z5PqZWm21VO
	jwS6wLAk/Gs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F3C921BC;
	Tue, 19 Jan 2010 19:39:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28298921A5; Tue, 19 Jan
 2010 19:39:14 -0500 (EST)
In-Reply-To: <20100120002836.GA16824@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 19 Jan 2010 19\:28\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F32DBAC-055C-11DF-A299-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137508>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 20, 2010 at 01:06:17AM +0100, Johannes Schindelin wrote:
>
>> Today, git status played violin on my nerves for the very last time.
>> There is no good reason, really none, for git status to require
>> write permissions.  If the index is not up-to-date, so be it, I
>> cannot commit anyway.
>
> I agree it is annoying, but this patch does not apply (and is no longer
> needed) on master since the status-is-no-longer-commit-dry-run series
> has been merged.
>
> I don't know if it is worth putting your fix onto maint.

I think the patch itself makes sense, even though the log message seems to
be with more noise and frustrationthan with useful information.

And "for the very last time" is probably a good characterization, as
status will no longer be "commit --dry-run" in the coming release ;-)
