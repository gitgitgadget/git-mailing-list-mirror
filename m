From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] pre-push hook support
Date: Mon, 14 Jan 2013 09:42:34 -0800
Message-ID: <7vk3rfek51.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-1-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuo3l-0008RN-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab3ANRmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:42:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748Ab3ANRmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:42:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 091A0CB19;
	Mon, 14 Jan 2013 12:42:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/tlXBkti76/aI7Q510/7K+uM50=; b=bZWrOH
	xfeNrY+zzTbk3NCWM1p/1SS8tdxUqAyRB8HJgKyQl76eHZyabPmgWhhx4Ur5CbVD
	f6xqE5X4SsDRFb0QNUKcAZUG5j40O5ZyeEpJMcCMsWieu8b2WJhc7KnTyo/ERD9Y
	CbB293SyB5y2P1B3fI9xNO1R5kV3Iw3Ht0wsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=prPricIoj5rmPkrL9/nEQSVCaY5Fg+2Q
	JdZCjD0BIhC0t8/vOTeLb2eofSLyTXLVf50j4xtEjyRhrkZOqS/Gw5Ql/YO85++x
	l1Scg6wQBdbBBbSg3DBJPjYhmN1/bLeaMWooqaXFuZgV6EK2/3qaqpSL2GeHRIau
	gLLaV1qFl6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E99CB18;
	Mon, 14 Jan 2013 12:42:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F372CB15; Mon, 14 Jan 2013
 12:42:35 -0500 (EST)
In-Reply-To: <1358054224-7710-1-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Sun, 13 Jan 2013 00:17:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C805092A-5E71-11E2-8D9A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213506>

Aaron Schrab <aaron@schrab.com> writes:

> Main changes since the initial version:
>
>  * The first patch converts the existing hook callers to use the new
>    find_hook() function.
>  * Information about what is to be pushed is now sent over a pipe rather
>    than passed as command-line parameters.
>
> Aaron Schrab (3):
>   hooks: Add function to check if a hook exists
>   push: Add support for pre-push hooks
>   Add sample pre-push hook script

Getting much nicer.  Thanks.
