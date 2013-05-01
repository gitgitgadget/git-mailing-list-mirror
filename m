From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 01 May 2013 15:59:09 -0700
Message-ID: <7v4nem488y.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfzY-0005lM-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab3EAW7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:59:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217Ab3EAW7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:59:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E3FF1BFB0;
	Wed,  1 May 2013 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BKWStcCQt3he3feH0lET0TOJM/A=; b=CigXHC
	oI/MNVJ8/JktAJPXTvHNXAMyOPGOLO4i4Z+5y8k5NPEDiQfeG29EqURffO5F8v+v
	Q4el0bwfiGbxFcvLLAyiQn1nNRRR02q8Lz6O2u3bEymfwq4Si8pkZX0qcRZ/AlUp
	oMldwAVQpGvBNK2JdlDWb4Ibs37RKk04UxAqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UfL2jB7kUzyypht5CdYtcr/ReTSeGk4L
	KwDyViwz+jcnicn9KqhM1aj0snB8ICkRa3zknyIV171GmK9dkKEAPkaD0LmKaVmr
	m/DlxhRtEtdPFQa/ST4hzNidhTY+x/QPUIN+xTYf+5T8l8L1nIily8vfT93dZSmx
	+ZNiox52jvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6227D1BFAF;
	Wed,  1 May 2013 22:59:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA8AE1BFAE;
	Wed,  1 May 2013 22:59:10 +0000 (UTC)
In-Reply-To: <CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 1 May 2013 17:35:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC632CD8-B2B2-11E2-ACB5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223163>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Exactly, because ref@something is used for operations on a ref. If
> 'ref' is missing, it only makes sense to use HEAD (or something like
> that), and if 'something' is missing, it only makes sense to make it a
> no-op, but since we don't want to forbid refs with names like
> 'master@'. That's the reason why '@' makes sense, and not any other
> character.

Yes.  My typo made it look as if I meant to say '@' was a bad
choice, but we are in agreement that '@' is better than any other
random choice of single punctuation letter.

It is just the "strip this, strip that" explanation, which is not
technically correct, does _not_ have to be our justification for
picking '@' as a short-hand for HEAD.
