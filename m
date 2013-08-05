From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t8001, t8002: fix "blame -L :literal" test on NetBSD
Date: Mon, 05 Aug 2013 10:44:48 -0700
Message-ID: <7v8v0gkp67.fsf@alter.siamese.dyndns.org>
References: <51FFC2ED.3080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	git discussion list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 05 19:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Opz-0004FZ-Rn
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab3HERow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 13:44:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab3HERov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 13:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F152D36E3B;
	Mon,  5 Aug 2013 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=gT0KwZ
	h/EQxVGWzok+bYIwh4HPvuC8aypbJR7uhXnKzD6BWGNAvesksGEiX+Hf1INDRb+c
	J8zXQRrrayb37PuaO5yuyCS8smd4Ev947S9ZRDKHY6LmsgOzIpkAPa45zYM+fYjP
	rAJVB8SrTesvgEH+TSA9ff2mQe3No4rRmfcMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jE8uCJF3Bem0rnT7R+xQGId0wDq8LCQW
	UzRrznaJZdgJt7rED40WclOiWRWodmr5fdWz29uWRUczo9/Uew2DpfG7zheEQ0Qr
	pggEkH3rCnTq7hl0Yb9uq6yZt4WjSJTrTfjCOy5qQevrpzpOeKs0+UGF0qeLMn90
	OGa6I0LszVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E228536E3A;
	Mon,  5 Aug 2013 17:44:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3008A36E37;
	Mon,  5 Aug 2013 17:44:50 +0000 (UTC)
In-Reply-To: <51FFC2ED.3080906@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 05
	Aug 2013 17:21:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA30A2E4-FDF6-11E2-95CE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231682>

Thanks.
