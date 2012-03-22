From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 16:53:42 -0700
Message-ID: <7vlimsur95.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl>
 <20120322225747.GB14874@sigill.intra.peff.net> <4F6BB425.2010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Anjib Mulepati <anjibcs@hotmail.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArpH-0001V9-2C
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417Ab2CVXxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:53:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab2CVXxp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:53:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DBB66B05;
	Thu, 22 Mar 2012 19:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2mBuXLhWjiYW6RdxosqSerRF+KY=; b=YWu2v8
	ZL5UL0QwENakEn/jgozzdE3+x0+YbG2hgXhBjxjmi6uJ48SjhfhYOVNZ1ntOb6Wn
	nzm/VGjMqLFMAvSw5D7kYRpuefsQ5Vs2os/5G40ay/r0byjjpDVuymmVlk1LaNyx
	Qr5caNG4NMv7lPpqbli8oHV/Xcvm7bCPKR4N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WcYww2slXKhg/KwHxrr9sFQiZNRC4avY
	Rpqsosm/PNgLPwHwaoB6kFKY2FC0DcnsOZcgZ724X9ZrPPePVpraLcBrvWJLqoNI
	PisZA/veswARmhgfgLGqNqoVAyQsHlT8cgA9EXNKfaMMKBbvWpywijOgHytn3hoM
	appcanYZhWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A766B04;
	Thu, 22 Mar 2012 19:53:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29C496B03; Thu, 22 Mar 2012
 19:53:44 -0400 (EDT)
In-Reply-To: <4F6BB425.2010807@gmail.com> (Neal Kreitzinger's message of
 "Thu, 22 Mar 2012 18:22:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 421C8108-747A-11E1-8943-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193734>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> See this thread for the "cons" of nested git repos: (I don't think
> there are any "pros".)
> http://thread.gmane.org/gmane.comp.version-control.git/190372

Hmph, I see you saying "I will keep this in mind" and "Thanks" at the end,
and back then I took it that you understood why/how nested working trees
are useful.  Perhaps you didn't and I misunderstood you?
