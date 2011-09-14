From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] credential helper super fun pak
Date: Wed, 14 Sep 2011 14:37:39 -0700
Message-ID: <7vlitqst3w.fsf@alter.siamese.dyndns.org>
References: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 23:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3x9Q-0005oD-2P
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 23:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933378Ab1INVhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 17:37:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933341Ab1INVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 17:37:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFEF0550E;
	Wed, 14 Sep 2011 17:37:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWanM7o07PzK9jpDNak45nUrQUY=; b=gy7Nab
	Dk6NgvJPn6JG8V2dgPt379DBP7wxUidAE+acV7Hegt0WkBKyl6grxTcrWDQtIaru
	TUPQ1n93KZrxtYRb8PhFot9ChpH4PxY/jlV3BE6k14sQfRjTVXa09mMAR/CupFIo
	NnfeZujv6jV2iVlnQFQkuv1WXS/QjHsyCwWFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XNaygo8uA/Y1fLpsQyq6zU2qD+Nqz87p
	QP6Gxo3KavmtFlesjO5CQOioJxQBH07QiES0rhjusRxXcUbwgfAu+1zLSZMKBw0U
	J3qvPyBHfiy4pv2u38lt5okiGF/V/WEGVAe1XoZ7CFfSPE4Y5NSUEPyGtpYx8Avx
	egCETkfgQ+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6C46550D;
	Wed, 14 Sep 2011 17:37:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 453C7550C; Wed, 14 Sep 2011
 17:37:41 -0400 (EDT)
In-Reply-To: <20110914191704.GA23201@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Sep 2011 15:17:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C62A38B0-DF19-11E0-AA8E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181403>

Jeff King <peff@peff.net> writes:

> Here's a mixed bag of bugfix commits to go on top of what's in
> jk/http-auth-keyring.

Heh, it indeed is a super-fun-pak. Will queue.
