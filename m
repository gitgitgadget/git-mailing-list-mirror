From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Tue, 14 Dec 2010 11:15:52 -0800
Message-ID: <7v39q0upw7.fsf@alter.siamese.dyndns.org>
References: <4D07B724.8000901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, davvid@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaM6-0003oc-Fm
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759652Ab0LNTQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:16:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab0LNTQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:16:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 214012CFC;
	Tue, 14 Dec 2010 14:16:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rh6jatASmTD9bD98GXmi8IwBjY=; b=s9YOGj
	n+5xtS5fInL2hWOiJyA0zy1Vn/u2uiE8hyiTcFLpaZs72TzIPSYF98Mvxc4gr5Fr
	mWsp3uPpWc0tOaoMhCtGnYY9krpnTpH8NB1Hn2r5iSzTjrYRLUa+2M0FVzMjCjqU
	/6XhK6Y7jQjC7+G3cexA/jaTMlRy3m90B/tIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qT0UyB7zwdKsQMrmxSHUoD9oA1+6fSfz
	87BgL+8suwAv6bI6+y8Qo1l7J1wFqGK/e3yQV5pRZdckkAwifO0GpVDz+05VB23q
	7xWiRLQRP2c4JWYiiXE6WZfNnFWhw+WUHgOoGmbkEwtdCFA2mGf3YCbXT0PA82Ek
	AYKb+LiyDOk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEC332CF8;
	Tue, 14 Dec 2010 14:16:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C51E72CF7; Tue, 14 Dec 2010
 14:16:19 -0500 (EST)
In-Reply-To: <4D07B724.8000901@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 14 Dec 2010 18\:27\:48 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A40B02C2-07B6-11E0-ABAE-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163678>

This is not just "test failure" but can cause a failure in the real life
for people who want "the last flag wins" to work, no?

I'll retitle the patch and queue it separately from other test fixes.

Thanks.
