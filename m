From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: reword in-editor documentation of "exec"
Date: Thu, 20 Jan 2011 12:59:45 -0800
Message-ID: <7vy66fqoji.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino> <20110116020132.GB28137@burratino>
 <vpq39otrvmk.fsf@bauges.imag.fr> <20110120200949.GB11702@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:00:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg1c3-0006It-LP
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1ATVAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 16:00:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab1ATVAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 16:00:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 710943A36;
	Thu, 20 Jan 2011 16:00:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lPG+QScjohkye4HNb2kn1HxGq1k=; b=EiaxfZ
	83r04SaGfm7kPR2V+8hFOYf4mKzdwYjrex+7ZOgmuEhC8Jz/eP5p2btwceTa93Vh
	H3quS3YTfPFfKAI9rsd6BdfLyzCLeBSdT+6kKg3OY2CSL7E3D8fjMRTHUiRMx6db
	gd2yUqdUgsv4DJ/j0mSdWE4hLVrSJ4gMcUpDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lT7nV1hoBAum7/yaFQExOqN7P5BUkVPQ
	dZegX07jkvXjAHSg146sEdtP9fGKvgC7RIK8x0qUAgOyffmibuPzaffGvJkZCdU7
	CsbPp4Kk914UJC4NPZc7WEWGKuj1xVxGy0W8+3LR3p17i0RkSEMDdFbdadCeBoeI
	pwY/hdmxHxQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F03D3A34;
	Thu, 20 Jan 2011 16:00:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E72443A30; Thu, 20 Jan 2011
 16:00:34 -0500 (EST)
In-Reply-To: <20110120200949.GB11702@burratino> (Jonathan Nieder's message of
 "Thu\, 20 Jan 2011 14\:09\:49 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5811ACBA-24D8-11E0-A195-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165336>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe "exec" should be explained outside this table?  For example,
> maybe something along the lines of
>
> 	 x, exec = run an arbitrary command (see below)

Ok, none of the other insns in the insn sheet mention what the argument to
the command means anyway (e.g. "p, pick = replay the commit" doesn't say
explicitly where the commit comes from), so I think the original patch is
probably fine.

If we wanted to be more helpful, perhaps s/(see below)/specified on the
rest of the line/ should be sufficient without adding extra lines.
