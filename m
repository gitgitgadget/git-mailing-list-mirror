From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command
 line
Date: Sat, 20 Mar 2010 09:00:58 -0700
Message-ID: <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 17:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt17H-0002Lk-MP
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 17:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0CTQBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 12:01:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab0CTQBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 12:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BDDA30A4;
	Sat, 20 Mar 2010 12:01:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eo4SOKQFFXByg06rVJXabLuj3zU=; b=WJxgPT
	9RmMHqDAeJqbNT33kUxxRZz6pHzqZr5s2F1qO48/Lw7rkI9UdGSQAg8wlZZSv2Gu
	MIpAJpG1TL78X6Pa3lT1eVESQ47CDSs2YnozAyh6Jyg/J1phFauwlneWWcLiGEFu
	r4km+WitNZ9gKgtx8RuqLstuns9+RFURfvb2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gm0J95EIEMwcSAknjO3GHYxVTOCkzmv8
	2TzjekWgn/PPcPzxtuGNh8bEibLiNuzEoedXAPDQQLBbFbRmSIbXVDN/k4KhHv/Q
	VzvWqrDvGqhKaLldVSM98FvdEix9v7DQ82wYENyFkH/jZZSqX+nWL02L9f3JWrGc
	oH9pMm3BDZI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C5D3A30A0;
	Sat, 20 Mar 2010 12:01:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42B30A309C; Sat, 20 Mar
 2010 12:00:59 -0400 (EDT)
In-Reply-To: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
 (Alex Riesen's message of "Fri\, 19 Mar 2010 15\:42\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE45297E-3439-11DF-A63B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142721>

Alex Riesen <raa.lkml@gmail.com> writes:

> The values passed this way will override whatever is defined
> in the config files.

You sent MIME multipart-mixed and I am getting a broken patch.

How could this be... If I cannot expect to reliably get a non-linewrapped
patch, there doesn't seem to be much point in you and I taking extra time
to bother with MIME.

Very unhappy (not with you, Alex, but with MIME and whatever tool that
wrapped your lines).
