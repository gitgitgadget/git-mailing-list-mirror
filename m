From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Sun, 13 Jun 2010 22:33:42 -0700
Message-ID: <7v7hm2ch55.fsf@alter.siamese.dyndns.org>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
 <20100612062812.GA12685@coredump.intra.peff.net> <4C132C7E.5090606@gmail.com>
 <20100612071850.GA2765@burratino>
 <20100612081925.GA19525@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:34:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2JA-0007bT-J0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab0FNFd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:33:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab0FNFd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:33:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34FEABC6C8;
	Mon, 14 Jun 2010 01:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iB6G+s53ebvMVUKsXXSomsAOTFk=; b=QI3nMYKnXSYnqWi4fXDY3dw
	+PvUc1iCCppbwozVqo9wRF98P6kvU3rk4pYZbXsjEsZcBqfTPsyIn3E3Ym7uDcMH
	befqvZt/eaDtbfHe8asdK95RbGsSp4EZXTYX797JIpSWv+jDfK4Rnd77lrpxXGnz
	8wDvNWhB6QIRArbmHkjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gThHOHtpyaPuCgwJ04bfgT3yMxQVmHW5nZCH72GDJJMZsf5yf
	68ukz7kmzA2l9o5E3blOhmC+6zqk9IdEOIrelRGkCVDrJKDREDPkG2s6HALNcIuf
	1E7M4MNtckUN3HgtyhzGEUl2VUHf93PMDHWVfaTpm/mbpi0AtQab1OkCIE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDFF0BC6C0;
	Mon, 14 Jun 2010 01:33:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B726CBC6BF; Mon, 14 Jun
 2010 01:33:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69AB7808-7776-11DF-B96B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149073>

Jeff King <peff@peff.net> writes:

> You can use the much shorter "%B" instead of "%s%n%n%b" these days, and
> as a bonus, it will use the right number of newlines for a subject-only
> commit.

... or "%s%n%+b".
