From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 11:53:04 -0800
Message-ID: <7va9ua20nz.fsf@alter.siamese.dyndns.org>
References: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
 <20121121092750.GA8262@shrek.podlesie.net>
 <20121121193401.GC16280@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGMP-00051k-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab2KUTxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:53:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUTxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:53:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2684964A;
	Wed, 21 Nov 2012 14:53:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o4l58cTA5G2GYrkBxa+JX8A/KXc=; b=l84maq
	AsSao2tkShVKB2t0bEU5uErdoUhaxXSX/4CNUYeUSXVPeh3M5kch2LhkKTb6jVl/
	GRfRAHF3Xd9ct2Q6L8lpRrpBis/3fWMfmPDB51X5bk9pO0PIKeHxEEK3ADx2r6oR
	6PABJlsQ8nifV3gafH5UmKngX15V/P3MYvSig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MlTO4A3YmkaXOms9w4ak+yPx6+WRzYlp
	blVi4g+8XoCgEmf6iewTif8kIcxGtWW+TjgVEnGP8sl2ye5gG44JtSDYQWnqjDdA
	CuGbKzMEqSYYmVl4zNr2C+8rFBTdCqBF3HnBk8t9egu5ynTkjFebkWWKLpP5vJU0
	p0pPof7x7BI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFFE69649;
	Wed, 21 Nov 2012 14:53:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CD689648; Wed, 21 Nov 2012
 14:53:06 -0500 (EST)
In-Reply-To: <20121121193401.GC16280@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 21 Nov 2012 14:34:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 113B08D8-3415-11E2-96B1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210172>

Jeff King <peff@peff.net> writes:

> [1] Given the core-dumping behavior of SIGQUIT, I suspect it is not
>     nearly as widely used as SIGINT, but it sounds more like the
>     principle of least surprise to treat them the same.

Sounds sensible.  I wonder what happens when the editor is suspended
;-)
