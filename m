From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Mon, 05 Sep 2011 12:34:05 -0700
Message-ID: <7vwrdmbx76.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
 <7v62l7crpg.fsf@alter.siamese.dyndns.org>
 <4E6494F7.7010101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	tobiasu@tmux.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 21:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0evw-0005Zu-2y
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 21:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1IETeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 15:34:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab1IETeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 15:34:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F09B14DAA;
	Mon,  5 Sep 2011 15:34:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2En2tlO3y5IgnFLfBTyQK+O5WLc=; b=HLDEP6
	xBdT5BOD9iY0oaBWyIANQH9Mjba86OnAQggHn/gizND3kOfUAOIqa67+pnO7itJX
	U8lyEZfbtktrFt27It0IS02ka9ZFmbJCHgjcDAyZaUYgDOYZ7Mk1FB5so3HUYdni
	Ni0x1Mx8lDpW6RdgUqXh6Sy2ATSkeYO7geZ6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pv6mYPx1omfyH8fFHHFHnV391iv9UOUG
	FAHbURvnGMmzaH8kn/sEdoNR/9XaD1EYFVdOh+IFoeIHn88UaTbggMkVYqjkvZHw
	a4flE9noABFGJPVYMivvSVqxvydLwjA/LPdneYEF54yY7wwezI8yx+GSp8C1n+dq
	HmOtBU7NlhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E84AE4DA9;
	Mon,  5 Sep 2011 15:34:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BEB64DA7; Mon,  5 Sep 2011
 15:34:07 -0400 (EDT)
In-Reply-To: <4E6494F7.7010101@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 05 Sep 2011 11:23:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 057E18D6-D7F6-11E0-B188-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180755>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Being cc'ed makes me feel guilty but I don't know what for...

No guilt involved. 28d836c (test: allow running the tests under "prove",
2010-10-14) made you a good _suspect_ for having more clues than I do to
resolve it, iow, it was asking for help, not pointing any finger.

Anyhow, thanks for a quick workaround, even though I still do not
understand what the issue is (that is, what is wrong with the
t/lib-terminal helper).
