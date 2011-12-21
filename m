From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: don't say <branch> when we mean <remote>
Date: Wed, 21 Dec 2011 11:25:13 -0800
Message-ID: <7vwr9pg21y.fsf@alter.siamese.dyndns.org>
References: <1324491249-5357-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:25:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRn2-0003YX-JN
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab1LUTZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 14:25:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab1LUTZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 14:25:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8AB7625A;
	Wed, 21 Dec 2011 14:25:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oZo0P5OtUXXh
	j5HHDh3F1kxDctI=; b=UTWWyhu0JvKxkyMvTK7hTXQ5Nth75gCn8OtTtSvYdEP3
	CLtfUHXMNPozMl4g0RTdPpBUmznsFzqigFWKrwrh39ocnkYPKFT9JAMB5MVss6qJ
	M3t36egVOPSS7eW7HN5Y4GGpeGF4VQK78BETMquNWVDYysdqr3rt5cZGZMxgX6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XBSWF/
	woobnraqXwfjVdbqpy0U+tzCyyM0X+E4d7x/a2lusOO636VXFXYZgMnubDD7FpFT
	gndQDGtLJ6epm1f5ozad5CShT23IklRjL+9Xs/du46UkbtiUmHxT6miK4Mb7Ag0o
	c6LjSkDJ4rN2o+/w7ZqoNnLW51godYMyr6GJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98CA96259;
	Wed, 21 Dec 2011 14:25:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 156E96257; Wed, 21 Dec 2011
 14:25:14 -0500 (EST)
In-Reply-To: <1324491249-5357-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 21 Dec 2011 18:14:09
 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82587164-2C09-11E1-BA2E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187585>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Looking through blame, the second line survived a typo fix and was
> introduced in 2008 when clone was made a builtin. The script used to
> say <name>. So it's clearly nothing urgent, but it bugged me, so I'm
> sending a patch.

Thanks.

How I hated these "rewrite in C" now comes back piece by piece, trickli=
ng
in. That's the price of progress, I guess.
