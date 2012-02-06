From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Sun, 05 Feb 2012 23:10:58 -0800
Message-ID: <7v4nv4a131.fsf@alter.siamese.dyndns.org>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Feb 06 08:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuIjK-0007LG-2R
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab2BFHLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 02:11:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab2BFHLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 02:11:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D05442FB;
	Mon,  6 Feb 2012 02:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0tka29aHpUhj
	cqIzDG0hI7HST2w=; b=CKxclXWG1Ln8FkXJMNKH819NkDcA3+i7H8LAEDmrzlAm
	XR5W73lF0Rmrs1yi62xSdUJa8rC+Zm3V8RgIL2Z7Tcfx3P1LJE603Nw1ENEu8rFq
	TLtomaF2E4doGyYKhWcC7apyWhISUJ4iNystMp+5u8K4FouSdKU6J9dJ2xNM3/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yNtOHz
	/BUPquaZPDBvgwDEPmBJQqskVNUsyuROkwYw52P+xyO/6ACTGtwFTZgpxqHWcRbj
	eOvj8w1QhpZzJzqsLhGGi4+3UtvHm/w8B9xirD6pD5CjbPtQfblMjbUeqJKi1/Cd
	F9jB533Vpm8nmpBxm+gLVx5Uk8nLezUjP6O6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9502042FA;
	Mon,  6 Feb 2012 02:11:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EEE542F9; Mon,  6 Feb 2012
 02:10:59 -0500 (EST)
In-Reply-To: <1328507319-24687-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 12:48:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8EB3DC2-5091-11E1-BA1F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190034>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> read-cache.c learned to produce version 2 or 3 depending on whether
> extended cache entries exist in 06aaaa0 (Extend index to save more fl=
ags
> - 2008-10-01), first released in 1.6.1. The purpose is to keep
> compatibility with older git. It's been more than three years since
> then and git has reached 1.7.9. Drop support for older git.

Cc'ing this, as I suspect this would surely raise eyebrows of some peop=
le
who wanted to get rid of the version 3 format.
