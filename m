From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 00/11] read_directory() rewrite to support struct
 pathspec
Date: Mon, 24 Oct 2011 10:10:11 -0700
Message-ID: <7vty6y2u4s.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 19:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIO2X-0005kt-PR
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 19:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab1JXRKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 13:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab1JXRKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 13:10:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9324EFD;
	Mon, 24 Oct 2011 13:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0M2xaPFCB6CZ
	VgiUBEIpu/1fXag=; b=tkS79Uq5SmvPaLCzzS+blehkSeJNIQl/LWH5IPR0+Vgq
	jFIykp97gDhH3wxBiTEIEOQLSi9XBHiHJvEfehu3bOuiLb21NEPWYTVs/ARiebUX
	ZcTLCbW7pjWBcWYz80XWYVSHa9zgbauEK+Z+/XqJK7rIsv6vd7r6H5YFxPL7d2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VlciNg
	4S9Nw3WusTgfvQn94m+H3Yk8nEVf4HpOI3QtbII74lJRcGk0k7FIdTEtY8EEuqR9
	z1Bjko66qHIYzsFNOTzeLjB0ig+WC3wv1LUfv3WTWJwLxrCn2FUQfOPIkvU50NpE
	6OhTgTmw4dEMuVhgHO5ufqCLEi90bVmJGjjvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 356634EFB;
	Mon, 24 Oct 2011 13:10:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDAB64EFA; Mon, 24 Oct 2011
 13:10:12 -0400 (EDT)
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:05 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 090861A8-FE63-11E0-9994-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184182>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is the first time "make test" fully passes (*) for me, so it's
> probably good enough for human eyes.

Nice way to describe the done-ness of the series. Looking forward to re=
ad
it through ;-)

Thanks.
