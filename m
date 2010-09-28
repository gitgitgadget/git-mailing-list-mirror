From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add -F option that passes --no-reuse-delta to
 pack-objects
Date: Tue, 28 Sep 2010 02:49:34 -0700
Message-ID: <7vtylatcy9.fsf@alter.siamese.dyndns.org>
References: <20100927133104.25ce5285@jk.gs>
 <7vbp7j2krn.fsf@alter.siamese.dyndns.org> <20100928084451.78c13d17@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Sep 28 11:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0WpB-0002UM-0W
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 11:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742Ab0I1Jtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 05:49:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0I1Jtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 05:49:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B20D937F;
	Tue, 28 Sep 2010 05:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Eu0HqGXRt6cl
	9zM49M3aIVAtiX0=; b=hW+1FeTXkDoT/gCon2zrIOSpgYsHoxcqTB42zgsaSy+C
	EUY2X3Pc4ZsEwCeiGRIZ84VhXWtDN42TWzzPzBtpY8PuNHb6zusBCAx8NUf4gZsf
	mEZGzU/VoqnxsujIG+FhW9LMZGLYho3W9yxXTJkc8EY++TsuUN7hH1qQKaFw6D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hkwai2
	muXDk6GuO1+du7egnOw8ZUKRIgUVdsJz0Ds9o8jPUx24wA9y288c3RrcIy1vPSYT
	276fkT0jzA9ZacJJ63B8UaFxdTBeXbEJ/+JT6ZYt2ASYXOVWZcQ9BelC7QQe1i7Y
	pnHQk+jmgf8b7TkSLx1ZU1IiEGgPq9YaJLlUM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30DD3D937E;
	Tue, 28 Sep 2010 05:49:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5296BD937D; Tue, 28 Sep
 2010 05:49:36 -0400 (EDT)
In-Reply-To: <20100928084451.78c13d17@jk.gs> ("Jan =?utf-8?Q?Kr=C3=BCger?=
 =?utf-8?Q?=22's?= message of "Tue\, 28 Sep 2010 08\:44\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B70B88B4-CAE5-11DF-B838-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157401>

Jan Kr=C3=BCger <jk@jk.gs> writes:

>> Please make it so.
>
> Already done.

Yeah, I saw and queued them ;-)

Thanks.
