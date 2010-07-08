From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] implement automatic fast forward merge for
 submodules
Date: Wed, 07 Jul 2010 17:34:46 -0700
Message-ID: <7vy6dmreu1.fsf@alter.siamese.dyndns.org>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
 <f17d78656a71558fd290e0b84cad03f22f6fcbd8.1278444110.git.hvoigt@hvoigt.net>
 <201007070152.17802.johan@herland.net>
 <20100707133557.GA35678@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 02:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWf4y-0005JA-Hr
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab0GHAe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 20:34:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab0GHAe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 20:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A53F9C27B5;
	Wed,  7 Jul 2010 20:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFb7HIaFA0+/jRGppRKcw7GqAcY=; b=iJtOLZ
	9QHb3WOjZfPj35wxb5y9Et/XGxe3bGO0cqWM7VkbXW7llBkMcTofthSqN0URtkI7
	8zp+E2gbrp8zYOAJgb4VxVX1xz++dFr/HIpcSiA+6gKbX+RPylGMJr+802S/2YBE
	SFWdluq1uwu2beGEwntu9meYmLz62aERZClDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tdvZx8XCwEcOu2+hl03uMNcDYssW9vf6
	1CnFPXNx6ZhpxKrn4DLHhjh0f5GFSSKqmlYUA+kKoba5lMAaVoe9VVzuRR92i18h
	KRIYf+pOGLNELCZGLoUsfGTPT1pxeEF7NZgW6xUzDdpztP1pcYoMhXUSVrxnLjtu
	WZHowHic1Fo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60802C27B2;
	Wed,  7 Jul 2010 20:34:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A874C27AA; Wed,  7 Jul
 2010 20:34:48 -0400 (EDT)
In-Reply-To: <20100707133557.GA35678@book.hvoigt.net> (Heiko Voigt's message
 of "Wed\, 7 Jul 2010 15\:35\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A018743A-8A28-11DF-9B86-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150521>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> I cannot find the "$(<expect)" construct anywhere else in out test scripts.

Thanks for spotting and fixing.
