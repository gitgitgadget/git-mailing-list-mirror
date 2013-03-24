From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Sun, 24 Mar 2013 00:14:45 -0700
Message-ID: <7vehf52rru.fsf@alter.siamese.dyndns.org>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
 <20130322182211.GD12223@google.com>
 <20130322183306.GA32448@sigill.intra.peff.net>
 <20130323000628.GM12223@google.com>
 <20130323080341.GA29768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Sharpe <josh.m.sharpe@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 08:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJf9I-0000uk-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 08:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3CXHOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 03:14:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab3CXHOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 03:14:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DEBC91A5;
	Sun, 24 Mar 2013 03:14:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lK3tkzKwvnAW2m70UOnyiWF84+k=; b=Lna/UY
	NO9VYf6FwsPMk/FpLfQzujzdlFBs6gH3dxgNPpvDB2cxd1Ys/ENc/j0OVF4f6hDM
	i0O6zYXsIo7Kc6i+oG239aR++A6tTYtSIjZNkWdgJRzRixuZe6ABNVT2fhKeMI+V
	0vjHob3MOEa62gPLimzoaxUb3ey/ooL1N6HDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aj+bvQMGtFxmV16MyRV4Jsd378zTVheW
	30v3V4qkJ67wTNb+U0pgc/9/yONK07+qvHlFsSbh/9g9rNsKnk6JrclcYtJLeFOS
	KsENpg3S/pKDHiMJJCZtuNdMdXQ4kUNIT9z5mNLmQ1Mff4jPVBvGQ+VRlngeSx4W
	TYwMSEBE35w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6376691A4;
	Sun, 24 Mar 2013 03:14:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCE6591A3; Sun, 24 Mar 2013
 03:14:46 -0400 (EDT)
In-Reply-To: <20130323080341.GA29768@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 23 Mar 2013 04:03:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82515EBC-9452-11E2-85E2-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218942>

Jeff King <peff@peff.net> writes:

> Yeah, I'm not planning to work on this, but I'd be happy to review
> patches if somebody else wants to.

I am not planning to work on this, and honestly speaking I would not
be very happy to see any patch in this area.
