From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Wed, 21 Nov 2012 12:42:24 -0800
Message-ID: <7v624y1ydr.fsf@alter.siamese.dyndns.org>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <20121023223502.GA23194@sigill.intra.peff.net>
 <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
 <20121121192738.GA16280@sigill.intra.peff.net>
 <7vehjm20yu.fsf@alter.siamese.dyndns.org>
 <20121121200624.GF16280@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 21:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbH87-0006LA-5J
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 21:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803Ab2KUUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 15:42:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964773Ab2KUUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 15:42:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F209D9057;
	Wed, 21 Nov 2012 15:42:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5gaKQeTPXw+k/Ef2FyrXNbEoXA=; b=cKqtEU
	8rPcF3ZE99X1wAy/1uqKKL6F4P8hx1f9mxrmLyEdFT7zmMe/07rLXfgfkgT4Y/fi
	HinSr5InCNgXqA5hYsBsYBZ8iv1/vPTKnnNLMBpGZXz/7/N3smfAXd6pMIt7XYBN
	KdVuVODTlYaKMFA0yoG3O5YUKZ0PfDGRpzvyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w14Hn5rgQ3JlOxmWbZZWE8O38+qnqb1i
	lnb2kLFKh1v50XU9sVc96/RaQGxNPLGqHpJnOJT9pBO9BuB9RTGcycQq8B+lRWOD
	RwYaLOGUIdXglohHgYYC/dlJtY1P2kkZMwTeQ0loEvXVauKk/oUX5YJ7rvrVUUcE
	NehdAw9c6r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF899055;
	Wed, 21 Nov 2012 15:42:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58BC79054; Wed, 21 Nov 2012
 15:42:26 -0500 (EST)
In-Reply-To: <20121121200624.GF16280@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 21 Nov 2012 15:06:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5988A2C-341B-11E2-8379-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210177>

Jeff King <peff@peff.net> writes:

> So what do we want to do?

Nothing.  We'd just let it graduate along with other topics, and
deal with a case where somebody screams, which is unlikely to happen
;-).
