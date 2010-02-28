From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] make union merge an xdl merge favor
Date: Sun, 28 Feb 2010 12:15:42 -0800
Message-ID: <7vwrxx2k29.fsf@alter.siamese.dyndns.org>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com> <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpYT-0003cz-JT
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032000Ab0B1UPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 15:15:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031966Ab0B1UPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 15:15:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 111A29D448;
	Sun, 28 Feb 2010 15:15:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gnCn1qWF/3IZCWnHP/gMIPOPz9U=; b=BXMvUM
	goMuu0GcZDlIYth1Enj/ua20VR5O8WYdBjoIU/RlOk53U8ncULCF3hsfEtdpLZ1i
	v5fkmmX8ktvG7H9Y49PQMA6sEjPksCAZkLDygCXl3PZGwMlykt1z6GG6HIWJRK+Y
	XCCRsq91rp5oTlzYGrnGWl/vJWnogNxSqu658=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZb9eVMFTXJs2RpU2UsXfqMYDIjsHb9I
	h/fZ4x4nvQYbioGtycGC5GalCBqoQhS2QuuNw1cYsBK4F3i28Ka4ss9fqwJLPw3g
	dE0YvI+DC7vTbuhsp3GZcakpZbkpDRKIYPx0tV++1DhCRJ9XoZS18zUIZXsQkFtu
	UIcZA1Z6ZSw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD8D49D444;
	Sun, 28 Feb 2010 15:15:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E11B9D443; Sun, 28 Feb
 2010 15:15:43 -0500 (EST)
In-Reply-To: <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Sun\, 28 Feb 2010 20\:56\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F873D4E-24A6-11DF-B415-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141267>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> The current union merge driver is implemented as an post process.  But the
> xdl_merge code is quite capable to produce the result by itself.  Therefore
> move to it there and teach git-merge-file a new --union option.

I like the idea of patch 2 and 3 but they are independent of what we do
(or don't do) to merge-file.  Could you flip the order of the patches so
that 2 and 3 can go first?
