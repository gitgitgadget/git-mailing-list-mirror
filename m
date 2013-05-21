From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] remote-hg: fix configuration notes
Date: Tue, 21 May 2013 10:14:27 -0700
Message-ID: <7vhahwp85o.fsf@alter.siamese.dyndns.org>
References: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueq8y-00049A-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab3EUROa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:14:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab3EURO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9D320A20;
	Tue, 21 May 2013 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6li0pIve5ld/q9KLCnBclrv/xtA=; b=RpI5Ak
	NSKM8pajH7U+NPjNcekkamnvB7zF1wGehgO11hQgp+C44ynaWIkPvjh9DjYcUn3p
	WzRqKn92R/00J6QBNvd9NSnzxtfL5mtD+F7Hv0WbtTB6OMoVwqnafrLhDpwLnLqY
	G4vWBQFAZJzPlXbcI46K53lgIZgyp1b9moARQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjY3c5LfWmWvNvwZocImq8h59UaEt5QM
	+3m/pKBlYNbfLKKHnMeXTq49L4IZrbi6OmKGTqRSvWXFTGDG233knEpbE7FPiDsg
	BMaXxvZq6/Nfj4fydNloGxl637uqIlF15fO/9IY4Zb6DjwyHKXdLUZcHNphdJIyB
	rGvG2ynPImc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4409F20A1F;
	Tue, 21 May 2013 17:14:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9778020A1E;
	Tue, 21 May 2013 17:14:28 +0000 (UTC)
In-Reply-To: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 20 May 2013 22:47:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E50C9F66-C239-11E2-8790-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225044>

Will apply for 1.8.3.
