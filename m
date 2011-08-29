From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: format is in $patch_format, not parse_patch
Date: Mon, 29 Aug 2011 09:12:14 -0700
Message-ID: <7vaaas6vtt.fsf@alter.siamese.dyndns.org>
References: <1314631326-11796-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4Rj-0001vm-F9
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab1H2QMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:12:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab1H2QMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:12:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAE949D9;
	Mon, 29 Aug 2011 12:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uaHw14cu6kfbQuRADJQD1LMLD7U=; b=AUO9w6
	iqlDowt54NktHX8SG/Y2s/yG8zIXlyNuqwMICdMJgFH81j+t4ekMZRZW1a4Ew+YF
	pCHNdkgcB4pdPBh2+zsI28Eqm6vy6plyOjhltB7+VFS/KlukjT0HLEBsqkiBCIwY
	/QV9vx+LSZzqIoZKv6lkEVx2ghCb5u3AFON4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XTPTA7j3P3h2Gn52PIDgmwscufUlb10c
	FXCMzk/BLl63AEP3Msexkn0pmcZapPvr1K1t1yIvrU/lHMFjLIN6uDnj7wfWlTiV
	gVpStqHYUyLD9Q59/4uENAU1dVuZQHbra7EcwRPxGvgY4gGdqmBDFqdITBn3GycC
	enrGdKkg5kM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7528949D8;
	Mon, 29 Aug 2011 12:12:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E942949D7; Mon, 29 Aug 2011
 12:12:15 -0400 (EDT)
In-Reply-To: <1314631326-11796-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon, 29 Aug 2011 17:22:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A98D6A5A-D259-11E0-849D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180315>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> The error message given when the patch format was not recognized was
> wrong, since the variable checked was $parse_patch rather than
> $patch_format. Fix by checking the non-emptyness of the correct
> variable.

Thanks for a fix to a problem that is from more than two years ago ;-)
