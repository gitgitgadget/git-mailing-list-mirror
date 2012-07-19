From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] build system: support automatic reconfiguration for
 autotools user
Date: Wed, 18 Jul 2012 17:36:56 -0700
Message-ID: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srejp-0004dY-SW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 02:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab2GSAhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 20:37:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab2GSAg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 20:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34BBF8815;
	Wed, 18 Jul 2012 20:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkpZcNKb4WqbK3sGdsPXEzbXj1E=; b=vPjN5N
	r4Xvps2nDYUodrReJh3evA9JPXooZljnvNA3MUiSaehEf0CDV64GbA8YXtxnQEVx
	nB03qb66b/9Yecd3Ld6dt7QTsViU+osvACUfNrcd6iFEOgWR7+bLPtDThzSILCcN
	Z7crVFGySvik/1JiwaJxuWDfjfn5UrRdpYQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P2jsmdioLmfoF4/KV/NGV/xs8AkxDAfW
	EfKvCGMu+SnvKsK+2wazIL0iTVTHlQolndHknIJTvOw4GDeAwAUieetnZuQvEG3w
	jFpvjCeY5kTxO3tniSSzmzpZfVmDtoqlS92Zn9mY/PkaotYGM0abRP8YtYcNKNIr
	l6OTaZD5sdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22AB88814;
	Wed, 18 Jul 2012 20:36:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96D168812; Wed, 18 Jul 2012
 20:36:58 -0400 (EDT)
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com> (Stefano
 Lattarini's message of "Thu, 19 Jul 2012 00:34:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D943956E-D139-11E1-99D1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201710>

Except for miniscule nits in the the bottom two, I didn't find
anything objectionable---nicely done.
