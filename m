From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 03 Jul 2013 14:50:26 -0700
Message-ID: <7vmwq3cnz1.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<vpqfvvvq5bl.fsf@anie.imag.fr>
	<7v38rve6i9.fsf@alter.siamese.dyndns.org>
	<vpqvc4r751g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 03 23:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUwj-00011c-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307Ab3GCVub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:50:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221Ab3GCVu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:50:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040E22DE16;
	Wed,  3 Jul 2013 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D1awfBEGiG75ANuOUeAypqYdHZg=; b=V+03Hb
	HfuNrwkFy+Rdi3XcwUfuusaSpcJoSVU8JOj3MdYJ9SL4h7AmS9+4YNXQBCcW8+DY
	zFvz1iF8pRXzk0saeKgWbbp+tU9LX3LJjc2ORkU3IP++xA01MMc0lRQtzno03RCy
	FBh9rEQb8V1HLfuhW/r02nlQWelkWhDOX0iMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aT18c/l0p2zq2pmOs3x/WrHuDOb6dQJC
	QgvFC8vw8TXalcTqYK3HQZWRNRCU+GCUGnMPqJUkfiyjFYcMgIrsazc+pb2brOlX
	veaFApWU7o5G4/tbKJTdJaucLWiSRfSguPXImewH6PD1wDgMHA31O9c7DLy+M1Og
	ck8axCwm404=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE83C2DE15;
	Wed,  3 Jul 2013 21:50:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73FB52DE12;
	Wed,  3 Jul 2013 21:50:28 +0000 (UTC)
In-Reply-To: <vpqvc4r751g.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	03 Jul 2013 22:38:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93415538-E42A-11E2-861C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229536>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I don't get it. It Git Mediawiki's tests, the tests scripts source
> test-lib.sh, that unsets GITPERLLIB. Then, it calls the
> mw-to-git/bin-wrapper/git that sets it properly, and calls the
> toplevel's bin-wrapper.

Ah, OK.  I somehow was assuming that a wrapper sets GITPERLLIB to
point at mediawiki stuff before running tests, which is the other
way around.

Please ignore the noise, and thanks for a dose of sanity.
