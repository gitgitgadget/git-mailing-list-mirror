From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8 v6] gitweb: add a get function to compliment
 print_local_time
Date: Sat, 30 Jan 2010 16:21:48 -0800
Message-ID: <7vzl3vf7j7.fsf@alter.siamese.dyndns.org>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
 <1264890645-28310-6-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 01:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbNb4-0000Ld-W5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 01:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab0AaAWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 19:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474Ab0AaAWF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 19:22:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0AaAWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 19:22:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B9C9507B;
	Sat, 30 Jan 2010 19:22:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=38Kx4G4aeqlGBOKSXD76IU7yyxs=; b=EBOsJV2MYXJoMHH1JjgfNxi
	S4wE0RGj/w+2wg4zJ/U5GnPStPKT3sgO79RAIvfJKx1fSw8uMp/PdnywuSjxv+wc
	wIRajsExgFQdYHKnZcEpyNAjlfGWLyMZIc9KDnvUybf8oYXbkk9mNTewjuzRnGYt
	3dSVKXIhF1e4Rqb0GAtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PLyLTE4AmI2Vf7ffGOer1cKvuMNIO98SFjopvC7SuNWGT1Wuz
	T0eVsJ18if7fatW9vr3IUpY06/dWEHkDzBoJX8IN0X6KW4OD/rxWErDb1bgLkmW7
	V5klap50ws/S/Q3E5QigYpOfkabnb1QxY+SDTu0K2m3nFP2QSLWFS+reL4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A61B595079;
	Sat, 30 Jan 2010 19:21:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEEE995078; Sat, 30 Jan
 2010 19:21:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3DD2382-0DFE-11DF-A326-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138522>

Jakub Narebski <jnareb@gmail.com> writes:

> This adds a get function (named format_local_time) for print_local_time,
> so that the basic function can be used outside of their straight printing
> operation.

I didn't particularly feel like giving praise to print-local-time nor
print-sort-th, so I rewrote the log message for these two commits ;-).

    gitweb: add a "string" variant of print_local_time
    
    Add a function (named format_local_time) that returns the string that
    print_local_time would print.

Thanks.  Now I can drop GIT_SKIP_TESTS=t95?? while building 'pu'.  All
pushed out to the usual places.
