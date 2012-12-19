From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add directory pattern matching to attributes
Date: Wed, 19 Dec 2012 14:58:19 -0800
Message-ID: <7vr4ml7ipg.fsf@alter.siamese.dyndns.org>
References: <201212192233.53002.avila.jn@gmail.com>
 <7vbodp90o4.fsf@alter.siamese.dyndns.org>
 <201212192334.51085.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlSb2-0000nT-3a
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2LSW6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 17:58:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab2LSW6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 17:58:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725DF9C08;
	Wed, 19 Dec 2012 17:58:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RMD8cnS/4OuS
	R7o0K9PFEwM8GMs=; b=JTSCUgtSRT0zT35g49HOFwwirCxgtu1TLK1Ba0YlMwX9
	EoJdUPstwfzcuOP+JxNMvHwpcrD/Lo8pKDUJ3xXjRwHsMV5yAFlIz8dXBD72fn2k
	PSZM4KpzRzvCCsNIhIQ5mIEL/CSiPfz1QA4Pi6/9HG7pGkvVvt9JLt48nmEWUzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X5ruQB
	kTatxvCX5Oehv8k2L+cG5odc68OHGHD58wBoSzalUu2ql9kwmtaI0nyb8yVafROT
	xuPTEmEF5fZCZXwSI14+Jy7KT0R65iDUdvehhCgtaDfrgPN5wXsNu+eg/WhoSjCj
	uRpac1NHOmoKAN8Dy3ftesJNfoD8InR0yvS8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F8EB9C06;
	Wed, 19 Dec 2012 17:58:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D08F49C03; Wed, 19 Dec 2012
 17:58:20 -0500 (EST)
In-Reply-To: <201212192334.51085.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Wed, 19 Dec 2012 23:34:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 959E1536-4A2F-11E2-82D1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211863>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> Le mercredi 19 d=C3=A9cembre 2012 22:44:59, vous avez =C3=A9crit :
>> "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:
>> > This patch was not reviewed when I submitted it for the second tim=
e.
>>=20
>> Did you miss this?
>>   =20
>
> Grml, I did. Sorry for the noise.

That's OK.  Your previous one, with the update suggested in the
thread, has already been queued in 'next' and will be cooking
there throughout the pre-release feature freeze.
