From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why is merging with unstaged changes allowed when rebasing is
 not?
Date: Fri, 04 Mar 2011 09:53:10 -0800
Message-ID: <7vmxla7oxl.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=dnyaPTX0Y43nbAGp46NtscKT3a2idxEhkreMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZBq-0005S0-3u
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab1CDRxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:53:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1CDRxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 12:53:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D4ED457B;
	Fri,  4 Mar 2011 12:54:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0zVsiN4nZBKR4cU8ugJRrhan9uk=; b=KniDK6
	g39rmUgrfiU0e8UDczHtXWGo3tVZK/9Y5R6NyhFta8H40Fbc5uzaR6wHm/xEHTRn
	SLx2ZooiJVLoori13YW12skC9hMMHTvvZLI+d36+Cax53BpvXLVibhkBrdMFnKYp
	r8I/tysnRO80fUEk+F7MVPAbxJvIH69QYbwkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hvBek+0oPbEiwfEPv5dyEd8O9fslFrMJ
	x9ZyLQErLvGrkzraFZOn+cAhHihcGdX64bmEHmIgw3fCToEk04/KnET/wBuQCCMC
	orl15Ykxuc0jjCcq305vocSwJ/ElU7MarlRM82/ULEH3+8Yl9Hjbr6LpXE89Khvi
	YyI6PU7ZurE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B7F0457A;
	Fri,  4 Mar 2011 12:54:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 775DD4579; Fri,  4 Mar 2011
 12:54:34 -0500 (EST)
In-Reply-To: <AANLkTi=dnyaPTX0Y43nbAGp46NtscKT3a2idxEhkreMm@mail.gmail.com>
 (Christian Halstrick's message of "Fri\, 4 Mar 2011 17\:32\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 789AA2A8-4688-11E0-BC73-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168454>

Christian Halstrick <christian.halstrick@gmail.com> writes:

> Isn't it inconsistent that I can merge with unstaged changes in my
> work-tree but not rebase?

Because people who wrote rebase didn't bother; it is too cumbersome to
check all the possibly affected paths beforehand while replaying multiple
changes.

Patches welcome ;-).
