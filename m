From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 09/38] lock_file(): always initialize and register lock_file object
Date: Wed, 01 Oct 2014 13:36:18 -0700
Message-ID: <xmqqh9znplx9.fsf@gitster.dls.corp.google.com>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
	<1412159322-2622-10-git-send-email-mhagger@alum.mit.edu>
	<542BE535.3040500@web.de> <542BE7CA.5060902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZQdS-0004UV-AS
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 22:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbaJAUgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 16:36:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63877 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbaJAUgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 16:36:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC3273EEF8;
	Wed,  1 Oct 2014 16:36:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xr8MKmLAEWqRTbjybs85OnKGK6M=; b=Chtj0M
	HTY7eMyxEP60NvuXCd94fFFi28jiqxtZYlhIDMIdIZaJF6GYVXo6P5+UR5ysGhe8
	93yFpTZxS5Xk0t4aGfI45FI2C/y7jhgrGRYmPaA5kpnRSRjV3lz1oXRVqcaZyDM2
	3W2aqvO1s1yJz7CqX53SEejI6R/UOfREjL8eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gzi04wkiPpVZexuzc9Gn7Og9XMmVo5LL
	GUbwpoGozEuSdxY133qE2ibe7hsFA91q/kr4IVth0EM+54hln3cGsDnzmjFn9KcR
	/UAn4HGgskA5XO6rc2b1FRzJZW0wWgGO6E2eHNnNCfpH1/fA5rk/uI2jvRi6YWHK
	N9YPMV6Y0dI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1D993EEF6;
	Wed,  1 Oct 2014 16:36:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D4F63EEF5;
	Wed,  1 Oct 2014 16:36:19 -0400 (EDT)
In-Reply-To: <542BE7CA.5060902@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 01 Oct 2014 13:38:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 994ECE2E-49AA-11E4-A343-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257763>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, if another reroll is not necessary, would you mind fixing this
> when applying?

No, I wouldn't.
