From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 11:10:48 -0700
Message-ID: <7vfvxm6biv.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 20:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud2dj-0007w0-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab3EPSKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:10:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab3EPSKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:10:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFA51F8D0;
	Thu, 16 May 2013 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4TftDLbwlnoOt2f6c8NNAs7fMxo=; b=M3T6Ge
	zvatcNY4nxu8q+n3ebjH4a1Sh0ITOjAOR3mqcp3P7wQYjlvB8WWzTx9CW6vYk8EI
	5Vk8Ur94ioHmSzQLdkwCIvTcEVx+wFpzf9VHrY3gFiq2NHC65DtDncq7iCKxhl2w
	boqeOsHs9AW5/8RLw0mQX3lijL1Hq+BavYdXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ih3B57rQOadChinfk+p6wHK+4vVRauLI
	e8jZMc7gO036bhgBk4vb+TMQgpd1ONAxmIKCJbsrvOj4S6uSvJ+5R5tB+BwffKbp
	rneBCJ9JoaAUWBH3aEUyAnQctd8YC2sAh5ucqf6HnUmqiYNT9S3+ycqyttOG+8jt
	21fuVA0XkyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFBF1F8CF;
	Thu, 16 May 2013 18:10:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B25AD1F8CE;
	Thu, 16 May 2013 18:10:49 +0000 (UTC)
In-Reply-To: <CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 12:02:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0490F2A-BE53-11E2-B695-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224606>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> You find it sensible, I don't. And when people disagree, that's what
> the guideline is for. 

If you really need it to be spelled out, I would say it would be
something like this:

    (defun linux-style ()
      "C mode with adjusted defaults for use with the Linux kernel."
      (interactive)
      (c-set-style "K&R")
      (setq tab-width 8)
      (setq indent-tabs-mode t)
      (setq c-basic-offset 8))

    (add-hook 'c-mode-hook 'linux-style)
