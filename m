From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing --graph --all output with detached branches
Date: Thu, 19 May 2016 08:20:08 -0700
Message-ID: <xmqqvb2aoz13.fsf@gitster.mtv.corp.google.com>
References: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 17:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3PkK-0002Xc-DC
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 17:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbcESPUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 11:20:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753971AbcESPUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 11:20:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF5EB1CA8D;
	Thu, 19 May 2016 11:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bKmZRrkLgmQ+
	JsrC2zzlTB965xI=; b=iU44Rlw61G4CjiiPpjYcpmlkYvJtPYUdS2WRk4aEiYNe
	yB3uMWjv36e7LdaJPovtCDwxOGowftco7vlymlhipHV2J21J8rvOcmPaA+8A5pB2
	DlH3zAu+eh0e0Vq8K+IzrZypZdRsc1fdkMRL9yWZbJ2afb3+9IHY0mPT0MhMZ34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EKD+NL
	9Y6VHA9ofWWr0lRkPqOLWA/KlYUSyqAUJuTkqDqEotT3/C+0o6iyhM4Zi4OEKxSt
	Z5Idps+4A7/3t+h5E8jmCq8SQhD2nC91lsYajInjypfBi36xFmFLiBgwVGh9CYhs
	8+dVFzqX27rBFg0CsSB/PdE4dfPDyEeyMyS60=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C428B1CA8B;
	Thu, 19 May 2016 11:20:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C8881CA84;
	Thu, 19 May 2016 11:20:10 -0400 (EDT)
In-Reply-To: <CA+cck7FPzK-zccBVzphY_N41acOvqjwmDmgQH7ZE3SHG2k1rFw@mail.gmail.com>
	(=?utf-8?Q?=22Bj=C3=B8rnar?= Snoksrud"'s message of "Thu, 19 May 2016
 15:45:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D19D324-1DD5-11E6-8778-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295067>

Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com> writes:

> .. which indicates that `foo` is contained within `bar`. Maybe
>
> *   ff4265f  (HEAD -> master) Merge branch 'bar'
> |\
> | * 0bbc311  (bar) 5
> | * b1c9c49  4
> |
> | * ce053f9  (foo) 3
> |/
> * 8b62de9  2
> * cb7e7e2  1
>
> .. would be better?
>

Yes, it would be.
