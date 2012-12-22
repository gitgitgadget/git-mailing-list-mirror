From: Junio C Hamano <gitster@pobox.com>
Subject: Hold your fire, please
Date: Sat, 22 Dec 2012 11:22:34 -0800
Message-ID: <7vd2y1rix1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 20:23:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmUev-0008Rf-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 20:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab2LVTWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 14:22:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab2LVTWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 14:22:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AE2FA09E;
	Sat, 22 Dec 2012 14:22:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	7bKSxIdYZW4fv+wA4quRmQKXPI=; b=CCdLQHDW/49s+FP9AqrwEYSvfqpd7irLe
	Omm0qNnREWzuGUyU3PnMomUxDxrEsP09h2DGwAGk0rf4Ww4gMbBp4W9YL1WFPDRp
	kPbK4/iyeCowLwTgh+diA58eO5kk4usqRdBUhpo2pz7TMjQp2pfXuN/ljVIlXQMu
	/BJU+joAcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=d0R
	L9DdvpeJJSTx75FWiO4+G4PxNeSJqpY8fQBZfxaSiVoL2EHXGDPzRtdMZv2MZq0O
	ITZBga15m1lfgVSA8m0lqvIay89h13MULHc0Vr1KPWj+/HdmdldBccl4xDXY2lwm
	TUx2d/J/BMR9xdgGo9vIhQXwTc2vKwdn5SU3OASc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECAD9A09D;
	Sat, 22 Dec 2012 14:22:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68A00A099; Sat, 22 Dec 2012
 14:22:36 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F16094D6-4C6C-11E2-AD55-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212067>

Primarily in order to force me concentrate on the releng for the
upcoming release, and also to encourage contributors to focus on
finding and fixing any last minute regressions (rather than
distracting others by showing publicly scratching their itches), I
won't be queuing any patch that is not a regression fix, at least
for the next few days.  I may not even review them.

Thanks.

And have a nice holiday if you are in areas where it is a holiday
season ;-)
