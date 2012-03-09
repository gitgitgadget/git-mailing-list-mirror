From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 09 Mar 2012 02:01:17 -0800
Message-ID: <7vsjhi6qky.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 11:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wdZ-000695-96
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 11:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab2CIKBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 05:01:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab2CIKBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 05:01:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8615F53CC;
	Fri,  9 Mar 2012 05:01:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0TbnYgTkDh8yTIl1K6QG/oQVXe4=; b=tOOCa6
	QwwLSHw6LXRr0KDulT6w0HdEennuhjkJb/Qlb0MxOOFKM7xxQ/vY95Oa91zjKQoW
	jYtCYtdfiAM5udvrvzFaTpYiZMmG6CeYkNsBfwJ7Zo+DdEpdhcxSJnlT/azgk1jh
	K0pReGQbcHQePaWlTzSfeFyMvBHNP/EqNSAKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNqf87wOQN2bG2PTjljspviPcPDfbpS6
	rdznD999dvRQQcQxKknNWpQSOBZbBwp5I5gTFp648YQTz+n+Yo/EWqv/bB6hWKsv
	uxDzu7SYSW8zBYkzLsb5xhBPoTMza0xNxwUWWpEWwUtNokqQAed4x9UkgpCPwpdY
	Q5a0IfLQh0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D2F353CB;
	Fri,  9 Mar 2012 05:01:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 148D753CA; Fri,  9 Mar 2012
 05:01:18 -0500 (EST)
In-Reply-To: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 9 Mar 2012 09:31:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1263DC8-69CE-11E1-8AA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192707>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This patch prepares a transition to 'upstream', unlike the previous
> version which was advertizing 'current'. In most case, this would be
> the same, but 'upstream' is probably more sensible in case it points
> to a branch other than 'current'. I don't care much either way.

I would agree with that choice (provided that we were to do this
change).

> I've kept the wording from the original patch, which commits to a
> future change. We may instead relax this commitment and just say "the
> default is likely to change in a future version", or so.

Please no.  Keep it _very_ firmly committed.  Otherwise we didn't
learn a thing from 1.6.3 era.
