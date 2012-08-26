From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: GnomeKeyring support + generic helper
 implementation
Date: Sun, 26 Aug 2012 10:46:54 -0700
Message-ID: <7vr4qtv94h.fsf@alter.siamese.dyndns.org>
References: <1345741068-11004-1-git-send-email-pah@qo.cx>
 <7vfw7cyx4n.fsf@alter.siamese.dyndns.org>
 <20120824213342.GB16285@sigill.intra.peff.net>
 <7vzk5kx8so.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Philipp A. Hartmann" <pah@qo.cx>,
	git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 19:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5gw4-0003Rn-QS
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab2HZRq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 13:46:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab2HZRq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 13:46:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ACAA86A2;
	Sun, 26 Aug 2012 13:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j8tlY9rzQvzTwkhkxdntjiAwM4U=; b=QW9fUg
	UQnu3qQjYX3S8XY69KQgctC7FwoRlCTOHrY5S9hX+8WMwXz/DIovwuLKXHLPY2Be
	qkvTEFCrYMfAe3/E+dZlTuVLrP1/EeLMtdek66C2kUwIcD24b+bEWrkQFPypCbG8
	SPezVr/C6O1HFM6LGWhbfwwf5ypUtAgQDc7fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=du9PNOKhMZ2F+G8ve7F0Vqiw8HRNWGoe
	tQAYF0qrDVmxQlb4WBfBkFzU5Y7vlsCzT8JDTU2pyfDuhU0JS+9j2hmlaAppFBDi
	YS2fZDnq27TqLyvecOG1x7rG9TekS3bVta73Hgw/1LvwmQUxvw3RgZvD8PBZ86Nh
	4n6oEdXtH20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085F186A1;
	Sun, 26 Aug 2012 13:46:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A93286A0; Sun, 26 Aug 2012
 13:46:55 -0400 (EDT)
In-Reply-To: <7vzk5kx8so.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 24 Aug 2012 14:46:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06C66860-EFA6-11E1-BCCB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204302>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> However, the shared bits are simple enough that maybe that is not a
>> concern. An interesting test would be to add a 5/4 porting Erik's win32
>> credential helper, since that is the platform least like our other ones.
>
> Very true.
>
>> So I am OK with this series, but I am also OK with leaving it at patch
>> 1, and just keeping the implementations separate.
>
> Amen.

Just to make sure we do not leave loose ends, could somebody try to
see if the new "generic helper" infrastructure is useful to shrink
Erik's win32 credential helper implementation?

If we see much code reduction and improved clarity, this refactoring
may worth keeping.  Otherwise it may be sufficient to drop the later
ones in the series.  Without knowing which, it is hard to decide.

Thanks.
