From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 13:34:05 -0700
Message-ID: <7vr4q9mxc2.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <20120910161904.GC9435@sigill.intra.peff.net>
 <7vpq5told4.fsf@alter.siamese.dyndns.org>
 <20120910171954.GA15583@sigill.intra.peff.net>
 <7vhar5oemu.fsf@alter.siamese.dyndns.org>
 <20120910201115.GB32437@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAgc-0003MS-En
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab2IJUeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:34:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab2IJUeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:34:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84E548CAE;
	Mon, 10 Sep 2012 16:34:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yECZDwEqKVSzjIDcAY8v6XucHRI=; b=e9EbI+
	468jK4fV+htJy5XQlTHnFBBuZYnc1pZI/F9y1HMsWQayZ02L0y5McOxtJpMHjXIO
	7Ny94JlUT9HL1FZFVjo5WI8MwRl5EgsiWPIQ/2AwIjG94Rdty13BXPLCr3LAIQ1P
	j5MEEp3ktjIaDNE3iD2syj4pE1VJivqcFFoBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SGWN7A2KadMz6kVu/iZKN8eItRUatDCd
	spbVl3xCq0PkMw5nlcMs14LCtg7+o+H2GpqYgvvTefRfTke18QeZbh4xmofLMjWn
	PmOb8xfvUIZ0ikxFTvZ6UQsICSdWApojjWPZyoExOSqM7+fwXvsEoOAw/fTeIk5r
	aRat7KLrvL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 720278CAD;
	Mon, 10 Sep 2012 16:34:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E812D8CA8; Mon, 10 Sep 2012
 16:34:08 -0400 (EDT)
In-Reply-To: <20120910201115.GB32437@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 16:11:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF5F74F0-FB86-11E1-8DCB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205176>

Jeff King <peff@peff.net> writes:

> Hmph. Isn't that what I suggested in my first email? :P

Until I read the current text I did not realize the trailing
paragraph was to apply only to point C (no "--" disambiguates and
throws errors) but somehow thought it was covering both point B
(with "--" you are strict) and C, and I didn't think of a good way
to incorporate it into both.  But yes, the final patch ended up to
be exactly what you suggested to handle the issue ;-)

Thanks.
