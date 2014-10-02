From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Thu, 02 Oct 2014 12:29:14 -0700
Message-ID: <xmqq1tqqnud1.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jeff King <peff@peff.net>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 21:29:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZm41-0003Hd-It
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbaJBT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 15:29:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62254 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbaJBT3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 15:29:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14055400CA;
	Thu,  2 Oct 2014 15:29:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iSaYFyjFv1BsbPSKxf/NnH218Q4=; b=uzRJoh
	t+3Js1ziIP7+PWBzcBGDG8xX0E5o2q2CU/KuUMj9GNtncVH9Y+1X9Tgy8fVDVKCp
	y3jUb724FZDTYEkAnQnW2CAdpY0lFJS0kZZMpYMGarEMNvvXSHAncGx0EKUOn8AJ
	GVisZA+0kGSGaF4Blgrz6zXotaYylczhpZAog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LplGj8GL2hntzpwq+hINSTw25oexUIu6
	SNXDqJQaQUHVli0sbk0/DYYZ/ZWwB71DZj0P7ltX53MGHdffaSrtZ6B6FVDkBQ3Q
	ovfvrgguLuyqf03ajxNlz3QGNjk1KGVCjwekFuTAVTv+vXM6avEjC5Q6/18Y9IiP
	44eTcyKESMc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A0D3400C9;
	Thu,  2 Oct 2014 15:29:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 83A15400C8;
	Thu,  2 Oct 2014 15:29:15 -0400 (EDT)
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 2 Oct 2014 06:24:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 655E2CB6-4A6A-11E4-A2C1-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257819>

Tanay Abhra <tanayabh@gmail.com> writes:

(just this point quick)

> 1> The name of the variable, I could not decide between "unset.variable"
> and "config.unset", or may be some other name would be more appropriate.

I'd prefer to see this as [config] something.

I wish we did the include as "[config] include = path/to/filename",
not as "[include] path = path/to/filename".  Perhaps we can deprecate
and move it over time?
