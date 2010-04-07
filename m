From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Clarify Gmail section
Date: Wed, 07 Apr 2010 12:09:46 -0700
Message-ID: <7v8w8zcc5h.fsf@alter.siamese.dyndns.org>
References: <s2kf3271551004071052o58656534z80de5068b207bdb2@mail.gmail.com>
 <t2of3271551004071108ic4393a8v3ae9929f01b8c086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzadg-0004fA-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab0DGTKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 15:10:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab0DGTKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:10:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17EB4A8708;
	Wed,  7 Apr 2010 15:10:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s8FThW4n3kRkESXbXbAMgdagcdY=; b=sNQUUt
	YJKQd/3RfR1/pccB+2ejbcFcOlYABStve1PGjSulGffd6kFywe78IYhuUgcDQIk+
	UWRzV/WUnBfdEnGRmrtbceVGn6XSE5gUOZcDuIqoTQbGX1tMCZt2gOfQyU3kqsuw
	0EqEfKBseRldgXWJLuiLHIL7H+Dy3Cfzfze0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehnG/iCzH33c0GMADeYdk6zv1fyErODd
	MjNud9zM4v5IjnW2ywuzgdR8da8Plp+JLAWNh8Oy4dpZpHLIVLC4M3WHIEV2EvVY
	ifsEJmKejCQw4RgzdJ5AZZvwMUYwMLNS9DoRbzu8yOaLyiDoxpaLhTyWBR03qE5k
	eMUpCW7pMmQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FF7A86FC;
	Wed,  7 Apr 2010 15:09:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CEB6A86F3; Wed,  7 Apr
 2010 15:09:47 -0400 (EDT)
In-Reply-To: <t2of3271551004071108ic4393a8v3ae9929f01b8c086@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed\, 7 Apr 2010 23\:38\:49 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26537286-4279-11DF-AA46-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144271>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I can't be sure that I'm right about this. Could someone please confirm?
> Ironically, this patch seems to be broken. I think it has something to
> do with the auto-save (for drafts) in the web interface.

Didn't I already say that it is _known_ not to work?

As you earlier said that the documentation of imap-send states GMail web
works, perhaps that description is incorrect and needs fixing.

See the thread that begins with this message in the archive:

    Message-ID: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
    From: Aaron Crane <git@aaroncrane.co.uk>
    Subject: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround advice
    Date: Sun,  7 Feb 2010 15:14:02 +0000

e.g.

    http://thread.gmane.org/gmane.comp.version-control.git/139240
