From: Junio C Hamano <gitster@pobox.com>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 11:52:28 -0700
Message-ID: <7vobedewer.fsf@alter.siamese.dyndns.org>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
 <20130320170957.GA21350@sigill.intra.peff.net>
 <7v620mf05l.fsf@alter.siamese.dyndns.org>
 <CABFQKmONh2dQ+dkt3MsSXtFyKh5mnfK1fQVyw6Ez6aWajo=BDg@mail.gmail.com>
 <20130320183049.GB29609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Rodland <andrew@cleverdomain.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIO8G-0000Rc-NO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab3CTSwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567Ab3CTSwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2B6A67E;
	Wed, 20 Mar 2013 14:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GTZkWed+Kp497TOgwUiow3nE75w=; b=p2VI3m
	HePSpbgFkDa0DH3nWrlaT4X+Uk1trll3AgtiHzMOapH46ylKO2RATYVxv0E04Veb
	GlhvV/b9JC9+BKLYObyIY55lk6o1r5appNHvdvrIbcvZ8zOTAsyQqAz9bouH32+q
	AFE87RRUdQk07esvw/4RkfGmpaJAwMJJSMdhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWwWgaVcE37BYtR3PhI7yR8ENIX/zdlO
	zJlHnkxiMcOpteVFhSu8VvJWBuM/ioh+bKmS9lLC+i1wRREqHlzqkIstl2uqlFWj
	6jttahz5WRVD5ICqPCrUNaagfhAskqiuwQZQxIpazfHHSBl7+HAupUUIVWVyUXX3
	DGowpRfBFTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12A6A67D;
	Wed, 20 Mar 2013 14:52:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E87BA67B; Wed, 20 Mar 2013
 14:52:30 -0400 (EDT)
In-Reply-To: <20130320183049.GB29609@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 14:30:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5134B25E-918F-11E2-98DA-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218653>

Jeff King <peff@peff.net> writes:

> So I think your real complaint is "configure does not set NO_NSEC
> properly", which is something worth fixing.

Yes.

I think our "Meh" was about "do we want to unify USE_NSEC and
NO_NSEC?" and nothing else.
