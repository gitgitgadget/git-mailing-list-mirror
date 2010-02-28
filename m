From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support merge strategy options in rebase
Date: Sun, 28 Feb 2010 13:17:45 -0800
Message-ID: <7vaautvz46.fsf@alter.siamese.dyndns.org>
References: <1267332207-22675-1-git-send-email-mike@fluffypenguin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Lundy <mike@fluffypenguin.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 22:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlqWU-00029c-9J
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 22:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032077Ab0B1VRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 16:17:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032065Ab0B1VRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 16:17:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC7F9DBE8;
	Sun, 28 Feb 2010 16:17:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=N9uUhNO/EpdUkkdf5/x1aIGoQcY=; b=pyxJPc5xPAXKV7qf8jJP6aZ
	z1KmNXjhxzQK2/EJ6l/TSbLpaRHSFOke1DJkdFYT1A6fll0xInhHdRh2SI49pGA3
	5GhtRjDwFWCPyD/p6CFlWmaAqRi6b0IH9VzJO7JexssWDCWTQbtAQ8wDrSwl5APj
	sv7fk5j8dAe+XVRhNFPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=T5Oip3THITuebjcBhjIrMM/vzP0xv3WYKeQa38J9502xKi0Yw
	8Bm6pehDRH1uIIw/uiJT117SzzDkYVwWQHBJ/lACuGHmDj2O568VHvINRkhaXE1V
	5xqv+k0uK0Y+72SU3XvE9iQvIGJvft+f0vfMoDK3PAYUB2K/G0IJUM1ejk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A75629DBE7;
	Sun, 28 Feb 2010 16:17:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF0C9DBE6; Sun, 28 Feb
 2010 16:17:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B94D64A4-24AE-11DF-BFA9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141273>

Mike Lundy <mike@fluffypenguin.org> writes:

> The manpage says that git-rebase supports merge strategies, but the rebase
> command doesn't know about -X, and gives the usage when presented with it.
>
> Signed-off-by: Mike Lundy <mike@fluffypenguin.org>
> ---
>
>  My test modification only makes sure that the argument is accepted; it assumes
>  merge strategies are already tested and they won't actually be needed, because
>  there's no conflict.

How well does this work when strategy options need to contain a
whitespace?
