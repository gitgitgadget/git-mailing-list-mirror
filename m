From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stage: remove unused, unreferenced builtin-alias
Date: Mon, 24 Jun 2013 11:27:51 -0700
Message-ID: <7vvc538iu0.fsf@alter.siamese.dyndns.org>
References: <1372097546-27721-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBUc-0002pM-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab3FXS1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:27:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3FXS1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:27:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20422BB4C;
	Mon, 24 Jun 2013 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kEvfxYCeuotn7UgMn92sD1/K5xU=; b=Rzc8b8
	FQ5C+YdvimKOkoghedHa9ylvldq5ZdipdrmlDAjqBrtyzREKodFANryDrN86TBKg
	eFdUVq93YrV4bRUAnEak8GxNpg8sS9BZren4kXVBr7rzmLJxDjI8kGZHvUeQmbCZ
	VCv6DfpqtgerLmr7pipGnsejV/vWxtzljfeKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MVpA+299z9guNOoiRFX+ow79NVP62pQ8
	hj9cWsll3Pk3YsSnNxQE2dXoudXAtcAn7Is4E9cZoUWEMoH+KRvSM6HA5/AkprkH
	u6t6J/DwtEKPkWSmwn7Ie5361+8zqYbW+USkU3bCkJNMXso0UuYSGDnu+AFDX+XI
	KuwjAMr3Y84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75232BB4B;
	Mon, 24 Jun 2013 18:27:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28E042BB49;
	Mon, 24 Jun 2013 18:27:53 +0000 (UTC)
In-Reply-To: <1372097546-27721-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 24 Jun 2013 23:42:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8690E44-DCFB-11E2-A412-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228893>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 11920d2 (Add a built-in alias for 'stage' to the 'add' command,
> 2008-12-01) added a the 'git stage' command which simply calls
> cmd_add().  Since then, no references to it have been made anywhere on
> the internet; there is no evidence that anyone even knows about its
> existence.  It is a long-lost forgotten command that only serves the
> purpose of preventing the user from having a custom alias.stage to do
> something useful.  Remove it.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  I just found out about its existence.

Hmm, this has not discussed on the list at all, let alone achieving
consensus that it is a good change.

At least, please direct the patch Cc'ed to the original author of
what you are removing, not to me.

Thanks.
