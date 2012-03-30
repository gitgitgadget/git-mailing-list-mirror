From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: treat inaccessible directories as ENOENT
Date: Fri, 30 Mar 2012 09:18:24 -0700
Message-ID: <7vr4wam59r.fsf@alter.siamese.dyndns.org>
References: <20120330075217.GA8384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frans Klaver <fransklaver@gmail.com>,
	James Pickens <jepicken@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeX0-0007fC-7z
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284Ab2C3QS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:18:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934255Ab2C3QS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:18:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 447705421;
	Fri, 30 Mar 2012 12:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RyR3Hq6Xvmuxiy3oX7IXqQM5OX8=; b=pYQpIq
	nCXdeYyQGmxVmwGsBwbFxB6JigZZ766LdlGdEnlYzv2SfOtSBP4t/826fEA5A5wi
	fNFineAUgInVuA4HhoY1mpxG/h+5v1o0WZjiGVGuZVOkE5sfP7rcadUo5lYWAr9e
	w1hRgqMLIwybUvGxxpFuw45Y1ACZ78Enp6Z1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPQl5FkkSYJDEznqPamjQ9hDQCzXexSy
	WBe2juCpAHi61VqFXLthlNUKsvhMBibJtn43T08QDzyHxNThk/tiCWLk/JJsXsfx
	10e9jJLi/43fVJJpS88AtAojfLGvlfi0HSbhqkUqGy4k6YUy19hoYI8xfloAWGzU
	hc7VvTbviDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 395A65420;
	Fri, 30 Mar 2012 12:18:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE633541F; Fri, 30 Mar 2012
 12:18:25 -0400 (EDT)
In-Reply-To: <20120330075217.GA8384@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 03:52:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA58F5C6-7A83-11E1-BCBF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194374>

Jeff King <peff@peff.net> writes:

> Here's the patch we've been discussing with a commit message and a few
> minor modifications:

The change to allow the result of "locate_*" usable by other callers makes
sense to me.  Thanks.

Will queue.
