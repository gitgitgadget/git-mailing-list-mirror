From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mergetool: include custom tools in '--tool-help'
Date: Sun, 27 Jan 2013 12:13:33 -0800
Message-ID: <7vmwvuv0ya.fsf@alter.siamese.dyndns.org>
References: <20130127163442.GQ7498@serenity.lan>
 <7vobgawljs.fsf@alter.siamese.dyndns.org>
 <20130127195618.GS7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYc1-0006rG-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab3A0UNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:13:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab3A0UNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:13:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451FFC69C;
	Sun, 27 Jan 2013 15:13:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyDSzDPG4PzkScS1ACK4BbQzDCA=; b=MKmhXe
	oq90ebV/QnUtwVXfGOOGxUp2BymyRKgWFxqpEJKkrshMWGNDO6RtP/uLke/iOI2y
	3R730WC+qohwXpSJIoVUImHzUpU2FgvHY7SmBMqGAXVgVJ/RD7jAlvek2wFsECNU
	Z05B1Ko8wXQUoKLAG4W/SgFnq/RhSUdDd9/i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cewb9EZhDh4dyMeusUsLorDig+FppAG6
	D9ecgBDV/xNQGP6HaqVtTpHx1R0gooCFMSH70ZAgp/+yBgqxlfdF4t+96igdLN/m
	kp3VpVBjTZuAaykOGPn4WiffMCRRoBD/5DZ+Hm6HFONrcMB5fMhJYmPuJChhxXUq
	TaQSjjkyyGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A146C69B;
	Sun, 27 Jan 2013 15:13:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD4CC69A; Sun, 27 Jan 2013
 15:13:34 -0500 (EST)
In-Reply-To: <20130127195618.GS7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 19:56:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 071F98B8-68BE-11E2-987E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214726>

John Keeping <john@keeping.me.uk> writes:

> I think I'd want to do this with a suffix if at all, so the output would
> be like this:
>
>     'git mergetool --tool=<tool>' may be set to one of the following:
>
>             araxis
>             gvimdiff
>             gvimdiff2
>             mytool	(user-defined)
>             vimdiff
>             vimdiff2

That is fine by me, but the real users of mergetool please feel free
to raise objections.
