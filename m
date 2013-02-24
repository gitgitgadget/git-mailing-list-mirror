From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/13] Use 'Git' in help messages
Date: Sun, 24 Feb 2013 00:59:58 -0800
Message-ID: <7vr4k65box.fsf@alter.siamese.dyndns.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-2-git-send-email-philipoakley@iee.org>
 <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 10:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9XRg-0003DD-G7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 10:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab3BXJAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 04:00:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755109Ab3BXJAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 04:00:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70BEF9901;
	Sun, 24 Feb 2013 04:00:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+R6fz9McSdr4WVVoouIrlhx4T4U=; b=hYMTHv
	QxWIG/7OY/QEAfgJ9klKsQoYCNkLyMxs739jt5/jWptg/g1SMx19i+JLDDhsANzd
	SKQkMY9ZLaQQaZX7sjZPwj7Qnq3I8KRGsKQ6k22lKWMi3uKDwYXDmRPFRK6x7qAZ
	EJSmDdllWrn00mlVUFdKFdo3lJBHfIRDE3auo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0klP8UhlgRHNJL4RXoTIJZt990dxpNA
	BtLT0ESOTwf1QGNCY9JaxcMcGwd4FV5NwknK9RYJZYNGyr42JAdmejkuvCNChFCt
	Hfdy+u+juSSCtLZ+EmIzp/ySi5b7KwegxieiIoHUheRoG9iWuvA+AyZwJNckd3IW
	2KHBlBskZKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F5698FF;
	Sun, 24 Feb 2013 04:00:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 230FA98FD; Sun, 24 Feb 2013
 04:00:00 -0500 (EST)
In-Reply-To: <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com> (David
 Aguilar's message of "Sat, 23 Feb 2013 15:41:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92570F80-7E60-11E2-B933-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216981>

David Aguilar <davvid@gmail.com> writes:

> This is referring to "git the command", not "git the system",
> so it should not be changed according to the rule that was
> applied when many "git" strings were changed to "Git".

That sounds like a sensible objection.

> There are scripts, etc. in the wild that parse this output.
> which is another reason we would not want to change this.

Are there?  For what purpose?

Especially when these are all _("l10n ready"), I find that somewhat
unlikely.

The bash completion (in contrib/) does read from the command list
IIRC.  I do not think it relies on the messages, though.
