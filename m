From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not decode url protocol.
Date: Tue, 29 Jun 2010 09:50:36 -0700
Message-ID: <7vsk45ailf.fsf@alter.siamese.dyndns.org>
References: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
 <4C229EA0.6010904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTe1P-00057I-Fs
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab0F2Qus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 12:50:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab0F2Qus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 12:50:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E615C0255;
	Tue, 29 Jun 2010 12:50:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RDLx8K+JMx7AE7R589QeZugAx
	7c=; b=X1tuNdplUO9FIIANpbG+zcIz7JLW4byJ8omED3cjAtJjK/j7Fxqg6+LiM
	mKYhJV0jdOjsrWJHaSiC58zUU4xrmmFJ5jb2xHaEpp7dqeQhG4MvpL2ec+oFJjQO
	HmejKrSe4OQsyujic7Zb1gRUEqHETnmlBq44GM/Xaxc0bMAF7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=i7sTKZko1T3hwgjUWV0
	aoAU7WOTnLNn9jN/VAYAS7sm2FEIBHdSm+avQAsh7tab4bYK8Kk/kqKaX+Yk+8GX
	t/dEtqZ0euzB9COQe7dLSCPyghj038YTzTkf2kl9mxK/dow/DKznKlutEBAEK+C6
	JA8lTuBHiaa+MX6RbeBNMf0M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED2EBC0250;
	Tue, 29 Jun 2010 12:50:41 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 405C3C024D; Tue, 29 Jun
 2010 12:50:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 740C6C4C-839E-11DF-A27D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149918>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The protocol in an URL is followed by a colon and technically a slash
> doesn't have to be part of it at all.  While in practise all URL sche=
mes
> used by git have two slashes following the colon, it's just as easy t=
o
> be more correct and search for ':' instead of '/' here.

Very true.  Thanks.
