From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Tue, 10 Sep 2013 11:31:18 -0700
Message-ID: <xmqqob80y1e1.fsf@gitster.dls.corp.google.com>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
	<vpqwqmpjdvk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 20:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJSiq-0000tf-J1
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 20:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab3IJSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 14:31:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab3IJSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 14:31:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ADC440C14;
	Tue, 10 Sep 2013 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Me3hD/Ee2z7jO2vW8DOoe+Wjw0=; b=BmT0za
	QRsPigPGaS4dibMZYFqwJFNEdziYOMet89WlvFYJ8tucCiGcD3fB9ktG8SMb6ne0
	2QdZqmL7Rpr1cUqqBfl7+LcMnO3PusfXHtU9Z8+FRGhIoyXIFXepFYPvN7N+2Dgb
	sYcKFLIkSnT+CYULH8WaHUudWaUa+jCQ+VVGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNYttKfZxcg9GCj69uBS0/25TyOKRWUR
	GJcD79ulgKOtZX9H1o2Fy5xodqvL/+Bipi19Sp2A4aI9wtLnE/FVCc4sCkYcYxSu
	LFh8b219hjHk1/OH804r/VqOPp33DupG8Et9fIm6IoKzrKWySfE9mMmXPlgAx44w
	Zqb+z+fqMHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0719940C13;
	Tue, 10 Sep 2013 18:31:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6983740BDF;
	Tue, 10 Sep 2013 18:31:22 +0000 (UTC)
In-Reply-To: <vpqwqmpjdvk.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	10 Sep 2013 10:10:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31F57FAE-1A47-11E3-81FB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234468>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
>>  - rebase: fix run_specific_rebase's use of "return" on FreeBSD
>>
>>  Work around a bug in FreeBSD shell that caused a regression to "git
>>  rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
>>  success report to make sure we didn't miss any other use of a bare
>>  "return" from dot-sourced script.
>>
>>  Will merge to 'next'.
>
> BTW, this is a candidate for maint too I guess.

Yes, thanks for reminding me.  I was planning to change that label
to "Will merge to 'master' and later to 'maint'" when it hits
'next'.
