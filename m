From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Fri, 03 Oct 2014 15:20:22 -0700
Message-ID: <xmqqk34gkd7d.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaBDF-0006qn-5g
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094AbaJCWU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:20:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61163 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755821AbaJCWUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:20:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9EFA3F7F1;
	Fri,  3 Oct 2014 18:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VB6QR8Ssydb+YZHs7+dB6F0dt20=; b=eRZxWf
	v28GfkDShacDMDAnINxLjDhhJFSK/SgbxThO6m9n8fnIFeKBbJWCNamSDQB0/7Vn
	pw1Z6i+Q40eAFpeYK5YJhhv4+BT+aqeLn4f6VffghZXGV3fyoXjsL2fl8mkmtcrZ
	QZKTtFVCHJwV/MP5AGXth68//DKmk0gnUOmAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p/k1TF95wSYYHJrjziw28DvY7huAfDGJ
	GH+QfwyjjiqHJe2NFqyfktr/Y/ktFthRFZ8eOnm/0H5XRgQX1ha3UrXX+x6agl5F
	KuzG8fsug84dYAAAxkG01NcPrdYpsvMWvha+A0RDNPryJ3/Q6Qbn/wVsr96w12WT
	og4CMhM8sjg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 394513F7F0;
	Fri,  3 Oct 2014 18:20:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B9003F7E6;
	Fri,  3 Oct 2014 18:20:23 -0400 (EDT)
In-Reply-To: <20141003202045.GA15205@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:20:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77D77EC4-4B4B-11E4-BCC9-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257876>

Jeff King <peff@peff.net> writes:

> ... The objects are removed by prune, which doesn't realize
> that they are part of an ongoing operation. Prune uses the filesystem
> mtime to determine this, but we are not very thorough in making sure
> that is kept up to date.

The whole series looked quite sensible.  Thanks.
