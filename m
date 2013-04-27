From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/20] remote-bzr: split marks file
Date: Fri, 26 Apr 2013 17:17:03 -0700
Message-ID: <7v4nesvncw.fsf@alter.siamese.dyndns.org>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 02:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVspF-0001Vz-0b
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 02:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab3D0ARI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 20:17:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab3D0ARH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 20:17:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0282D6DA;
	Sat, 27 Apr 2013 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bfe+nUlsmmb3l08hDSxcifplYBY=; b=vUOMsS
	FqFavgxenb3HIyAnbI1uzwqqQK2xInmn5DPUbZRKgQIuxDGFGvjOrbo5GgaobAk+
	FF08PrM8t5BZDOwWsMhvQRcOcrUr8LOsCgeV8wc1kh1L/SevLQ0Z1TXVrtN3Hs1O
	BBYGFZW7q608zDSMBJtR9aHbxWJVtDTfFUBcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VMsU+bHVA9WOfF9ErPVTz8Q+6THroWXX
	YRLO6yZI1y7C4gxhi0Hzrf8zGOw9RYZfvAskHRUyFicsgxJQ0rGT8/vUnlRZ5Oqy
	qAFPSSfuiolAX9EKU+R7LMyy32SdIcuNSE3KBaTOmpyJ57xFEuMjk1W2v7LTVmrV
	9fhqJmam9j8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5B2FD6D8;
	Sat, 27 Apr 2013 00:17:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1C2D6D7;
	Sat, 27 Apr 2013 00:17:05 +0000 (UTC)
In-Reply-To: <CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 18:36:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA69510E-AECF-11E2-AFCE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222608>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And in case anybody is thinking that remote-bzr is really a too fast
> moving target; even if this managed to land in 'master', it's likely
> that people were not able to push at all, and in fact, many were not
> even able to clone in 1.8.2. So, hardly could be considered a
> regression. Nevertheless, I caught it in time.

You didn't.  I am already way too deep into today's 1.8.3-rc0
integration cycle and I won't waste a couple of hours work just to
revert this.

But from your description it sounds like with or without the patch
the helper is equally broken and it does not make that much of a
difference.
