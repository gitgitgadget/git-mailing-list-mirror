From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Build fixes for another obscure Unix
Date: Thu, 13 Dec 2012 10:53:22 -0800
Message-ID: <7v38z9zsv1.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:53:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDug-0004v7-LP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab2LMSxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 13:53:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab2LMSxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 13:53:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 879D1A3A0;
	Thu, 13 Dec 2012 13:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H73MdCYF59NRAKg7YJ24UtCsMPc=; b=cV8k8r
	VzU8iHuuW46qsDRD9CWCMp0Fgwki3gRuEqFXkA2WbTHp0XdLARYSFjFbcTK23Ne8
	txTiMCvv6j2Cu61RbaWk/nS5837+i+7EqtdXY86piCMxL9q/wDDbyFt+DkKhaxNp
	v4CM4veVSB65XtNIbgO38wIHNuzqkvOTxi89g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R6wwbCnikbcBWxRKtyMf5AOXMstK4TxD
	heL8xno2Z38qyKHjjMcGKsd9f1WKrwBO1++AgVazuPM4rie572jYbuY59z+ixg3t
	kz6+bxcpTQDzRIavEO3RG/LeNslIvyBDwUqJ7yOa++aaR9lcdVZYmxhvBSQX1hUm
	uJFwYrR+bbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75B2BA39F;
	Thu, 13 Dec 2012 13:53:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6693A39A; Thu, 13 Dec 2012
 13:53:23 -0500 (EST)
In-Reply-To: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com> (David
 Michael's message of "Thu, 13 Dec 2012 10:22:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F18FF04-4556-11E2-9649-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211465>

David Michael <fedora.dm0@gmail.com> writes:

> I've been experimenting with git running on z/OS USS.  It is not yet
> stable, but I have had to make a few fixes and generalizations in the
> build system to get it to compile.
>
> Would there be any interest in applying such individual compatibility
> fixes for this system, even if a full port doesn't reach completion?

If you post patches here, it may help you find like-minded people
who may want to join forces and help you complete the port, so by
all means.

If I pick up a partially completed series and carry it in my tree is
a separate matter.  The patch has to be cleanly done (i.e. without
too many #ifdefs) for longer-term maintainability, and it has to be
clear that the changes do not affect other platforms negatively.
