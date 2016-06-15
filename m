From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v2] git-gui - provide commit base to the
 hooks/pre-commit script
Date: Sun, 20 Jun 2010 21:54:39 -0700
Message-ID: <7vvd9drnn4.fsf@alter.siamese.dyndns.org>
References: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com>
 <1275965763-18940-2-git-send-email-mlevedahl@gmail.com>
 <4C1C3288.5000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jsixt@viscovery.net,
	spearce@spearce.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 06:55:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQZ2J-0004jK-DQ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 06:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab0FUEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 00:54:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab0FUEyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 00:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B04BD95A;
	Mon, 21 Jun 2010 00:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kA+spqKPXedt9iwLopueJDKiv2M=; b=PUm860
	mvJfWO8bS8PkxIpdIyYhk4Y/CYWioXEg56fTE+fObCzmGk0ruHsAepIXaV53MJOC
	ltPXcTJC/1MtPtToKKLp6e0G9+h7VlmVrfnJc7qZP4puOSY7saUwqFkPtYK1AueU
	lh7T81dNYPvE0VyKBQnoyxfYYnI+4b6yZcxd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z69z9cpzVL/A0BiFvJ04FdDhm62Exlo+
	idOGrjQY6gBW8KDrAKJD/l9O5wvRRaJi4j2hL5+b9j61DR1REw5ChGsRRWMIzwbT
	iaVV3BBE5sYjCk/RceKPpwjJnXo4ZjNqE1xwnjK1i0F3Bawdp9I9lCuPGlVDUQxJ
	P3+i+x6Hnns=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62CAEBD958;
	Mon, 21 Jun 2010 00:54:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7715EBD94F; Mon, 21 Jun
 2010 00:54:41 -0400 (EDT)
In-Reply-To: <4C1C3288.5000308@gmail.com> (Mark Levedahl's message of "Fri\,
 18 Jun 2010 22\:59\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DD340FC-7CF1-11DF-B4A1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149413>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Given the discussion on the first series (starting with)
> <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>, and the absence
> of objection to v2, I presume this sequence is ok?

I generally take absense of responses as absense of interest and/or
support, not absense of objection.

For this particular patch, I am mostly indifferent (i.e. no objection, but
no strong support neither).
