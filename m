From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 07 Apr 2010 16:02:43 -0700
Message-ID: <7vzl1eamss.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 01:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzeHK-0007L6-E3
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 01:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0DGXDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 19:03:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0DGXDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 19:03:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D39A8625;
	Wed,  7 Apr 2010 19:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dYY4Idh/2lTP
	ngfGmy5I8yKLxAk=; b=WRnpp5d7OVL7Hl5JpTEoEVNGU7OI/j+fDAWPSNUuFExk
	3H6NIfKh/EKQVK/g0aD+0sLEmw0MWFUtVoJRG0xPk7UEqWLKz0s/WMjE11H/4aaX
	r6WGWLkYtjbkrXrkFcdaI29Tmtbo1WBn6clwmy64mxlLbL+PP+hbPVUrwUTsppY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VXbVWF
	GleV1ROQ+NRp7lM8RdsaHMo4T7ppVzkKVzljqX37zx8TjEMqWjk4yZvImm4zSXKG
	E8o3eo8oJ1vjJ6+bUlJTqq/QYljrXxKgLPRQ5ZfxqutEShivQT56DtlVrV8HorpJ
	p937zQXmVcPDMUxXHR4lCzLoZ5SaUBC+RkfFU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C09FA861D;
	Wed,  7 Apr 2010 19:03:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60024A8614; Wed,  7 Apr
 2010 19:02:45 -0400 (EDT)
In-Reply-To: <20100407224942.GA20239@progeny.tock> (Jonathan Nieder's message
 of "Wed\, 7 Apr 2010 17\:49\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8084D80-4299-11DF-A62A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144296>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If you want to make sure the latest version of a patch is always
> available, that is a noble goal, too, but I think a frequently-
> rebased public branch for your patch series is a better way to achiev=
e
> that.
>
> Unrelated: in case you are interested, the git-resurrect.sh script
> from contrib can extract topic branches from pu, if you want to see
> Junio=E2=80=99s topic branch for your patch.

It might look unrelated, but I found it the most helpful information in
your message ;-) I really hate it when people base their patches on 'pu=
'.

At least it would be helpful for me if people based their follow-up
patches on top of their own topics.
