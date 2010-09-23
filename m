From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] commit: --squash option for use with rebase
 --autosquash
Date: Thu, 23 Sep 2010 13:39:31 -0700
Message-ID: <7vocboqjng.fsf@alter.siamese.dyndns.org>
References: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
 <1285262076-20134-4-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:39:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oysa2-0002OQ-P5
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab0IWUjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:39:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab0IWUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:39:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D8B3D8C28;
	Thu, 23 Sep 2010 16:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KZYjq/eKW0UAlsKkefMt+VHWEBo=; b=wX9Tw8
	KTEg3bEcH+SEBH4kFm11bgTgVsGebZ1KBFuZSq47zqlS/bb9LOduq1YXkR9FdOFN
	DtU1JXwGP5o5/Y7neWGsVqn4Ju3Z6eoGQMFBPM3KllqEPTWnBj6OHOX4QZtzEcLs
	29IT6MvwenwGkE6h7ibARsUrkOXr3dlqTd7X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoTjBM383KRwC+FjsX7NFR6kYNgbMAEW
	yoTR/3u1RFMpU5CKJ4fz49nrTWR35cGPcKKVRutDEbHLaaf1CIdwBnEZN0jOc/Aq
	dkMnVjnlI2ZGR9yNgNzMXqrz//ocwQWgviro4IkJQLEIuP717BODbQ0xchJPtRgI
	bTAVZj6MabQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3ACD8C27;
	Thu, 23 Sep 2010 16:39:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57564D8C26; Thu, 23 Sep
 2010 16:39:33 -0400 (EDT)
In-Reply-To: <1285262076-20134-4-git-send-email-patnotz@gmail.com> (Pat
 Notz's message of "Thu\, 23 Sep 2010 11\:14\:35 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADC9A844-C752-11DF-8A96-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156906>

"Pat Notz" <patnotz@gmail.com> writes:

> +		if(use_message && strcmp(use_message, squash_message) == 0)

	"if (use_message && !strcmp(..., ...))"

Otherwise this patch looks sane to me.
