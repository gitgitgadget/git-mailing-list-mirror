From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7406: Fix submodule init config tests
Date: Sat, 06 Mar 2010 20:00:55 -0800
Message-ID: <7v6358bx1k.fsf@alter.siamese.dyndns.org>
References: <1267777238-2646-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 05:04:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No7gC-0001aR-1i
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 05:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab0CGEBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 23:01:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0CGEBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:01:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9D79FD71;
	Sat,  6 Mar 2010 23:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=rtTLtt
	Rc+Sqd7fYhVCMHgTi6KjPClJcM2UD9Afj2ijgHfCP3ARuxi0SuEHfWAaQuQx/70B
	V/fOy96JTffdH0WsF8D4AmLW1e/rPbKYRwbpdOviJ0TBEWSieWoLx29JTo6SqBC7
	mI4JJ/O4m9vZ2x/kZk3mhwmY/JUaFfa+9jtsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g733eEOMkumV7/gDOLQKJS4pdzo6jsDg
	FK6j6/EqtQuZSc52+zAXcTM/atshnG8j7grO87yGp9ARJGHCppG6RSJxYZ4SMZnE
	4lCqXL3V5xULYaQR88Q2cBdvR9XKuUMu6aCFRt9Aoui+zUhIW8Dt9W/t1B+YCD3+
	iBuvUA4+bKE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 020F29FD6F;
	Sat,  6 Mar 2010 23:01:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1589FD6E; Sat,  6 Mar
 2010 23:00:57 -0500 (EST)
In-Reply-To: <1267777238-2646-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Fri\,  5 Mar 2010 00\:20\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C255116-299E-11DF-870D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141645>

Thanks.
