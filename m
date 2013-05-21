From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 13:33:31 -0700
Message-ID: <7vli78m5t0.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-2-git-send-email-artagnon@gmail.com>
	<7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
	<7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
	<CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
	<CALkWK0m7VBz3wDGUACJAfp33M1GYqKCeMCkQwrgA7kqRMp_rtQ@mail.gmail.com>
	<7vtxlwm6z4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kVAG4Gg3mgZv+0pXJocwDzZYS3gwVjxPy9cmBEkB2sFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UetFa-0003gv-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab3EUUde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:33:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab3EUUde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:33:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A6121701;
	Tue, 21 May 2013 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3eDOBPo16QrAA9WFidhgXVhXVc=; b=UEe8HC
	PPL3gnVqYjej6LRdfF96rw+j81GARd0SVxOKQ8Vs8eC6YgQTolMoVZDeRj3Yl4sL
	jztyc0oBI4Ac7ZGA2V532vsJhn5wWpk4B7YlTo/F4Ie+h+WLjFugQVERabghOLkU
	1DPoD97FtyE8HlNCy1N6Z2rbd/ZzzLxk0hkOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BoC6JTR+MmzGENlxS8gcq62O8ZrHvG1+
	rvNGVBexaYr1wf8hsclSk2v9rQY5wPsjB3BhfHD2uKaP7ZgaUExhzSZrkJtoamP8
	4rk9benMGakmjKZ0SGEIwPvUJRgpJSnjTo7kIRAO/0P5f7wEM3qwS2EqaHX9Fh56
	XToFZfdMzbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEF2C21700;
	Tue, 21 May 2013 20:33:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 590E4216FF;
	Tue, 21 May 2013 20:33:33 +0000 (UTC)
In-Reply-To: <CALkWK0kVAG4Gg3mgZv+0pXJocwDzZYS3gwVjxPy9cmBEkB2sFg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 22 May 2013 01:44:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4AC37FC-C255-11E2-B204-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225074>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> "@{u}".  What am I missing?

You draw the arrow the other way around, that is what made the text
confusing.
