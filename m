From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/nedmalloc: don't  force NDEBUG on the rest of git
Date: Sat, 11 Sep 2010 10:23:18 -0700
Message-ID: <7vocc4fb3t.fsf@alter.siamese.dyndns.org>
References: <4C8B52F6.5040609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTng-0003Ga-Sx
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0IKRXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 13:23:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0IKRXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 13:23:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56775D50DD;
	Sat, 11 Sep 2010 13:23:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=jEeim2
	xEvvv9ZZ/naL49a0P35SZjWQabrQApWmG3cQptkiLP9SHbob3Ybq+IEBVkEI/2IB
	LZYbwOAI+p8fpRfCWcfQYrnujsxgYsmEb9e5/QicwKFh3Nq9v+GXHW6qXwglkRnU
	U8LA+BlYZaY7zVEX2ZFfDV30boe8F/ZtzW5IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ekevj93N99Rajp2d7qD17mdS3tb7ZdFV
	w8tX1mWWHmmpFF7epQukuHd/5Zv65B3INUVCa1h2x4y+q5krt2LjTGNmnhBMdED0
	mhPUJ2GAOjn71iUs1z+K1ijTB9VmZUJJ418IQTS+1fk0hRa6w0GMT1SeHKYF1WaV
	BigKq09XmJU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EF4DD50DC;
	Sat, 11 Sep 2010 13:23:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31498D50DB; Sat, 11 Sep
 2010 13:23:20 -0400 (EDT)
In-Reply-To: <4C8B52F6.5040609@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 11 Sep 2010 11\:59\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 494DB550-BDC9-11DF-A0BF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155997>

Makes sense; thanks.
