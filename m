From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 10:07:10 -0700
Message-ID: <7vtxkrmlz5.fsf@alter.siamese.dyndns.org>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
	<7vk3lno40x.fsf@alter.siamese.dyndns.org>
	<CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4nw-0008RV-RL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423521Ab3FURHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:07:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423404Ab3FURHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:07:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7416D29D0F;
	Fri, 21 Jun 2013 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Ivy+MLQA8Z6FcdKhUTjQ2OlW70=; b=cCxXMS
	xBDmqQHsPFOw/adXMTV2G7Os1ku1lQXmcZI+l5RfWhkPmHZKZ5i+30XTQqJtPPO4
	1eEFkpBZTCFSKk3RRzV4p5t0lPt1UqZ21jUet6rv8MEZB0g53pqOreqlRyKgzS6b
	WZ6ncTDeXrBUsgOB52268z4yoC9+jXj/XqQCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJBxfgBNWyAFbWkh1hCRhfmonEuAjWi4
	8707IR7f3/Z65vz5xnAM/+cBmDkr1j/sFs7ZM1LlYiPs8Zb4X8RcpykYFaYoXzC+
	+dwtT+5u799DrUlV8j3SSyte1DWX0Pim2MSQ8ia/nDxf6xw/m+3UW16szmvgoTaI
	l6XJy76Q9Hc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64D6529D0D;
	Fri, 21 Jun 2013 17:07:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5334629D09;
	Fri, 21 Jun 2013 17:07:12 +0000 (UTC)
In-Reply-To: <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 21:37:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03D05ED8-DA95-11E2-ACDB-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228634>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ...  I've noticed a significant decline in
> list-reviews in general: a lot of good code on the list hasn't been
> reviewed.

Hmph, I do not particularly see that happening.

I actually think all the usual suspects (I could name them, but I
wouldn't---you know who you are) are doing a reasonably good job on
patches that touch parts of the system that matter.

Patches on the fringes (e.g. stuff in contrib/) may need a bit more
love, though.
