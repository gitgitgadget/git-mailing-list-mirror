From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Tue, 06 Aug 2013 15:12:51 -0700
Message-ID: <7vob9aeae4.fsf@alter.siamese.dyndns.org>
References: <20130511161320.GA14990@sigill.intra.peff.net>
	<20130511161652.GD3270@sigill.intra.peff.net>
	<7vsiymhjgz.fsf@alter.siamese.dyndns.org>
	<20130806214622.GA31766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 07 00:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6pUx-0008Id-8c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab3HFWMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 18:12:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513Ab3HFWMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 18:12:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C37D367C7;
	Tue,  6 Aug 2013 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AIxcBcHYr9kKhMJ5k4ZvACJrylQ=; b=ghVD1N
	g/5iM7WJA3mOLVQVnOHCRE0h1rnSSX0fXnKA6AecWCo+cmBbEf+EoWg7iZhup9HJ
	kJ5LiqgszEw0ZKwtAeYsyre7vEht+Dmby31b4KpesP99/y+Wucjl1yHz8QPsWdSC
	5qKvTt4RtDVoeKga8sFbHPwEq6z016pWxUJ6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wVTQU21F4KYsjfIrvrosrVFNg+JR/67A
	uL6Gi86KBK1FsfrMdz3jxe4SDP07yb47LY/iEeopZhsPx1+22LkAZLQ+StOyvxjm
	i5rZD5sXfjxHe7jKA6Zh1br+STMfJ/pKDsZTXr1F0VDuLyYciwtRL6ukK3V80jWY
	ewoTkKL3SoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40EA367C5;
	Tue,  6 Aug 2013 22:12:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69D8A367C2;
	Tue,  6 Aug 2013 22:12:53 +0000 (UTC)
In-Reply-To: <20130806214622.GA31766@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 Aug 2013 17:46:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56F5ACCA-FEE5-11E2-A1C4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231791>

Jeff King <peff@peff.net> writes:

> Two reasons:

OK, both boils down to "Junio did not consider 'master:foobar'
case".

Thanks; it makes sense now.
