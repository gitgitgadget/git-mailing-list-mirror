From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] config: refactor management of color.ui's default value
Date: Mon, 10 Jun 2013 13:50:19 -0700
Message-ID: <7vd2rtg06s.fsf@alter.siamese.dyndns.org>
References: <1370874369-30248-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um92o-0004S7-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab3FJUuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 16:50:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab3FJUuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:50:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D4226DD3;
	Mon, 10 Jun 2013 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=B9vZms
	mJ3qJAU+RSKXF2I9GFCXTt/os8fps74ffJuq9/ckFkghE0Rg01U/tNbJeH55ufhz
	TrVubQIO33ooUwvmf5e9q9zXFk8rg7jUnjeMb0oDBpcrvbHcK5qyEuSmf1wjg5EG
	TNFzNnVntLmcWoBIFFzTdCupeZZstyvl3jPm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBIz5b3vC/41tBQQwcyAX9ZLAVakBJ+K
	FZR1nE+YombF9dyzM0pqGI51D6/NxXWVEHbtNKzoZpg88B1Jie/bF+n5PEtvsqj4
	qyUc+GymYnPoK4TtK9D1C/5TkBHRNPG8C9UScuaCtsV5F4ts8MNZNb465Kk9mgsT
	vprzP2/d4LM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9582826DD2;
	Mon, 10 Jun 2013 20:50:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A71D26DD1;
	Mon, 10 Jun 2013 20:50:21 +0000 (UTC)
In-Reply-To: <1370874369-30248-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 10 Jun 2013 16:26:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D989310-D20F-11E2-A148-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227376>

Thanks.
