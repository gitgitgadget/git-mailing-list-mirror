From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix a typo in git-apply.txt
Date: Thu, 03 Mar 2011 15:28:45 -0800
Message-ID: <7vlj0v942a.fsf@alter.siamese.dyndns.org>
References: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 00:29:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvHx9-0004P2-Ng
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 00:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891Ab1CCX24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 18:28:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758739Ab1CCX2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 18:28:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA8AB4986;
	Thu,  3 Mar 2011 18:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fDlD2/X6A1Ux
	KJubAIGFnbY4kp0=; b=ZFxz8/1FS+BRLZIoUJOsGhrC3xCs9pTv1hZQowp1b5/9
	0MU+lU8bH0jZ01xf9ZRn1nBm+y7jVb6JnyyYPeB8KBWkVV+2eS+4S1rrxn23/Nd4
	VYyOJnhIOKU3ZmzsfwKJDVWGfN1oAfnCccaJ5afX0ldArg5b0OVglWPDilWKp0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rCB9fG
	rRoYeJtGpnLvyfrYMhKxeSbl63BonJzcfuRYD7xQcFmG0KvIzQHuxsogFhwqRz+8
	ZzOVDthLyMPBs/EplIHEaATdtyb5f7fUMdC2rJn/ooOBz3m+G04u9nC9zgqRhuII
	F1V58FPiRLPznm3HoMZ2hsOkp6tp/ZEiYRJZ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C95084985;
	Thu,  3 Mar 2011 18:30:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E614A4984; Thu,  3 Mar 2011
 18:30:07 -0500 (EST)
In-Reply-To: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Thu\,  3 Mar 2011
 10\:28\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9F8A6E-45EE-11E0-BEC2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168414>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> git-apply accepts the --cached option, not --cache.
>
> Signed-off-by: Micha=3DC5=3D82 Kiedrowicz <michal.kiedrowicz@gmail.co=
m>
> ---
>  Documentation/git-apply.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git Documentation/git-apply.txt Documentation/git-apply.txt
> index 881652f..2dcfc09 100644
> --- Documentation/git-apply.txt
> +++ Documentation/git-apply.txt

What kind of crap is this?

We really should make it much harder for people to use funky src/dst
prefix when generating patches.
