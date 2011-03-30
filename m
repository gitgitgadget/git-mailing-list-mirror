From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 3/3] Alternates API: Remove unused parameter
Date: Wed, 30 Mar 2011 15:46:27 -0700
Message-ID: <7vsju4kz0c.fsf@alter.siamese.dyndns.org>
References: <cover.1301521243.git.mfwitten@gmail.com>
 <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
 <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
 <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q54AF-0002Fl-Ev
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab1C3Wqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:46:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab1C3Wqh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:46:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 051125269;
	Wed, 30 Mar 2011 18:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nVXf8cMfgZ84gckbuo6+XtOrTc=; b=nXXrTr
	UUs3PVm1qBhUS3WV+ogUapjBxTkngFhx5GQRibfwhxHAeuv0vwep6Nga+fTCCDbY
	6R+mj6AnGqWOr1JvpWvW1qOztz8relpfFnu4YbmJk9HIsvKfqO8VqEalZIHdngWz
	vatAPMMn1SAhvpnXCME+fy5Qoj5/ltbeuwbyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVXyvh03Xx77Lv+pxMzQF4PvsO4KLrjv
	yLjaSVKWX9dtjKeZxcubbq3D9L1rVYmePKZzSYTmqSMEMTi6aEpPfiHJD1ylt/n+
	z4SKg/v9JLElFtCqFoZzkonhii6MbnSFRXRukbbBbYCCXu8B4IfnMC0L6J643vuK
	Ru1LYdm0byc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6E265265;
	Wed, 30 Mar 2011 18:48:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C96C55263; Wed, 30 Mar 2011
 18:48:18 -0400 (EDT)
In-Reply-To: <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
 (Michael Witten's message of "Wed, 30 Mar 2011 21:28:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D04E5FF2-5B1F-11E0-969C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170434>

Curious; why are your recent patch series all have screwed-up threading?

Here is an earlier one:

 [ 120: Michael Witten         ] [PATCH 4/4] Clean: Remove useless parameters from both get_commit_info() functions
  [  16: Michael Witten         ] [PATCH 0/4] Miscellaneous Improvements
  [  51: Michael Witten         ] [PATCH 1/4] Typos: t/README
  [  56: Michael Witten         ] [PATCH 2/4] Clean: Remove superfluous strbuf 'docs'
  [  21: Michael Witten         ] [PATCH 3/4] Clean: Remove unnecessary `\' (line continuation)

and this series looks like this:

 [  63: Michael Witten         ] [RFC 3/3] Alternates API: Remove unused parameter
  [  16: Michael Witten         ] [RFC 0/3] Alternates API
  [ 152: Michael Witten         ] [RFC 1/3] Alternates API: Untangle the interface
  [  99: Michael Witten         ] [RFC 2/3] Alternates API: Improve naming

Did we break git-send-email recently?  I would personally be worried more
about that than the alternates callbacks.

Having said all that, I didn't like refs_from_alternate_cb interface
myself.  I should probably have done for_each_ref_in_alternates() that
takes two callback functions, one that decides if it wants to deal with an
alternate repository given the path to it, and the other that is fed the
refs from the alternate.  Both callback functions should take the usual
"void *cb_data" in addition, of course.

IOW, something like...

	typedef int (*skip_alternate_fn)(const char *, void *);

	int for_each_ref_in_alternates(each_ref_fn ref_fn,
        			skip_alternate_fn skip_fn,
                                void *cb_data);
