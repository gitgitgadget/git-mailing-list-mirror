From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Teach gitk to display dirty submodules correctly
Date: Sat, 17 Apr 2010 09:53:55 -0700
Message-ID: <7vzl122f6k.fsf@alter.siamese.dyndns.org>
References: <4BBF8B2A.5090208@web.de>
 <20100417085600.GD6681@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Mark Hills <mark@pogo.org.uk>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 18:54:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BHt-0003o6-5v
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 18:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab0DQQyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 12:54:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0DQQyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 12:54:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 039D3AAEE1;
	Sat, 17 Apr 2010 12:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pr+f2YCfwP0qZ84gqThXzsmZj78=; b=tKfCqc
	fHhkEEfqWuM/tTXWHNeo/oT2mZI4c+t0nADqQli7hHkgWc1747CLoz1f26EfPVUh
	+f6//50nV8myWoYsYZMwF8cmeVXrWquuGFVc2IJuuKaVBvmJwtPPv6xp6cYK3A2u
	8pGKtVACA+2txA6BRS/5vBPviMQSiHOF1rzVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=scd36TWA01EIjJ5vBf9WdxTb7U4OIGuQ
	OnfqPeXb/QT4eRF74uzsQB8AdRQcrVR2Y0KXduoCombIe5rrsapR/pnR8cnfGbjd
	qUC+JL6GylYV1ays72Q/80Y9nU6w4fhKNgzikIAHsGcoaAZL0XEVZjXoysT3Sl12
	M5uYy56dh/E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9411EAAEE0;
	Sat, 17 Apr 2010 12:54:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99557AAEDC; Sat, 17 Apr
 2010 12:53:59 -0400 (EDT)
In-Reply-To: <20100417085600.GD6681@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sat\, 17 Apr 2010 18\:56\:00 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5DD2830-4A41-11DF-A7CC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145155>

Paul Mackerras <paulus@samba.org> writes:

> Thanks, applied.

Thanks.  Is it a good time to pull?

Here are the list of things that I would be getting if I did so:

Jens Lehmann (2):
      gitk: Add Ctrl-W shortcut for closing the active window
      gitk: Display dirty submodules correctly

Jonathan Nieder (2):
      gitk: Add comments to explain encode_view_opts and decode_view_opts
      gitk: Don't clobber "Remember this view" setting

Mark Hills (4):
      gitk: Remove forced use of sans-serif font
      gitk: Set the font for all spinbox widgets
      gitk: Set the font for all listbox widgets
      gitk: Use consistent font for all text input fields

Pat Thoyts (3):
      gitk: Avoid calling tk_setPalette on Windows
      gitk: Add emacs editor variable block
      gitk: Fix display of copyright symbol

 gitk-git/gitk     |   72 ++++++++++++++++++++++++++++++++--------------------
 gitk-git/po/de.po |    4 +-
 gitk-git/po/es.po |    4 +-
 gitk-git/po/fr.po |    4 +-
 gitk-git/po/hu.po |    4 +-
 gitk-git/po/it.po |    4 +-
 gitk-git/po/ja.po |    4 +-
 gitk-git/po/ru.po |    4 +-
 gitk-git/po/sv.po |    4 +-
 9 files changed, 60 insertions(+), 44 deletions(-)
