From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: fix singular/plural grammar nit
Date: Tue, 19 Jan 2010 12:53:39 -0800
Message-ID: <7vpr5595po.fsf@alter.siamese.dyndns.org>
References: <20100119151333.GA9660@vidar.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 21:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXL5E-0002NH-Qa
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 21:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab0ASUxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 15:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112Ab0ASUxs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 15:53:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0ASUxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 15:53:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EA1392B5D;
	Tue, 19 Jan 2010 15:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jv/9HuqsOEWu5nYmabNSUbZXvdE=; b=IjdojR
	QdrQKZP5sYiIqEiYwyZnZdX+qFsT2vfzMBkIo8Yd3vftM7wVABuGoR0Otz6P6ve0
	hH3N1zSYt+pxGOyrMJuXklLl2zUhGbqfhYU2jdncxeMlOW4sUs61DAAaB9SAHKj1
	5iYAaVIhQziDvht8g0p4lIZYllrrkRal4iNjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LaMOgnziV1rLK6U/Xz9yrM1mGI8XKF9Q
	seShEJYI4At16lP0LWVVkDoGusCRUPv6MvhtCicQwnjzqAjMLvwEKdldeLCDaW30
	9Z1uA0VWsSrG+A/PRsPINunmFD5a+Zr60fTb2d04EJoHsTIrftia9tGuqrdMQIGK
	XVqSovSa70w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27DFA92B59;
	Tue, 19 Jan 2010 15:53:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E5992B57; Tue, 19 Jan
 2010 15:53:40 -0500 (EST)
In-Reply-To: <20100119151333.GA9660@vidar.dreamhost.com> (David Ripton's
 message of "Tue\, 19 Jan 2010 07\:13\:33 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA9B628E-053C-11DF-B96A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137494>

David Ripton <dripton@ripton.net> writes:

> Remove the trailing 's' from "revisions" and "steps" when there is
> only one.

Thanks; will apply to 'maint'.
