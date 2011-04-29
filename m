From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid set-but-not-used warning
Date: Fri, 29 Apr 2011 09:43:54 -0700
Message-ID: <7vzkn9vwhh.fsf@alter.siamese.dyndns.org>
References: <874o5hv1f2.fsf@rho.meyering.net>
 <7vwridxbs9.fsf@alter.siamese.dyndns.org>
 <BANLkTi=KZxTrAzoj3Bhwr3XTEPNnOvcvdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqng-0007cL-9a
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab1D2QoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:44:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759218Ab1D2QoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:44:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F32895348;
	Fri, 29 Apr 2011 12:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iXq86ZuzWAeY2MdaaO8picXLe+0=; b=Q8Px7c
	h8PChlfYeSIrWZe3ZtQA+LTFQeD3EXIppyRZfQO3EnWA+bEWY9HT6v1CkM86Ay7O
	K577arR8xBmajzi1oAbKxTKJZ9g/NfSL+Vcl0XuPXNYTR7cc4NgSw1vL3OlMTjoI
	u2q+8V2EFE3Xr627XZQgzkelyc1Ja7HSADOk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEia+r8XvI7i38ejrMcuC0jI2BFNZZm4
	qYgVqyc+nV+rfpI71xX+xwnDwmfLQft/4ATjcleb3Nu523di/UDgvFjV7C7K65N1
	vsEAGJFr6/2WPJE0yGRkFtitftNorhtWfPN3jwYnen9feNlIfVrvJgyzr1fLETBP
	zwOXlhMFdyM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEFFC5347;
	Fri, 29 Apr 2011 12:46:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62E085346; Fri, 29 Apr 2011
 12:45:59 -0400 (EDT)
In-Reply-To: <BANLkTi=KZxTrAzoj3Bhwr3XTEPNnOvcvdQ@mail.gmail.com> (Thiago
 Farina's message of "Fri, 29 Apr 2011 13:34:25 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C5677CC-7280-11E0-8185-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172471>

Thiago Farina <tfransosi@gmail.com> writes:

> On Fri, Apr 29, 2011 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks.
>
> Ingo Molnar has posted the same fix in "diffcore-rename: Remove unused
> variable 'num_src'".

What do you want _me_ to do about that?

If this were addressed to Jim I may kind-of understand what you were
trying to say, but you addressed me, and I am puzzled.
