From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with
 prefix
Date: Fri, 07 Sep 2012 14:20:38 -0700
Message-ID: <7v7gs5wmvt.fsf@alter.siamese.dyndns.org>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
 <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
 <7v1uidy6ga.fsf@alter.siamese.dyndns.org>
 <CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com>
 <7vfw6two6o.fsf@alter.siamese.dyndns.org>
 <CAN0XMO+jbZeO=2NHisPizHfNwR62ebkC06KVZ8xOhgmRoAT4nw@mail.gmail.com>
 <7vbohhwn20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:20:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA5yr-0004ZF-8X
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab2IGVUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 17:20:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662Ab2IGVUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 17:20:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 441308672;
	Fri,  7 Sep 2012 17:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DRL4iwML1PXpjq+rPhpRi4IOXpA=; b=iLkUbP
	ZktsgqNRsIH9TbIzwGlXg8UaXad2DezoVO71erxGuBZh/ZzU9/ibVKpA/B9js6bF
	ydGoBm/+jYRKH05q0f9unWABf/uQApfWonve2nyzCLf6oCab/Dv2jzme5z7EPmeM
	8QSM3YIjxPB4DIEjktma5cKu9DgGtuLPYzeh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xp7BQAUX41uWgYzO0mue3Ha1Ft2k3ssx
	l/XAhP3mzokIZ4yNKwHQzrRfUHLccKplxJ/H/A8h4EuDRKSNkd6dSiyU6oSgDxGa
	uSBmEb91YIMBNzIC4W7dSGgl99KuqO6zEwsgiyraw0gH9gFZ9Uqop4NGdiSglDaj
	pjId+mRBcOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 304E98670;
	Fri,  7 Sep 2012 17:20:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1EC3866E; Fri,  7 Sep 2012
 17:20:39 -0400 (EDT)
In-Reply-To: <7vbohhwn20.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 07 Sep 2012 14:16:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF86F0FE-F931-11E1-ADD1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205001>

Junio C Hamano <gitster@pobox.com> writes:

> experience in such a language, I know I was talked into doing it
> this way when we did 23cb5bf (i18n of multi-line advice messages,
> 2011-12-22).  Could you dig around the list archive to see?

Heh, don't bother.  Instead, start reading from here:

  http://thread.gmane.org/gmane.comp.version-control.git/187592/focus=187601

and learn what happened to the topic by going forward, or why it was
done that way by going backwards.

Thanks.
