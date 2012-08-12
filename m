From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: mark progress strings for translation
Date: Sat, 11 Aug 2012 21:33:16 -0700
Message-ID: <7v8vdkhgqb.fsf@alter.siamese.dyndns.org>
References: <1344684304-22425-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 06:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Prg-0001Z0-DB
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 06:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793Ab2HLEdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 00:33:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab2HLEdT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2012 00:33:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D081D900A;
	Sun, 12 Aug 2012 00:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=byFtTX+qWbZO
	MtlQIL7k176Qvvg=; b=bCGuQm79NcenyoQolEsz6KOAZ5mp33YU3LaGYGY4akdZ
	6G3SdMpIqPG27+oiqy5tzAWi5mWZAo3IyxLaH+ItWBYDYbqMz+5pvpQyr4S3UKQa
	XrSC9Q78raddV5KZO6fPM/44l6zSZHVuD2JZyaNujBgVJVSmJAOVWtIPFqkGyuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hw+WfN
	YUiSkx/yAIQw49LurNCMzVcJpPpekDELZZJfLNHcpNFcsaoIA6wdNkI1VJxZz6Ms
	pAKIMDfmwTGW+7MLeiSQ2xyelzZfj0dHjumPYt2bkE1sOrAiVmiueEaXbLUz8thV
	/4H2v3XBoHpEJZafR/r6kk+8ZjUMft4eIxqEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE5599009;
	Sun, 12 Aug 2012 00:33:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB179008; Sun, 12 Aug 2012
 00:33:18 -0400 (EDT)
In-Reply-To: <1344684304-22425-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 11 Aug
 2012 18:25:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6E46478-E436-11E1-A78E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203303>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I know it's late in the cycle so let's queue it for the next one
>  before I forget it.

I won't necessarily be queuing this.  Not forgetting is a
responsibility of individual developers.

But it is a good idea to show an early iteration for input from
others.

I personally do not think this makes much sense, as half the
progress message you see comes from the other end of the connection,
which does not know nor care what language you speak.
