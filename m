From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Wed, 26 Sep 2012 23:39:17 -0700
Message-ID: <7vk3vgrmui.fsf@alter.siamese.dyndns.org>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
 <7v392k5w7u.fsf@alter.siamese.dyndns.org>
 <7vligc19d1.fsf@alter.siamese.dyndns.org> <506362A7.5090108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7kw-0004YZ-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab2I0GjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:39:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab2I0GjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BA370DF;
	Thu, 27 Sep 2012 02:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=sQgMhI
	u/w7Q0U/G7uObMVOS3RMbP3eoXHJHUaeBXGBDpDqV3A4aiD4cfCGpx/yVs6dbyRL
	noXEXS2FgtcYQnL6BKBFvQiUrR67coYLerJ2sWoaVewgO+lmAv/5dxJVTprzBzzd
	uEbNUC1KFF0bjMoiVTggMc99Sku2dhPpfR2I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXV+Y+MwgIaiCBPjDy26OYOxMgNo37c7
	695VwHYRllgdIqzrf7OsEZH9bAntw03T897o1zVxtQphlP2oRVo4akGZrsmjflp7
	xPm+W9l05sj9YsebypHgiTB+SwRlMu9Eo+++90hOda0dbA0pQdSNWjz9HXc1eCcE
	bsg+5hwsvDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C270B70DE;
	Thu, 27 Sep 2012 02:39:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA1870DD; Thu, 27 Sep 2012
 02:39:19 -0400 (EDT)
In-Reply-To: <506362A7.5090108@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 26 Sep 2012 22:16:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 109D14CA-086E-11E2-A775-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206464>

Thanks.
