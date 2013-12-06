From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Exclude pathspec
Date: Fri, 06 Dec 2013 10:12:23 -0800
Message-ID: <xmqqd2l93l2w.fsf@gitster.dls.corp.google.com>
References: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 19:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoztA-0007jF-8M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 19:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369Ab3LFSM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 13:12:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab3LFSM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Dec 2013 13:12:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4B2256445;
	Fri,  6 Dec 2013 13:12:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=39qdAugRfqFK
	2I+jmHyg/FpfYA8=; b=aCtTRSsubEfzbhuZ8yQKN8VPkW4kRsiVQ0zpXIpz4lQ7
	ZieYkx2MUNfzR/KFLe+WzR/VkBplxmEa+t4OAOxpgbb3jTXVU0YVoEhG8SJP8tXD
	ffT0oQyVu1o8WK+8lvKIkHGe94GLBZ3wT+t23gtXRMFo9TLZqKJX77ikbPCK4JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=guv+2x
	VXRWSwWHjcHwMfsDI6S5RrqjNmr385FSWV43uN+uCJwiwxTkyyQ1V03D5G5rLCqA
	1bO2UdBGbXPUv6NtqmAj0UFpg8GFD9YJ2Vd5kuyxWPAdPQZlUZVu4NFD2+Si2hhM
	Dz4bblOJ+VP3izibggxISWnWnrFHAQvmxchxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95E8856444;
	Fri,  6 Dec 2013 13:12:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1A1256443;
	Fri,  6 Dec 2013 13:12:26 -0500 (EST)
In-Reply-To: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 6 Dec
 2013 14:30:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F67C75D2-5EA1-11E3-AA77-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238942>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> You
> can now say "select this path except this subpath..." for nearly all
> commands that take pathspec.

Good; thanks.
