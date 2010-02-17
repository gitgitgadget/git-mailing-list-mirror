From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 00:14:52 -0800
Message-ID: <7v635w5ldv.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
 <7vljespt2l.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171427080.3414@vqena.qenxr.bet.am>
 <7v635wimac.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171950040.8560@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhf3y-0002Ra-J3
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934165Ab0BQIPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 03:15:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934126Ab0BQIO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 03:14:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 737369A3D3;
	Wed, 17 Feb 2010 03:14:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/vjohR3Eeli3Tk/Fg7EAIFxeIYE=; b=ciH+5sEbTktf9sji+1hwbIH
	7mU1n1kBk5/l2FggAu3zj7E0vzm3aTtg5+YDa1wr1UpF30pTmvYw0lIWCu8A6rcv
	YtQHZuVshT4T2FrH7Qyxu7/M9kGupkTzsZeRAnm5uK8frDYP1xSPmk6aqntMyKXK
	T1b3h184qhMod0zRCtdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TnicURBf+S3hNAzpKshWc6t3CFz94HNgEOMrnYSEXdJivnlqG
	ixmu3Zz1xu6MFZfiK8phXo7IoLEDBu1RWKhZiIAdw42HKleDbjIq7NsJ7m1dQ7yl
	m+ZgqvJHpfJmhR66uYSsoPgAdC+9H6PxrxModQ/JEkqFLClE1r71otuAEs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 036E79A3CD;
	Wed, 17 Feb 2010 03:14:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F6429A3CA; Wed, 17 Feb
 2010 03:14:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8849AC8E-1B9C-11DF-A336-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140217>

Steven Drake <sdrake@xnet.co.nz> writes:

> Have you commited the git_config_maybe_bool() code?

Not yet, but now you mention it, it probably is a good idea to make the
"maybe" part a separate patch, independent from log.decorate.  It should
be useful elsewhere, I guess.

> By the way is it alright to send patches that use inbody-headers and/or 
> scissors?

If used judiciously, i.e. when it makes it easier to follow the
discussion.  It would sometimes make an important patch more likely to get
buried in a deep thread, though.
