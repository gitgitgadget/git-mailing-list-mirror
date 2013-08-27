From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] Improve section "Merging multiple trees"
Date: Tue, 27 Aug 2013 12:15:57 -0700
Message-ID: <xmqq7gf7c5ci.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1931551541.34581.1377626589383.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOkK-0006dq-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab3H0TQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:16:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab3H0TQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:16:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEF423C161;
	Tue, 27 Aug 2013 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=weyxe/XoT/8MAq2k3keQssz8Hfs=; b=Gl5hMx
	ul6sQYW7fkqDWq4yBtjKm4U2n2LHKJTIX0T4e9MK/z1Jz5vGnHzkU7iNJUPo6Rkd
	XhzwRVQSQi8ruGQjelMAIiu5yMuYod2wLl2kSaCoQ838b+An9Cul89oq3wyqMY5y
	Wze5IwbppQ0V5n7/OzEhy3aODhV6u7yMDPdQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pm9reA6xixNuMVdlsEaci1NIqgRO1Pw8
	MHXJio5O8FrO+KzP0JATr3YpGw+e3oXdgx6h0WY8eLmlONK5oXjLVCeEhUoY5C5N
	4DvdPIbcH/eqACMydmK1hmNUyBhr4NApt+F67FeaPhlXohMBD+dr0bMTFPllBCjt
	l5yWVsWpN5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFCFC3C15F;
	Tue, 27 Aug 2013 19:16:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F14C3C15C;
	Tue, 27 Aug 2013 19:15:59 +0000 (UTC)
In-Reply-To: <1931551541.34581.1377626589383.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:03:09 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B5AE95A-0F4D-11E3-A8D7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233141>

Thomas Ackermann <th.acker@arcor.de> writes:

> Remove unnecessary quoting.
> Simplify description of three-way merge.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

The update is good, but I wonder if this belongs to "User's manual"
these days.

Perhaps we should start thinking about ripping the "how to use
plumbing" out of the end-user manual and moving them to the
core-tutorial where this kind of thing is more suited for.
