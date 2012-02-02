From: Junio C Hamano <gitster@pobox.com>
Subject: warning: tip of 'next' rewound post 1.7.9
Date: Wed, 01 Feb 2012 17:44:23 -0800
Message-ID: <7vy5smypoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 02:44:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rslj4-0000MU-VD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab2BBBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:44:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158Ab2BBBo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 20:44:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5E26929;
	Wed,  1 Feb 2012 20:44:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	BCE4pIIveor8iLV9MzJ6d9Y8oY=; b=ukU0u6Ffw/rtyRtDBjhhk6ix8c97AWhSn
	XYhgSXVUc84bI0Yyl4lu/QTBtdsQsa9xxsoDuUozKLFKKUpf+587kcMSE53pdKZk
	ugFxViHENoZVQCytePk41sZzDCQJrIp6spEc59LMg8FN11XY3cg33PHSHQFEgDzT
	7RhlfkDSMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=n8M
	s7w0Th/hrIx/V5XUit7J0jMwMdZzjakTFhy6x4+9f24k0ubfZ5qLA/u0xZNDezDC
	Lq3LspbOLrTe1k7nVbgr8Zrvw6DheuS2iTxHoejCOoMhPLsKJ5dJQf6f8aK8GOsZ
	bqO2tN07pBE2BejurbWCz9szlELIkQLE4VTPqzUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A866927;
	Wed,  1 Feb 2012 20:44:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33E576926; Wed,  1 Feb 2012
 20:44:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FD3511A-4D3F-11E1-9CB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189572>

I've finished today's integration run, and the tip of 'next' is now
rewound.

The draft release notes to the next release calls it 1.7.10 but the name
is tentative.  We may want to switch to two dotted-decimal scheme and call
it 2.0 or something, but I haven't decided it yet.
