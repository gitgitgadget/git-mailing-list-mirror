From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please help with GIT install problem.
Date: Wed, 25 Nov 2009 14:23:13 -0800
Message-ID: <7vhbsiqm5q.fsf@alter.siamese.dyndns.org>
References: <377205.65475.qm@web30806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephan T." <stman937-lingit@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQGj-0005LH-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759048AbZKYWXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759001AbZKYWXO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:23:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbZKYWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:23:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D17D82C10;
	Wed, 25 Nov 2009 17:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T0HyIlFAtLCjFK5N4EqI8FknSMQ=; b=xgslBF
	pGYmrNcOKSU0DbT5/dNNMi0yOaNFy0TCGXzK0EuaLEWU+CfR+JQRRtcfVp3tIH98
	62eMclxpAQvVe9HSnzy3noNpKuQtra2yCW4jqi+svH/C671W+ZjU/SeDzZP/KLZA
	Xs1csRJpREC+qo5ohg+b2WOGP8qTk4la8SpfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSP2v+nD7r9N+ux0QdzwLIcRkDRA57YF
	qdoz95HXuTF3gRd4iiT6X1VcWAxnpT9ndhnZWdN8iM9XqLAEfqEKIn907ATRQpcv
	TkQqlU6Q5pBcqee2us5PH1Q6f1jr2UwsTf4Ae+rfI2RPn2NPWgUXAeVcU+l/gAPG
	XVSze88CsZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B240F82C0F;
	Wed, 25 Nov 2009 17:23:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A61582C0A; Wed, 25 Nov
 2009 17:23:14 -0500 (EST)
In-Reply-To: <377205.65475.qm@web30806.mail.mud.yahoo.com> (Stephan T.'s
 message of "Wed\, 25 Nov 2009 14\:07\:54 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21612582-DA11-11DE-A0DD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133686>

"Stephan T." <stman937-lingit@yahoo.com> writes:

> My system is a:
> % uname -a
> Linux naboo 2.4.21-50.ELsmp #1 SMP Tue May 8 17:18:29 EDT 2007 i686 i686 i386 GNU/Linux
> ...
> What is missing on my system?

Perhaps reading INSTALL will tell you a bit better?

On a typical Linux desktop, configure is unnecessary.
