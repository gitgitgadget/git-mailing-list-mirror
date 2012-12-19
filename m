From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add directory pattern matching to attributes
Date: Wed, 19 Dec 2012 13:44:59 -0800
Message-ID: <7vbodp90o4.fsf@alter.siamese.dyndns.org>
References: <201212192233.53002.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRSN-0001tn-21
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab2LSVpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 16:45:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab2LSVpC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 16:45:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97DFAAE10;
	Wed, 19 Dec 2012 16:45:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FzBggMSbIiMA
	HvDv9eYT3PyFdbc=; b=xC+XYrcS6gztuwmUvhSYzdZg2uIGcqXBXmFVLQIsJKLA
	fkshFtbVL1RtwxtQE+Tl/EfEOM0l1n4jDJFWW6kNrLmlV5NnMxWf+3yg8AVYuG0Q
	fI6hbNygoFGYvbWQPFmdVZwZJ21XK0jC+b2yK+f+7VU2gaoYIoy1ppWObLnsjDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UZ2QLf
	whgses38Rj88LvgL1Fu+z4D1K1U0C1sXjpPM2DinfDJixMOoMUYiON7EbXNAgAVE
	cPr8BXK94H7GXgE4SzzRnG9pL6mTRQUPL2YbfYBawtrqNiyZhGkhYXMPNyNYJ7Qo
	YFhxiUysmVzR2e/y9543Xtt2HyqN/ikbCpuZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85701AE0F;
	Wed, 19 Dec 2012 16:45:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0662CAE0E; Wed, 19 Dec 2012
 16:45:00 -0500 (EST)
In-Reply-To: <201212192233.53002.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Wed, 19 Dec 2012 22:33:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 571D9732-4A25-11E2-8A0A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211852>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> This patch was not reviewed when I submitted it for the second time.

Did you miss this?

    http://thread.gmane.org/gmane.comp.version-control.git/211214/focus=
=3D211470
