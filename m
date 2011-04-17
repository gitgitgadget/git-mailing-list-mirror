From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git
 notes"
Date: Sat, 16 Apr 2011 19:39:12 -0700
Message-ID: <7v39lhbnzj.fsf@alter.siamese.dyndns.org>
References: <4DA7F73B.9050007@gmail.com>
 <7v7have8wo.fsf@alter.siamese.dyndns.org> <4DA8862F.5070102@gmail.com>
 <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
 <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
 <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
 <BANLkTim2=Jg4QcgKwO=J6343zWAoCkyXZQ@mail.gmail.com>
 <7vaafqay9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 04:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBHtn-0001e3-77
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 04:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1DQCj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 22:39:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab1DQCjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 22:39:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D97FB4002;
	Sat, 16 Apr 2011 22:41:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m95jvlP7YTMHWw/veTP0Qyrx0sE=; b=bAcMtL
	djknMocOJ/KgsQU499Yu3ZWXAIPSXEvYHqjCnoutE1jemfPK76bVm3B6FK9IH4cJ
	riPSy5Gx/f0VaXznA1fG2v3S5KV20dQ0gcyvh8bS3LwEth8zzGdIZT1Fzk/+GOWw
	hPKqmOq/ANo8myO3mT4o1Vn6QIQlv2coTqEjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NEn9AurtsK8ysw0xXm6wQtx+4IUGwb/a
	aEwrEx8Gf3Zr6peuK/FRsr/pOmFHDoCcTOGThGHY7qW0IS1o7G2tsJefDAQlTOQP
	vXWUhVsJlJQgYJlJbVX7i/lNMpbnhMXUEr5NZhk9aVXMJRHKtufhFVF2lUTQ96l9
	N84AcOA419A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5FD85FFC;
	Sat, 16 Apr 2011 22:41:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8A9665FF8; Sat, 16 Apr 2011
 22:41:13 -0400 (EDT)
In-Reply-To: <7vaafqay9f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 16 Apr 2011 10:42:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8CB308-689C-11E0-8E85-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171709>

Junio C Hamano <gitster@pobox.com> writes:

> I agree that the user can decide to remove that line in the editor when
> the necessary conflict resolution was so extensive that the most part of
> the original change became irrelevant.
> ...

So to conclude,...

>> +       cherry-picked from.  This is done only for cherry
>>        picks without conflicts.  Do not use this option if
>>        you are cherry-picking from your private branch because
>>        the information is useless to the recipient.  If on the

... we could just remove the "This is done only for cherry picks without
conflicts."  We could explain that the user may want to remove the line
depending on the nature of the conflict resolution, but I guess it can
be left without saying.
