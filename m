From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --interactive using short SHA-1's internally
Date: Fri, 09 Aug 2013 22:28:36 -0700
Message-ID: <7v7gfu2jy3.fsf@alter.siamese.dyndns.org>
References: <CAMebvcT7Tb1PXsKmRuSNCqOhJEbkPJAG2tzW6FjWCa6hH-+ffA@mail.gmail.com>
	<CAMPXz=rdaAZVb8UJJ+KcBZFR2wdnqTWbMKt07snPGEuCDz9q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Diogo de Campos <campos@esss.com.br>,
	git list <git@vger.kernel.org>
To: David <bouncingcats@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 07:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V81jI-00035Y-Nz
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 07:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab3HJF2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 01:28:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab3HJF2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 01:28:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA7530708;
	Sat, 10 Aug 2013 05:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUus9ZYJd1MW0bg0W4dfBdWq1II=; b=dlYNJ/
	zFAFdhas7MDsCekWBBTBwTR/RoVrwS72tIL56q6SPII++BCulB/Y7Is7FGUupc/w
	PS/aLPUvVrJGDvvEBkV1IPC81R03+72rMg6XAVqeqjLCrccYHeSNxPecfwzBOybd
	si+0fPFI4A8yRZNTR9xduVwiXh8VYgs5GY79o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFlys4xuRJFx1ocm8Q0+6U4pFQI49ayZ
	lSOmzn49wN4mnulTPemh8n8chYNBsyqJwmjdJu9VN7bc1Yx8hsrpJOpr+rNE17sh
	kvXryU9igrvo0JkTGPdoOW3+BVQL3sp0cAu78Uce8pMUovEsBpld4GOYU3nMOwY3
	Czmzh5SUpso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D4130707;
	Sat, 10 Aug 2013 05:28:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41CFE30704;
	Sat, 10 Aug 2013 05:28:38 +0000 (UTC)
In-Reply-To: <CAMPXz=rdaAZVb8UJJ+KcBZFR2wdnqTWbMKt07snPGEuCDz9q5A@mail.gmail.com>
	(David's message of "Sat, 10 Aug 2013 10:50:25 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5BC15BA-017D-11E3-860F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232064>

David <bouncingcats@gmail.com> writes:

> On 10 August 2013 05:22, Diogo de Campos <campos@esss.com.br> wrote:
>> Had some problems rebasing a large repository, fatal error because a
>> short SHA-1 ref was ambiguous.
>
> This recent disussion might also interest you:
> http://thread.gmane.org/gmane.comp.version-control.git/229091

I was wondering why the topic looked familiar ;-)
