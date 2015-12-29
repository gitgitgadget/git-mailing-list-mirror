From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Tue, 29 Dec 2015 10:28:04 -0800
Message-ID: <xmqqfuylhzyj.fsf@gitster.mtv.corp.google.com>
References: <1451326763-8447-1-git-send-email-jacob.e.keller@intel.com>
	<xmqqbn9ajg1x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:28:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDz0G-0004rf-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 19:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbbL2S2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 13:28:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753728AbbL2S2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 13:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B6D236FA9;
	Tue, 29 Dec 2015 13:28:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5rXbr0RAyeQWLJo5ojvmSSXHfs=; b=PE1sfY
	6aEnVaw2VcMI/DCoKA+q+eCIyeHvBTQ4r9cws6+5Zd0ByfaaSuMn8QdFr5ADrX0W
	o/V7SHPR7lb9T2KLh46ccdL0wh/M+k1eg8SkBsrjpuGqGPEIeyncXGMqaBfzKyZl
	MA7Y28owHL8oTyslko0/C4+jMo1BXPZjHJtVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kg2oG7X/1EdAj1JoCDleyooJCJG1Ai5z
	XVuHvMBF6X16XkVeHLd28EqxhgZpN/IoAlCbxkPNZ+UboljSmI4Ph8djdgccHr3U
	hpUT3pFAIUxmyCZTAN2h+DSE5IkL/y2g/RhvynNt/V+v3jabXD0N5hTyWL/4ebqp
	0OcSTSefULU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4292C36FA8;
	Tue, 29 Dec 2015 13:28:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A8FBD36FA6;
	Tue, 29 Dec 2015 13:28:05 -0500 (EST)
In-Reply-To: <xmqqbn9ajg1x.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Dec 2015 15:42:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E72702FA-AE59-11E5-B4E6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283139>

Junio C Hamano <gitster@pobox.com> writes:

> OK, will try to queue again (but I am cutting an -rc today so it may
> have to wait a bit).  Those who have been involved in the notes topics
> need to review it before the patch can make progress, though.

Just FYI, with this the tip of 'pu' seems to fail a few tests in
t3310.
