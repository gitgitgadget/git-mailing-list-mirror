From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Use current "detached HEAD" message
Date: Thu, 29 Aug 2013 11:13:01 -0700
Message-ID: <xmqq4na85psi.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1022906213.34401.1377626164272.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6iV-0008GT-7S
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab3H2SNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:13:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab3H2SNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:13:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BAA83D593;
	Thu, 29 Aug 2013 18:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=Q6eRjE
	rRain+PNsA4/V32aAwT7iIfSpfIu2J0tJV8U8LJapWQJNPekFXZvKN0i/sGwFWLf
	h/e7jXiots+2iHRXz45mb9/fA102MY9i4ZKdtKm7Q4cneTRxWtLk+jG8CB380STm
	5vQ98anroeIdAIy6RoMuRq6ziYgRfEl+pugEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t1cViSrtmjBNrS/1xzgOnY01uM4U8nc0
	WPkxct5SjjbXuab2skvBx6KFpXUOuyeAc0UDSR5F2bCoEfKfqN2N7gHxdsfMz5Pv
	lTHDWilDiqOMDX/OqyWSFF/jTmjEF98OL+q9nXlobs+IbMBZRnfFG89Redwyx7E2
	XYJCyJHTdZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE7D3D592;
	Thu, 29 Aug 2013 18:13:04 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D1753D58D;
	Thu, 29 Aug 2013 18:13:03 +0000 (UTC)
In-Reply-To: <1022906213.34401.1377626164272.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:56:04 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5697AC8-10D6-11E3-BEAA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233302>

Looks good; thanks.
