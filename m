From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Wed, 21 Sep 2011 21:00:51 -0700
Message-ID: <7vsjnpz0ng.fsf@alter.siamese.dyndns.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 06:01:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6aTC-0003vV-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 06:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab1IVEAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 00:00:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab1IVEAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 00:00:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAA26BD9;
	Thu, 22 Sep 2011 00:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DK7Fh46F2lI9EYgPz4BiFK6vfs8=; b=VUv+PU
	JHQwA+j94D1KrhKDq9x/1UtV4mvww6Sn67B5dePJeMusR1i/umHhA5A/0aIi9Q8Q
	FpK06cWCYW8CV/D8NMDZNE2kMRnZ5ce8p+sjR/BYUOjv1EfclquL+s9ATTnONW2p
	J+bJECXiwrSn4aVcKAmSPenyKAUlgj5u2CLd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WECgkKU/pLbGKg3Wk8LWfT78GvfI9kFt
	7eJbV70uJa+qLmUOBVCSMriad2mpZZ4hBbz8odMm3lD1ZVdFb/jOv9UK7fEF2Kyz
	CxlEufS/j2Q1YFMKlmFa1Tl+UV5yxoF3UkXKlrbEk00XxieO0/gj3MNUtyiMXBfY
	2rd0ki65tdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245276BD8;
	Thu, 22 Sep 2011 00:00:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADD8C6BD4; Thu, 22 Sep 2011
 00:00:52 -0400 (EDT)
In-Reply-To: <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com> (Michael
 Witten's message of "Thu, 22 Sep 2011 02:01:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77041452-E4CF-11E0-A440-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181882>

Michael Witten <mfwitten@gmail.com> writes:

>   That is,
>
>     git fetch origin frotz --tags
>
>   is equivalent to:
>
>     git fetch origin frotz 'refs/tags/*:refs/tags/*'

No matter what you do, please do not introduce a bad example that violates
the usual command line syntax convention to have subcommand (e.g. fetch),
options meant for the subcommand (e.g. --tags) and then other arguments.
