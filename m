From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Work on t3404 in preparation for rebase--helper
Date: Fri, 13 May 2016 10:57:27 -0700
Message-ID: <xmqqa8jtaliw.fsf@gitster.mtv.corp.google.com>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
	<cover.1463067811.git.johannes.schindelin@gmx.de>
	<xmqq8tzfgsbd.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605130835070.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 13 19:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1HLE-0004hd-PT
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbcEMR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 13:57:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752071AbcEMR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 13:57:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFCDD188AD;
	Fri, 13 May 2016 13:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4I5ECFkE4Oc1JIRuIs0qKf5oOc8=; b=XNyTOt
	p/MZ9I/3UTGtqzhaa7JaPlaw/P1DtYs6QYAgC+8K0qkdUfdXhReCGg40Qf7hJlgA
	4HQ17EFGVfgUhoWSmNQa53NfmBeRV+TapB6VEiwPy1RI/q3BcNTUm68LJc1d2F5N
	p4ixs6X6+DwiUhMG4Hg8aAoOiCGNbp0YEaEpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQHNYdOPn0Fe22QwohLtfY3M6gPWOcWw
	iImR6xe/CbaboM09nGAYdNCYncVMj2Q3E78fd56Qa6UX+/brA4covk2LrmiphI5g
	ROsN/YAk1dURvgprfTnRwuX4q+USJgalLtsimnDJsPeT+dfpBu0riwFISz4J+FFW
	P0IvUo8nPNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6548188AC;
	Fri, 13 May 2016 13:57:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 515B8188AB;
	Fri, 13 May 2016 13:57:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605130835070.4092@virtualbox> (Johannes
	Schindelin's message of "Fri, 13 May 2016 08:37:36 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28B7DA42-1934-11E6-B1C0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294550>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 12 May 2016, Junio C Hamano wrote:
>
>> I took these separately already, and plan to fast-track them as they are
>> both "trivially correct"; I double checked that what I have match these
>> two, too.
>
> Oh, okay. I just wanted to make things easier for you, and now that I have
> a script to prepare patch series, it's really almost as trivial for me to
> send out a new iteration as it would be to update a Pull Request on
> GitHub.
>
> Do you want me to hold off with new iterations in the future until you
> clarified your preferred course of action?

No.  You've been doing great.  I just wanted to clarify what I did
to your patch before I merge them separately to 'next' ahead of the
remainder that you'd be sending out, expecting a possible course
correction, e.g. "that would make it harder to queue the other patches
yet to come, all of which would depend on both of them--it would be
better to queue them on a single topic to be extended with these
other patches, after all these two are not that urgent".
