From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 11:28:52 -0800
Message-ID: <7v1updtp57.fsf@alter.siamese.dyndns.org>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
 <4F4DD5C1.60604@in.waw.pl> <7vbooiuj6z.fsf@alter.siamese.dyndns.org>
 <4F4E2D32.9030209@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2pCt-0002aH-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab2B2T24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 14:28:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab2B2T24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 14:28:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306F170DD;
	Wed, 29 Feb 2012 14:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=v8bYgCcktNQFlKhJNT/Q2YQW1
	4o=; b=o2EUbYy10U6AsNVWxTSUsNgt0UGde+XxQX+L6zmodEsjRAWA0qu5iqHwk
	CgOX4LPIHIaNSB3ehh6iDJT6c5y1x8JMjHBOt0LZOeKZ2xky1zo66EU1p6U4JI+j
	u3j9xQueQNh3LiohA3Ov/8o6UvFnUQjuGraZBogSPOQ+kdtbSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=w6KHmIthe70owvKxux6
	ereS++9hithActGhbED+pDp3NHLwSLAEAKdcjuZoXkfOXS9jYMzV84ZBR1L0O9cU
	qzetsQj65qexaziduSrPAYn1rJ3+T0TVGEO5gvF+Xf0hHbzd2NFNQ5xvGN7rhyJv
	vGXpZva5Y1IDNnsl6ShrzvFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2740E70DC;
	Wed, 29 Feb 2012 14:28:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A1D270DB; Wed, 29 Feb 2012
 14:28:54 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E1EAD6C-630B-11E1-95B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191847>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> t4052 tests show, log, merge, diff and format-patch with basically th=
e
> same commands. Separating the tests into different files would requir=
e
> duplicating a lot of setup code. OTOH, t4014 is only about
> format-patch, so the other ones don't fit. I thought it would be
> better to create a new file.

OK, then perhaps we want to move the versions of duplicated one them fr=
om
4014 to 4052?

Thanks.
