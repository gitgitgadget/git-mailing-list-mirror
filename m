From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] reset: trivial refactoring
Date: Fri, 30 Aug 2013 20:36:12 -0700
Message-ID: <xmqqppsuwmz7.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:36:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFbzC-0003LH-8I
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab3HaDgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:36:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab3HaDgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:36:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7312033746;
	Sat, 31 Aug 2013 03:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=teOgjWsC7YSmPp1jKD8K2k2/9og=; b=iwiQ+6
	aO+vP+JnQHoItvFW47CEg0H5dYB5Z5xzUDT2GVKzzqFo75VBkhA9UXKLB4vGunNF
	Dn1GzcqF9M7K6kqQ+p+0kMcm7yS2d1gu4UJ5UVYHFMGcJ667GJQlqRxQkkmvnztA
	JDiF20MeEYQmSvgGsZeC7egD09eTpk0HILlrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSf4WvvA1VL0Mhqp/hf/xs1appWrRSkA
	mlRjd6lBZBjn83YznCT1rnRoa889kEmV/8jjN/ZGa/3Z33iQBQXSiCtn0vRWC77T
	jPzZ55dSzSZrI/YHS/uHcNRRCnomWXEZmCOWRPDx/XjDi1voOxKhxlapii+vF0nr
	OmfHHmqH98E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6941233745;
	Sat, 31 Aug 2013 03:36:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDABC33744;
	Sat, 31 Aug 2013 03:36:13 +0000 (UTC)
In-Reply-To: <1377899810-1818-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C6AFFC0-11EE-11E3-85D2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233493>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> After commit 3fde386 (reset [--mixed]: use diff-based reset whether or
> not pathspec was given), some code can be moved to the 'reset_type ==
> MIXED' check.

Makes sense.
