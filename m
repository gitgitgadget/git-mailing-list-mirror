From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch for git-p4
Date: Wed, 05 Jan 2011 15:16:07 -0800
Message-ID: <7vfwt7c56w.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=sNsDy9oo0iBE-qJwvFSDMFYma3oYhbP1J-th=@mail.gmail.com>
 <AANLkTimdMH_HcF-Qk3SSmqT24OgxynYnXpSLiDtU7Y6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Garber <andrew@andrewgarber.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 06 00:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pacaf-0003nC-Kw
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab1AEXQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:16:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1AEXQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:16:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A96C4ED0;
	Wed,  5 Jan 2011 18:16:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=47k8SPpQrSUgK7t8riF0pAxN/TE=; b=Otau4Z
	Bjgn2zHicFDZRpoW/Y+lmQ/Yaq6MFEfyfi28ZfOUn0VCOixaLBpYboQeb9WXve5L
	164ZUQuNhpym8lRiKrJvwVGSmr0pVV8NGo1AzwpbNJyLOg7UDv1yhnZDFPOpXjcP
	CHM0Tp5XbRtDR6pyo0BYcwECPWq0KY93BlnTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LYdqaP/XKJNeReDwfDxh/C9r04MYaimF
	LCmyaZfAZqROZyYcRxjwKpAkBpH/nTiyugWJmARbnUXZ1GjBaH2WzwmlLST8J7qI
	Vw9qqv0XAHOiGqpiZgHEn4b5S8Ukw1NUJ1rzE6MF27FjpkdpMMD0Q2KirOSDRliP
	N59wEIG+RK8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 286814ECF;
	Wed,  5 Jan 2011 18:16:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 146F04ECE; Wed,  5 Jan 2011
 18:16:46 -0500 (EST)
In-Reply-To: <AANLkTimdMH_HcF-Qk3SSmqT24OgxynYnXpSLiDtU7Y6c@mail.gmail.com>
 (Erik Faye-Lund's message of "Wed\, 5 Jan 2011 22\:31\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E07176A2-1921-11E0-8A32-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164606>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> We tend not to write commit messages in past tence. E.g "git-p4:
> replace tabs with spaces" (notice that I removed a 'd').

Just for the record, we do not write in present tense either.  That
"replace" is imperative.
