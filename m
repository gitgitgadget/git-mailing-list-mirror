From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] Yet another pre-refs-backend series
Date: Thu, 07 Apr 2016 15:29:04 -0700
Message-ID: <xmqqoa9lxdcf.fsf@gitster.mtv.corp.google.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:29:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoIQe-0006og-16
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 00:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbcDGW3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 18:29:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757862AbcDGW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 18:29:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9499353A50;
	Thu,  7 Apr 2016 18:29:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QC7BlNIkjsP5QVgyTUs2EHWeW2Y=; b=fFyAMo
	MWdSgikuESf6XyXLpITWxypFS1l7zIrw4EYrLBlHZycK4428B47YidEGVqlTG0IQ
	c3iktiSO+0BKHJ6l8EbwcWycMHIk3Ndve5r8w1N9kZlhqvTrbF4v2VhBPX60uQIZ
	lgMfoftwc+BlREZzzLlDvm5NQYb0oW9O684n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVAMq7gw6kxhzaGGhDFAchac33WwUOGU
	jyA+wbx1tyF86vzXld0e/jez1jaGtacalgwU/X9+YZMxx+ta5nSKT9X96jwg36/F
	KDDyU/iwTXsMPK7SdOv12Rd4As/a/3yIaiGlRO2bTd49ujznoGGoTrvTV+2c/yPy
	P+PBE0N8ZGs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A66053A47;
	Thu,  7 Apr 2016 18:29:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C71853A46;
	Thu,  7 Apr 2016 18:29:05 -0400 (EDT)
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 7 Apr 2016 15:02:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2371B0AC-FD10-11E5-99AC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290992>

David Turner <dturner@twopensource.com> writes:

> We now have quite a large number of patches before we even get into
> the meat of the pluggable refs backend series.  So it's worth breaking
> those out and getting them in before we get into the main series
> (which Michael Haggerty swants to redesign a bit anyway).
>
> This set of patches should be applied on top of
> jk/check-repository-format.
>
> Michael Haggerty has reviewed those of my patches which are in here
> except maybe:
>   refs: on symref reflog expire, lock symref not referrent
> This was the one from later in the series that was straightforward to
> move to before the vtable; the other two were going to be harder to
> move and can wait until after the vtable.
>
> I have reviewed all of Michael's patches.

Thanks for working together well.
Will queue.
