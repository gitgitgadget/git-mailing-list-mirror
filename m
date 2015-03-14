From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: add stashes for gitk
Date: Fri, 13 Mar 2015 22:18:31 -0700
Message-ID: <xmqqtwxoxil4.fsf@gitster.dls.corp.google.com>
References: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
	<xmqq1tku3x3c.fsf@gitster.dls.corp.google.com>
	<xmqqioe62h5g.fsf@gitster.dls.corp.google.com>
	<CANAO8VEUu9erxMLU523vQhg1hyfwVASH-Ng6YGKTN0RiB+H9FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 06:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWeWu-0002Mm-US
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 06:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbbCNFSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 01:18:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750853AbbCNFSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 01:18:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 822EA41F5E;
	Sat, 14 Mar 2015 01:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1NJnmPFg+3lks5xlNi4zuh0CFY=; b=JMDH+B
	vGg5coGJka8LlPg+/6vHo6YXkTw6OpapljoSUOm/lpuFwjc7MsB6pfhnydudJv1J
	9aQO5FXm5HUXQnqBlGGKNrIFMqrWJznBLZkDEFLN2GAKwd//ZArVJZvrNXoY21QD
	w4pr6J0nii/L57mbWHv2jjTW8HALjR5G0rSME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HgVeD3uyle77eu++c+msNxEb+aEg5fx2
	J9wmev8XKALbp+i0MW+kitJpXKchKpTOb8aMGT38lrYF1DyKwA0cZUUulHlMI9bv
	HmvnZO+q5Z1P4PNGKzjzrssPIULlzYDCx9rj2kTrGfYJ28T/y/Ge2VI9Qxvc09ot
	EP5l4dDSUAk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA3941F5D;
	Sat, 14 Mar 2015 01:18:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9ABA41F5C;
	Sat, 14 Mar 2015 01:18:32 -0400 (EDT)
In-Reply-To: <CANAO8VEUu9erxMLU523vQhg1hyfwVASH-Ng6YGKTN0RiB+H9FQ@mail.gmail.com>
	(Sveinung Kvilhaugsvik's message of "Fri, 13 Mar 2015 18:25:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8EF1D694-CA09-11E4-8680-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265436>

Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net> writes:

>> A bigger question is why this change is made to gitk completion.  If
>> this completion were useful for "gitk", wouoldn't it be equally
>> useful for "git log"?
> I must admit that I didn't know that "git log" could display the
> content of a stashed change. After trying "git log -p -m stash@{0}" I
> would say that adding stashes for "git log" would be slightly less
> useful.

Yeah, it would not be so useful to dig with "log" beyond the commit
that each stash entry is based on.  But imagine "git show stash@{....}"
or "git log -g stash@{0}"?
