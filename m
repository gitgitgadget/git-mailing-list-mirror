From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] add a reflog_exists and delete_reflog abstraction
Date: Wed, 07 May 2014 13:17:55 -0700
Message-ID: <xmqqzjit8hsc.fsf@gitster.dls.corp.google.com>
References: <1399416353-31817-1-git-send-email-sahlberg@google.com>
	<536A1F84.8020902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 07 22:18:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8I5-0005eY-O4
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbaEGUSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:18:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaEGUSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:18:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE9801695D;
	Wed,  7 May 2014 16:17:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSjBk0t82OJ7mGpGYOsapQxcouw=; b=i7Db4X
	GzL3rsLcr9aLMxxj4XPJQyILFdlwh4BS7m3M57i6npsAJRbXogdZChROuredorQQ
	vYw/Ab72tMswJXYgOJmLSyBm5HAl+cXKRh1uCmibmLJiX14DeZa9GeJMFX8gdbuJ
	ixnG1mwlJPiO0l2erDHWpPJyFBe8yBDq0gtRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATPL5e/y31ZN+5/utGnd3/oijLFYoUwC
	f9CZ4isF06Z40LPsZdzCmnvGvCR+c7SyU2cpq/JAuW+w0SUi4EAmktYjPRftOmiZ
	cMHTqSR8NI2mkGMd/2S0tE3yeGT4W8QnkuwR0ia0FBvDiBUPhPyA4e/9AN7gNrKu
	wWWOr7V8Bb4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A41E61695C;
	Wed,  7 May 2014 16:17:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA31B1695B;
	Wed,  7 May 2014 16:17:56 -0400 (EDT)
In-Reply-To: <536A1F84.8020902@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 07 May 2014 13:56:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD86FE6A-D624-11E3-A24A-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248357>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +1 Looks good to me.  Thanks!

Will queue with your Ack; thanks.
