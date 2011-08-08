From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I suggest that git commit support -A option, just like hg
 does.thanks.
Date: Sun, 07 Aug 2011 21:56:58 -0700
Message-ID: <7vfwlc1ox1.fsf@alter.siamese.dyndns.org>
References: <20110806150246.GA20650@jpl.local>
 <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
 <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com>
 <1312659297-sup-2956@nixos> <buoy5z4ed3w.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Weber <marco-oweber@gmx.de>, git <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 06:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqHu2-00079M-KO
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 06:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1HHE5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 00:57:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1HHE5C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 00:57:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183624A3C;
	Mon,  8 Aug 2011 00:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xst8wukSrGejiZQFl8LH3IQaulQ=; b=PGOBXE
	Wx32Wkl0xhVBOUfEx+7sByyZkk9ivaZSnXKhPtSdNDV22Cvsu19e5Mx93hyakQmj
	w9iVvr9/SeTpCGnPdWdQqZWPYVIrQTgAbBopPTxEkG/xw4zpapPFvfwtK5/11PSo
	lfMg1+YpS7PvnXsujsXKEuq4uVUIu7GTRoKWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjmKPQNjqX/HB86BdMeoZclJYHAjg10L
	2aR63W9NrCIS3jwffrOeZRvXMbd3WH7u6jCJLNlfZ6RWKrdWiYoQ8hyMzAqepS32
	tZIc03hyupEtH0KWQcvtQ1QbtVuyl/lhFC3mUCBJcVWodD1NH9RF+w/H6Ewhm03L
	67Zi+vNmzyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D96D4A3B;
	Mon,  8 Aug 2011 00:57:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8269E4A3A; Mon,  8 Aug 2011
 00:57:00 -0400 (EDT)
In-Reply-To: <buoy5z4ed3w.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Mon, 08 Aug 2011 13:33:39 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9CE2B18-C17A-11E0-96F1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178939>

Miles Bader <miles@gnu.org> writes:

> Remember:  "just add an alias!" is an acceptable answer only if the
> desired feature is odd/unusual.  For desired features that are likely
> to be generally useful, git should do the right thing, out of the box,
> for everybody.

The reason I deliberately chose to use capital letter in "add -A" even
when we do not have "add -a" was exactly so that interested parties can do
"commit -A" to match it (and "commit -a" is doing the _right_ thing out of
the box, and its behaviour will not change). Hopefully you can take it as
a strong hint that I personally do not think "commit -A" is without merit.

So far, nobody stepped up to do it, though. I have been taking it as a
sign that "commit -A" is not one of the commonly desired features but is
probably closer to your "odd/unusual". It's up to the user/developer
community to change that ;-)
