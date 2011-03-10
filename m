From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 11:21:47 -0800
Message-ID: <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 20:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxlRA-00073x-57
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1CJTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 14:22:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1CJTWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 14:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E97F3466;
	Thu, 10 Mar 2011 14:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wvZmX1OPcs2XjcFtEi+9t35B2+o=; b=DUhVOD
	rbi78UVN1+wgEzzzCgerouG+HLaeQSPeyl+F1Gwytg/sFnIfW4zKRcHvUMctqk90
	2j1zoKALm2Sl8icBo8Jm5Lbq5wKqNc2VLb3W+RPp/6/l7W8SOJx6YIXkn00fJWXi
	pBRzjiAkDSpF2eF7IZe9x9ZhGt8hBwwoJdmkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2CuuudBmfdOk9JKy9nta4pFJRyaZGi5
	ELnv1lSYAxrPgF3fmeIQ2LKL0sFapSNVPTj1drBNSDXWUhWp+LfhEgoO6LfL9Q0A
	KCgWH1oFETmusjElL71xvtWO4E/dyeeIoYLscxtnXl6pmeMRPZbdsXsfuClXZ32T
	6KmG3jctK9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 848BC3463;
	Thu, 10 Mar 2011 14:23:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39478345E; Thu, 10 Mar 2011
 14:23:17 -0500 (EST)
In-Reply-To: <20110310184653.GA17832@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Mar 2011 13:46:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E00AD594-4B4B-11E0-9D53-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168844>

Jeff King <peff@peff.net> writes:

> One more wishlist item for this. I use "add -p" for almost all of my
> adds these days, because I like the final review check. So after a
> conflicted merge, I find myself doing "add -p" to stage my resolution.
> The current behavior is that it shows the --cc diff and exits. It would
> be cool to handle staging the resolution, which would involve converting
> the combined diff into something that can be applied.

I think the end-result would be a nice feature. I suspect that it would
not involve conversion from --cc, but more like using the difference
between the HEAD and the working tree, generated as if there is no
multi-stage index.
