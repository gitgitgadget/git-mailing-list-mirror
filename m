From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] nd/index-pack-no-recurse
Date: Mon, 09 Jan 2012 11:30:22 -0800
Message-ID: <7vpqeseks1.fsf@alter.siamese.dyndns.org>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 20:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkKvP-0008NC-6K
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 20:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab2AITaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 14:30:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942Ab2AITaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 14:30:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F4737E8D;
	Mon,  9 Jan 2012 14:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BeBE1KgyBlVP
	SPsp6ZnsP+nc8fc=; b=JGVLyLs3o1wO4MblEKjoYQR4jKcByXFTW22sy+JnTNyi
	TpD21pYJeMBnjIt4lohnCb+reOXi3trxUtbcFo9LPf7oDAj4JFtV4pkZVF0Gp9kI
	u60mzgkqfRahE+R2znjs/aBCABhDQ636LNqyupHEEXB5XyHeZUCWwNcGRKYaEME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CxFpqd
	+bwvhhISQtDVJ2sQx+nnutC3tEEgQIhSUO5D8kNtH6nKtI6Aj1p3KF/JfhUTjWe0
	kdj/xvg8GV/GTdPB9Xa1UH/5lrYQp2Y8XvoL0Rj42WqK77l7kHNIEtdguTa0E/S3
	Z/1JiwFrL037/AjFUVWKAF6DfEeLTIt211I0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA947E8C;
	Mon,  9 Jan 2012 14:30:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1391D7E8A; Mon,  9 Jan 2012
 14:30:23 -0500 (EST)
In-Reply-To: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Jan
 2012 10:59:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 605E4E14-3AF8-11E1-846B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188184>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Resend to incorporate the fixup commit from pu, no other changes.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>   Eliminate recursion in setting/clearing marks in commit list
>   index-pack: eliminate recursion in find_unresolved_deltas
>   index-pack: eliminate unlimited recursion in get_delta_base()
>
>  builtin/index-pack.c |  141 ++++++++++++++++++++++++++++++++--------=
----------
>  commit.c             |   13 ++++-
>  revision.c           |   45 ++++++++++------
>  3 files changed, 131 insertions(+), 68 deletions(-)

Thanks.
