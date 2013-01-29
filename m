From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 14:55:26 -0800
Message-ID: <7va9rroazl.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
 <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0K5r-0002kJ-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab3A2Wzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:55:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab3A2Wz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:55:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47A3FC86D;
	Tue, 29 Jan 2013 17:55:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5lyj1ThWazmfpBCE/X4Ig4jO0KI=; b=E+OFss
	+qam/HMzEYc7optjpNLBim0ru354gkyskWH+aaVL67sYZKEd8iOMd5EhHm9oNTXH
	/daR7DyBKRmSHL58mzaSChmA6prn6rFbrl586Twa+qHoST94HqLWXARR4K5AZc/H
	UnM7sIiFO3iSoCy4hvKN/wt1xScRYUz82aAmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nIkHSCQasF+FsydxbGn5DYii0w8t8iLU
	JddDaJGYn00TXZko5u1oERYG12hw/OWh0XaO1ogVLvTXAI+VliG0tVu4xib8HVDW
	WwjsB4rgympqIX+EeeE/T/hSjZa/tqtqXU8Oj480Uics3416iwIkoSQZ5gJLkwza
	/7UJwN82Rx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB41C86C;
	Tue, 29 Jan 2013 17:55:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1E55C86B; Tue, 29 Jan 2013
 17:55:27 -0500 (EST)
In-Reply-To: <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com> (David
 Aguilar's message of "Tue, 29 Jan 2013 14:27:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F95CFCE8-6A66-11E2-A71C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214979>

David Aguilar <davvid@gmail.com> writes:

> I don't want to stomp on your feet and poke at this file too much if
> you're planning on building on top of it (I already did a few times
> ;-).  My git time is a bit limited for the next few days so I don't
> want to hold you up.  I can help shepherd through small fixups that
> come up until the weekend rolls around and I have more time, but I
> also don't want to hold you back until then.

I can work with John to get this part into a shape to support his
extended use sometime toward the end of this week, by which time
hopefully you have some time to comment on the result.  John, how
does that sound?
