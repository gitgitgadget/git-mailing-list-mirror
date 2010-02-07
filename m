From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sat, 06 Feb 2010 18:21:37 -0800
Message-ID: <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 03:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndwmc-0000AQ-E4
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 03:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab0BGCVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 21:21:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab0BGCVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 21:21:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA5697C2E;
	Sat,  6 Feb 2010 21:21:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z7mAz4j9t+Bil48Sr2+OBlW2Uzo=; b=LHb2pC
	1YiPH2OwTmwN2iSXEQMzi1mCa8twq+aJ+pClIYkSjOEwIF+M+Qm0Of2/9VJRlnus
	aVZDcezDUM5QuBCCSVr+ji4vuQGeDQrKHZeOEeEKY0Nkl/1mg8dW4zoZbejeJ5mx
	rtDaCmc0ub/oD6DSm7aOkPxIE2g1RYYSCBNMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0k4jpWjxfRGzAWzZqflES7Y9U80ITAT
	g3pfMiyAs3QUX5AMVN0dRHClihNntmtv8vsKkKJPmKxMaqfrcrCB7QxcvjP7aTsB
	0JMmW0DbG/H7pdH+6Mrj8AcXaUW+6Gk1Kt8LKOp2s/KlPHQ6V7KL6D8fD04A234E
	U/SP3gYciTo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F1797C2D;
	Sat,  6 Feb 2010 21:21:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3674697C2C; Sat,  6 Feb
 2010 21:21:39 -0500 (EST)
In-Reply-To: <201002070236.12711.johan@herland.net> (Johan Herland's message
 of "Sun\, 07 Feb 2010 02\:36\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8817EDA8-138F-11DF-94F8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139212>

Johan Herland <johan@herland.net> writes:

> Furthermore, although we currently assume that all note objects are blobs, 
> someone (who?) has already suggested (as mentioned in the notes TODO list) 
> that a note object could also be a _tree_ object that can be unpacked/read 
> to reveal further "sub-notes".

I would advice you not to go there.  How would you even _merge_ such a
thing with other notes attached to the same object?  What determines the
path in that tree object?

Clueless ones can freely make misguided suggestions without thinking
things through and make things unnecessarily complex without real gain.
You do not have to listen to every one of them.
