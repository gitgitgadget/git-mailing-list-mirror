From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Smart-http documentation: add example of how to
 execute from userdir
Date: Sun, 03 Jan 2010 00:34:50 -0800
Message-ID: <7vzl4v1t91.fsf@alter.siamese.dyndns.org>
References: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com>
 <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 09:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRLvl-0006OS-1n
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 09:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0ACIfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 03:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087Ab0ACIfH
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 03:35:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0ACIfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 03:35:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E860D8DDCF;
	Sun,  3 Jan 2010 03:35:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3SN/VCHSPXkh8jx9qcqksqR4CYo=; b=hC8+YY
	uPY6fAHpQu2SjrC3Xo9Ryg8Cq6xm5yWvA60vE5sjtiUpWTi04KhHXZwj+Pb+OsMJ
	KQJg9GxnlDb0voII8FIY11oG/yXukuRaV+HDT9P2ZSNCDqGDs0qkT6SNJL3+/7LV
	uGrADENokVrSLb8cuHjJU3KWqajaS4Dp7vDKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kbWWKBwqnNJ5ZBcw5noeaFR6Zg3EHJ6+
	nNJzzaV1IrtBbt6JI1UsNWGwVYMGSGlzzlBHS1E+KcFBV5RoaKCW+qgWimwylN1C
	1ahH5Y0rcI2aP+Fu4KJyIE8Ly83N7PvVVLUQjpgtmDRv3K12rZkCu5Ns7A9CZJkS
	1cQn5n537KU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58C7C8DDCD;
	Sun,  3 Jan 2010 03:34:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A6C38DDCC; Sun,  3 Jan
 2010 03:34:52 -0500 (EST)
In-Reply-To: <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com>
 (Tarmigan Casebolt's message of "Sat\,  2 Jan 2010 13\:18\:21 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFBEB69E-F842-11DE-B4FA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136072>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> Smart-http may be an attactive and easy way for people to setup git
> hosting on shared servers whose primary web server configuration they
> do not control.  To facilite this, provide an example of how it may be
> done.
>
> cc:  Tay Ray Chuan <rctay89@gmail.com>
> cc: Shawn O. Pearce <spearce@spearce.org>
> Editing-by: Tay Ray Chuan <rctay89@gmail.com>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

I still see Cc: here; are people named above (and others commented on
earlier versions) happy with this round?
