From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] list-files: show paths relative to cwd
Date: Sun, 15 Mar 2015 14:16:38 -0700
Message-ID: <xmqqh9tmt0zt.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-4-git-send-email-pclouds@gmail.com>
	<xmqqsid929rb.fsf@gitster.dls.corp.google.com>
	<xmqqoanx29ei.fsf@gitster.dls.corp.google.com>
	<CACsJy8CjcCuDC8X9E5iko2b8xykBAwMY1JupYx1dzpnf5p5ghg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:16:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXFtt-0008Ej-So
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 22:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbCOVQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 17:16:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbbCOVQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 17:16:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 043043FC57;
	Sun, 15 Mar 2015 17:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xRtQCEDRxUmvi8ZePG8ziG1a8c=; b=JauW/8
	CufpWsw1KtEwpsX4UHYA/RXmQILgIo+PWPOc03LHaiAqnXgMSIpHOkKWQwMt7OJ8
	E2xx7r04wvv/xg7B1F7Xg2MrrXspdpql2+4+wrx+2CJarRcHCteaRq++3BMg42Lk
	XEUZDQBjyZJs35EeF32eeSwkvb0uiU5HsQym0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=grtiUIaQMxwzBXMkXUEnLXOhmht6v7pL
	Q7NEZfTxFo6Kgb1MoWvx8bEVTum530nMxe8XudyBQYhq9vdV6uY+UdFkfUgco2xi
	TiR4liT/rSYqcjzSpkcRsbbLIJksf4LTBkOcnAC0Es2jYX6xxSV+dE7goaQZqRC1
	q6WodjEScms=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBFD3FC56;
	Sun, 15 Mar 2015 17:16:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 773FE3FC55;
	Sun, 15 Mar 2015 17:16:39 -0400 (EDT)
In-Reply-To: <CACsJy8CjcCuDC8X9E5iko2b8xykBAwMY1JupYx1dzpnf5p5ghg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 14 Mar 2015 18:25:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 92004F00-CB58-11E4-822C-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265524>

Duy Nguyen <pclouds@gmail.com> writes:

> Exactly. We would need to sort and stuff later on, so true filenames
> are preserved in util->item. A cleaner way is perhaps carry all
> metadata in item->util and item->string remains true filename, then do
> all the formatting, coloring for all strings just before displaying.

I guess we are then in agreement with my review comment on [04/16].

Thanks.
