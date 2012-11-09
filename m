From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 09 Nov 2012 12:27:35 -0800
Message-ID: <7vr4o2plmw.fsf@alter.siamese.dyndns.org>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
 <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
 <20121109201057.GA11368@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:27:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWvBA-0006Ul-RC
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 21:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2KIU1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 15:27:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab2KIU1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 15:27:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DBEC94C5;
	Fri,  9 Nov 2012 15:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uzzDw4ZCFXKdQr60Dc8zfpaTmMA=; b=ZA8SgJ
	aM3e1BJmyRR+UxLqN5BOLducbawQNMof/0J1kG/XPdXsA2oPcb6M2BZnJX+cQGWU
	sVJS7DpYGyAOQSGtcC479O8dCYlAESPXXhCWLdnaOqrqlwcO4/sJqwZFOSEW3n04
	mMrGsQy3fo13C6ZU4y3Nve6MJL4PQjawPPvI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vyH1z9mPNfV87gz/J+Lqv1FgT1B9wWnM
	lC58AliFIOs576MFkQyhUWxPUKO+OC0LdR5ClD0oPu6G5ijsoU2J2YeEaqVHwPMW
	QpME/emx/PqzmDUCQP3E+8eun0Wppl0M8EQD6nTYbSpNE1LbR5FxqjAmQNOn/fE4
	ch/FzN5RFCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C7B994C4;
	Fri,  9 Nov 2012 15:27:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76BC394C1; Fri,  9 Nov 2012
 15:27:37 -0500 (EST)
In-Reply-To: <20121109201057.GA11368@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Nov 2012 15:10:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6D3BCD8-2AAB-11E2-A3C0-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209247>

Jeff King <peff@peff.net> writes:

> I have not been pushing the individual topic branches to make life
> easier for people who usually just track Junio's kernel.org repository,
> and would not welcome suddenly getting a hundred extra remote branches.
> I can make them public if it makes life easier for people, but it may
> not be worth it at this point, with Junio returning soon.

What we should have arranged was to have https://github.com/git/git
(which is not even owned by me, but I asked somebody at GitHub to
assign me a write privilege) writable by the interim maintainer, so
that normal people would keep pulling from there, while the interim
maintainer can choose to publish broken-out branches to his
repository.

And it is not too late to do so; from the look of your "What's
cooking", you are doing pretty well ;-).
