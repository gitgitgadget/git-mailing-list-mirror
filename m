From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Update linux-2.6.git location and related examples
Date: Sat, 29 Jun 2013 18:44:34 -0700
Message-ID: <7vfvw0l6d9.fsf@alter.siamese.dyndns.org>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
	<cover.1371911897.git.wking@tremily.us>
	<20130630010532.GB25463@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jun 30 03:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ut6hC-0002fJ-Cy
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 03:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab3F3Boi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 21:44:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab3F3Boh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 21:44:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FCE223EC6;
	Sun, 30 Jun 2013 01:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8XQNrfZN22/jZMZ7N5p91cCB6xQ=; b=btzikP
	Vo7tZnbsSUUrOtwJyRT+qc8DBOPnUm+Qt9xAdtkEER3mo8cgW/oOFyMFfmisuSkh
	gDFI8cLuanx84OIgczNRKxtmcWD1+H9aKC+MG2L1uzJ5jQtnvwFCvJVl+2ni5hxO
	iztmmjZkb8OButFyGDFa5zvmRZIbrOZA2WqN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fi2zpcSgCQ9hPLrFDRYiPSxmxzjDDFr4
	l+MhIsr2hC4SmUS1Bobh8SYoGqAm4VFYtdVZdlIRTISrflvfgAgByR9ZmyhiaFhS
	8lC8FDMOah7yZd1VyTmG4+j16iyHnkJQAz0BejIWAvAkvfRO8odAC12SPVZyQjU3
	i1AD93J2sMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6658423EC5;
	Sun, 30 Jun 2013 01:44:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E47E323EC3;
	Sun, 30 Jun 2013 01:44:35 +0000 (UTC)
In-Reply-To: <20130630010532.GB25463@odin.tremily.us> (W. Trevor King's
	message of "Sat, 29 Jun 2013 21:05:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E8B2830-E126-11E2-A732-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229259>

"W. Trevor King" <wking@tremily.us> writes:

> On Sat, Jun 22, 2013 at 10:46:23AM -0400, W. Trevor King wrote:
>> David and Junio mentioned that I'd missed a few 2.6 references in my
>> initial pass.  Here's a second attempt that does some deeper
>> reworking of the effected sections.
>
> No comments after a week, so I'm giving this patch series a bump ;).

Hmph, didn't I queue them on 'pu' already?
