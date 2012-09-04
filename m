From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 04 Sep 2012 12:22:51 -0700
Message-ID: <7va9x5a8z8.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
 <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
 <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org>
 <5044D162.1010608@gmail.com> <7voblmeua3.fsf@alter.siamese.dyndns.org>
 <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
 <7v4nneduvj.fsf@alter.siamese.dyndns.org>
 <CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com>
 <7vd321dc0e.fsf@alter.siamese.dyndns.org> <50464FA8.3020104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:23:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yiF-0005OU-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634Ab2IDTWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:22:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757617Ab2IDTWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:22:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F93D8284;
	Tue,  4 Sep 2012 15:22:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHf7Uvcf3CMJ4V1AeNI3FvSmp7E=; b=t/ooRB
	/z2TeocZv5Xm2HNUZMG0p/IBgZdHN5YOX+/LkznpRQpPWOKfDGDm4jwRHP7bmF54
	X3PlILgjuiq7l0MCv/UZd2AHhww7s1C5WqOC+WwdfibQ6uIKA/2jCUjjLNmAAChj
	eqVC3zJGQgIO/nJREtVq+q8P5NS0lwZSqw3mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=czgoRunP9mZQ9nwEXygISG7VGZ/Rr1IF
	NX782a/VFoszQ5i2CMKNNDf8CbSryiW3/ew0WzNbUMhYU1tS2xHC3ntmPFbSeXgQ
	qDyM37Ggb1MNAwzt2hIzz+ShdgyIJyUKDC22mTeSLIDNV11MPuyjb4Xr4LYHX3xh
	8yW58wqkX2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14128283;
	Tue,  4 Sep 2012 15:22:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 531E78282; Tue,  4 Sep 2012
 15:22:53 -0400 (EDT)
In-Reply-To: <50464FA8.3020104@gmail.com> (Marco Stornelli's message of "Tue,
 04 Sep 2012 20:59:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC6E8B92-F6C5-11E1-8771-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204777>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> kernel, load the patch and send, really easy. So I don't think it's a
> regression, it's only a change in the work flow.

Any change that forces the user to change an established work flow
supporteed by the existing tool we gave them _is_ a regression, even
if the person who forces that change believes the new way is better.
