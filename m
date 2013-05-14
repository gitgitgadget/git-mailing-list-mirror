From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/9] interactive git-clean
Date: Tue, 14 May 2013 16:27:33 -0700
Message-ID: <7vr4h9dtwa.fsf@alter.siamese.dyndns.org>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:27:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOdA-0000wc-JL
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596Ab3ENX1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:27:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab3ENX1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:27:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 571481EC83;
	Tue, 14 May 2013 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dbpdCrda7CHZBSRePLRR/gmcIIY=; b=vtvwSl
	X4C3YpYGQh7hk9PM4x1y38fNV6+0CGyByBgBTOmeK+1KgCyl/yCO3Q306b6ujLlJ
	fXHlXYAODM/0o/SLIWg35sF6DKGS+z6W7nMk4/OlHvvf0qTnYaDElN57NC61uAHf
	Hhu+6k7cFC7ZM+rRLHGYTB579ifqkXYEfOTA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dykwHnOz2MNiua6nl2FcR5rQ8VWaS/pg
	Pf8+bSFqzXvFPtAturtoGFq4qF5v8dht2tqEhoWZAT2NniGrF4kyPADO2cBAtEdW
	vRqNP6ETr1S1OzGqW7GFABDmTCsq1Rn8CeFHXzjk1WyL/C6sSXgSKXg327JAI56g
	fewlanvb97g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488E41EC80;
	Tue, 14 May 2013 23:27:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9CCD1EC7D;
	Tue, 14 May 2013 23:27:34 +0000 (UTC)
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Tue, 14 May 2013 16:45:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB56C952-BCED-11E2-BBB4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224370>

Except for one nit in 1/9, the series seems to be nicely done.
