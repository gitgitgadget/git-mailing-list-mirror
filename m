From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 04 Apr 2013 16:33:39 -0700
Message-ID: <7vd2u9g9bg.fsf@alter.siamese.dyndns.org>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
 <7vhajlgabi.fsf@alter.siamese.dyndns.org>
 <20130404232903.GA27128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:34:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtfW-0007IA-I2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765340Ab3DDXdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:33:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763619Ab3DDXdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:33:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 946D8131F9;
	Thu,  4 Apr 2013 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fjzI+fiCkxQOtqlYLz09IAexvOQ=; b=JN+vqC
	l5Vibnh6vWA1PN+pqCzYc4an2DtooKyuUMR70Le8NYlMUsgw6rJQqkFOqKRIH66M
	ryJBMyDbZub2aSdjsSQPJVPhMZBkR96rWdBOAwjBVU3cgy2V1TapuYKVSj1N0nPp
	fl9VRcr1bZjUWFFAq1d1x0VBQl4QF9RydBtGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVE4CRNOZDVQH5wtEAzs16P54sKo9VwL
	92ThaCpacBdrhRhInd3G6RsJG6bnaujzAImki8t2DpzSw5RpUuQJtvoj7GFFJ66T
	mkc6aGs8JxnaXeCifqxnnDqfuDh25jQHs1v1d5UuZ5UW/WT7JPFRidEx2hXDAEgE
	ZZbkETcs7wM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C5F4131F8;
	Thu,  4 Apr 2013 23:33:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2469131F4; Thu,  4 Apr
 2013 23:33:40 +0000 (UTC)
In-Reply-To: <20130404232903.GA27128@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 19:29:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 151AF344-9D80-11E2-9F09-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220126>

Jeff King <peff@peff.net> writes:

> So let's drop patch 3. Do we want instead to have an expect_failure
> documenting the correct behavior?

I think that is very much preferred.
