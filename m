From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/25] setup.c: convert check_repository_format_gently to use strbuf
Date: Wed, 26 Feb 2014 16:18:04 -0800
Message-ID: <xmqqmwhd1k8z.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:18:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIog3-0003dW-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbaB0ASL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 19:18:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881AbaB0ASK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 19:18:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3AF6701E8;
	Wed, 26 Feb 2014 19:18:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QLrsfjdQ/if2
	DYG26/e9MhR1LOM=; b=GRJjra4TWBWF3VqHRESynPAT9B+MQaQFPkC7Ec1tRjO6
	0s6D+nPLQuyuG3OoT08FwYIVlZ8872KdUeNDjtFdmdyTCITsDBvmGX7LGb6N5/6Q
	Mah2Bawe4ub2KlCNiBOBWD/6VbZDe1ssCuXva7FPruO4MwUDXBppZq9HG1ne+XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=chpdIj
	MwTU8lqrQVUIPbGAtv6ef+ReVbqjvbjcRi+0Hpdv9L4A34GqwxKCECYrgLrTNBGn
	y2LuEYMHt1GUN9xzlnFeFjs2yLjposk5n+cmWrjGTgTFhtTU2bBOXRNeK3FTXGmG
	zRll4KZTyoRN4g4b4ctl7u1tcodUt0mVr+hMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF40701E7;
	Wed, 26 Feb 2014 19:18:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD67F701E4;
	Wed, 26 Feb 2014 19:18:08 -0500 (EST)
In-Reply-To: <1392730814-19656-17-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2B89C4E-9F44-11E3-9852-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242778>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Nice.
