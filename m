From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Supply the right commit hash to post-checkout
 when -b is used
Date: Wed, 14 Oct 2009 02:13:50 -0700
Message-ID: <7vvdiie3sh.fsf@alter.siamese.dyndns.org>
References: <20091013221109.GA30972@atjola.homenet>
 <20091014000619.GA20496@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ranguvar@archlinux.us
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My00p-000330-R4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbZJNJOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 05:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757941AbZJNJOo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:14:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbZJNJOn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 05:14:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7722777169;
	Wed, 14 Oct 2009 05:14:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=pW8eF8IbFmMb0B4srzwcx3irY
	HI=; b=mGf0XYPLjCeNFmGIJr5pOHE+mnAg7kmvIWKGVh9131+VwL2BEQBcBuqsr
	a+Zjg+8OGwHpmlrs+tjeUui4krYaBfLu01lNLKGWmYEV9UsX5HVHtV0fqHlVVDMO
	f5pBWhs/glao0ChE/11XdDVHalaAVMAy83080hGRkYvIs4vgyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wME4MOX7lQRTz3JQbOh
	nDeB6YTRPxzt9X+o7zavFF6P73fjYEZjEmmszifGEvonabnuaKPlFlvTevndgWg4
	/bdg/MP/eMNWdus7P4mTAQT/jhvE+QoJqJGXqvZ/SjwBtvLtj8YPrrB+LFUWNlhZ
	vZEVZmW2E+b0y2vxZDevS8zA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 421707715E;
	Wed, 14 Oct 2009 05:13:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A208377155; Wed, 14 Oct 2009
 05:13:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E795DA9A-B8A1-11DE-A537-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130273>

Jeff King <peff@peff.net> writes:

>> Reported-by: Devin Cofer <ranguvar@archlinux.us>
>> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
>
> Acked-by: Jeff King <peff@peff.net>
>
> Thanks.

Thanks; will queue on 'maint' for 1.6.5.1.
