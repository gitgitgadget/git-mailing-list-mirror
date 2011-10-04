From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Tue, 04 Oct 2011 08:22:59 -0700
Message-ID: <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20110930114220.GA742@zelva.suse.cz>
 <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
 <20111003104112.GE16078@sigill.intra.peff.net>
 <7vfwjaggd2.fsf@alter.siamese.dyndns.org>
 <20111004103056.GB11236@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 17:23:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB6po-0006d5-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 17:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681Ab1JDPXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 11:23:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513Ab1JDPXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 11:23:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E9D4AA5;
	Tue,  4 Oct 2011 11:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R2pR+xy153H8Jo68V/V9BL725V0=; b=AGvz2z
	X0dQ3S1JohMcbJhavIOCTGD9/YqO3L+l0vjwl8rfNCwCSUEqmQUsvYYfh8fW/0v4
	m82xh/R29Vfesl4rEUwpF89HjlVOknRK/uBIPVlyV5oL70KN+wFELsF0QzYCTOv3
	C/Lf3YHA3mQe9AuHAQMirz2YrfTprtg03mvNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AYfn6WE6Zh+zRm0NG+zCmqwOI7gpO9xY
	VrtNYzarepV8MBCfds+9aL/Fb93IsJj0vWIwPOMSo5Ig3Yul+J4auaF+ZPLDCynF
	aanesQm2HMSwHsHWXWaNxfScw8S1iZNkeBg8bzsl5ikzk7Q3o5ZVPK/ayWNl+rwm
	JyWM/rD5n88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 773294AA3;
	Tue,  4 Oct 2011 11:23:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB64F4AA1; Tue,  4 Oct 2011
 11:23:00 -0400 (EDT)
In-Reply-To: <20111004103056.GB11236@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 4 Oct 2011 06:30:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF190A50-EE9C-11E0-85F3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182775>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2011 at 10:00:25AM -0700, Junio C Hamano wrote:
>
> And the --started-to would literally be implemented as flipping the
> meaning of "git bisect yes" and "git bisect no", and nothing more. IOW,
> it's just another way of spelling "git bisect --reverse".

Yes, if we wanted to also implement the flipping of the mapping between
yes/no and good/bad, I do not have any problem with --used-to/--started-to
pair of options.

Thanks.
