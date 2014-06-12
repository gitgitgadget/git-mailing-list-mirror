From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/17] store length of commit->buffer
Date: Thu, 12 Jun 2014 10:22:44 -0700
Message-ID: <xmqqmwdi6o0r.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140610213509.GA26979@sigill.intra.peff.net>
	<20140610214616.GA19107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iL-0007rj-5t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933525AbaFLRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62358 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933509AbaFLRWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:22:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFD9C1BD94;
	Thu, 12 Jun 2014 13:22:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CPComO9CwuJdw31WAUa+dNM0BXc=; b=vhSzwy
	UggWTogN3LgpLXqLESLvpRQft9hr/aNqcs1ooltpQhcjoraL1s6ajt0520PT/TaM
	VHuQt1++1lDg5D7l9ipx7ch9shYeSq20tCDGr7L2/hHndv8UQ2dxVGrDxGPEgU9W
	a+zKH3Fj4utIAlLBTV9lfimRZvk0ZwtkYqnig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+7ge/kT1me0NKI5kcqgOouI1bNB6Mgd
	IK7TvezBR8LMEMSnfsK4O0McTOIUdH6cTONee5GoVw5+RcEzB0h35NbEzijSkmiY
	YvWXWd79+cqNs+Q9qu7NvJP0QfwCLhn3NbbH3kx+h+FtDEtOCX2gsWDddKj1B90S
	MzrrtCub4Ng=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B21BA1BD93;
	Thu, 12 Jun 2014 13:22:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A2EA01BD8B;
	Thu, 12 Jun 2014 13:22:45 -0400 (EDT)
In-Reply-To: <20140610214616.GA19107@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 Jun 2014 17:46:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B2E2288-F256-11E3-AE73-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251437>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 10, 2014 at 05:35:09PM -0400, Jeff King wrote:
>
>> Here's a re-roll of the commit-slab series. It fixes the issues pointed
>> out by Eric and Christian (thanks, both).
>
> Side note: I marked this as v2, but forgot to do so in each individual
> patch (I write my cover letters first, and then issue format-patch as a
> separate step, and I sometimes forget -v2 there). How big an
> inconvenience is this?

Not an inconvenience to me (I do not speak for others, obviously),
but they look a bit confusing to me in the thread list in my MUA
(but not too annoying).
