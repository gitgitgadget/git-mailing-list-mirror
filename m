From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 08 May 2012 09:41:05 -0700
Message-ID: <7vwr4mwrq6.fsf@alter.siamese.dyndns.org>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
 <7v4nrqy6ur.fsf@alter.siamese.dyndns.org>
 <CABPQNSb-YPAa6qPtxeo1k-p-0REnk3soOTuPgABj9+s61o80VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net, schwab@linux-m68k.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 18:41:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnTf-0008OM-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab2EHQlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:41:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039Ab2EHQlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:41:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 414076860;
	Tue,  8 May 2012 12:41:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nM+dUIl2Yuo6xVcPB/hWEckoios=; b=GHgPyZ
	Eg/xzZiBfU8Z+J07gi0REIJUJ3aB1qjUkCmqpABTVgle0k7LDjgXaU8EJbfuK2GT
	7JEMaOjFwjUEXKA+n8R8ntfatGurbO/qDcbqrjT/aVbosjAwzFALV54IlT8fg4+3
	eQjN6qovyWAyR5cuhzCgVcIPSlDh3clE83GFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yOIEsQchslWBzCuafNxK4pHWsaX0Q/i1
	JPnauisX/2doBQR0c4oJpCopQaoCASNwCbTYGEzZDpuYnvzHk4DbT8/AjvQRDX6I
	W2QOzYT5rW9U9zwx/K+DTQQmvOZsY/kmajJOXSg1hVQ3K7WY/qS807exPoqHmFuI
	NBlf5vfHFJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37A15685F;
	Tue,  8 May 2012 12:41:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C456B685D; Tue,  8 May 2012
 12:41:06 -0400 (EDT)
In-Reply-To: <CABPQNSb-YPAa6qPtxeo1k-p-0REnk3soOTuPgABj9+s61o80VA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 18:35:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BBAE098-992C-11E1-8F1A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197388>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> (or "are people expected to know what CRT you are talking about?")?
>
> Feel free to change it to "the C runtime", or even "the vsnprintf
> implementation" if you feel like it :)

Ahh, "C RunTime" was what you meant.  OK, it somehow immediately did not
"click".
