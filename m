From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/19] reset.c: replace switch by if-else
Date: Fri, 11 Jan 2013 09:12:49 -0800
Message-ID: <7vwqvjbq3y.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-10-git-send-email-martinvonz@gmail.com>
 <7vhamq5e1v.fsf@alter.siamese.dyndns.org>
 <CANiSa6gz-DBv+2gUDPdhgmeYdHg3-OVO80a7NvdLn4vYRyKEnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtiAL-0002mt-HD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 18:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab3AKRMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 12:12:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab3AKRMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 12:12:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF38DAA64;
	Fri, 11 Jan 2013 12:12:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hwua4OrlqHegxQjsO33wLX4KnOY=; b=eWjPi9
	NP8LqRZiSygiSBl6c6bu1dMZVQrVn/B1/Z/Ev5zOOCOr5tbZBTTEn3kmjWzJXSx2
	0YWYKWoD9tK+qfgQcD2IYEcCeeJBVzoPNPVoXH/0J9QMGO08f0RtcTD9Vp+4ae5/
	1fN75cILBTOOfT/L8rfR3pwp7fBGnIcMGmGuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vS3AtZGv0ydpO5TdMaPf7eEIodSgRjQU
	2a/x0ToGfdsW+bZwUqZ/Vkai9ToVJ1j5UaMGMuTji0JL+gugbzzYUPi5ybPxbKFe
	vIjxCZb25ij5CUlm2W49nLMsjCQbV7I76vMV0+DNOG4GRAMgEgj0JDqEScdy1izd
	2GaUVcTIacc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E404EAA63;
	Fri, 11 Jan 2013 12:12:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BAEAA61; Fri, 11 Jan 2013
 12:12:51 -0500 (EST)
In-Reply-To: <CANiSa6gz-DBv+2gUDPdhgmeYdHg3-OVO80a7NvdLn4vYRyKEnA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 10 Jan 2013 22:35:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 220CF9C6-5C12-11E2-B8B6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213227>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>> Justification?
>
> Clairvoyance ...

;-)
