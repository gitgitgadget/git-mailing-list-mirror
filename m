From: Junio C Hamano <gitster@pobox.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Thu, 21 Oct 2010 21:23:35 -0700
Message-ID: <7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 06:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99Ah-0000Fz-9a
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab0JVEXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 00:23:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0JVEXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 00:23:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C21EE0A47;
	Fri, 22 Oct 2010 00:23:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcon4ti3Qd/+e7ujP3TCiQMMrZk=; b=NsV/Bb
	Y37rRgFbwtFanqpyGQ9lyjlD6F0JXZePlPIoEm2/Y/sMTFQLiqwuE9Ov9y1iDf/u
	Mkci9jYOnWc9P4BmBRx2hK49lRq+Cia0zErRCIDjMWoobeYhrsj2Y4Qk4L0sepdF
	qJcafuB/ENxa5hMq5B3G8i44/X70RaX2ktZx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtcFHhSwcqOVbmfo68B0KfFdZOTrwBq1
	fxAsWxdI6G34rLwhMvSUkxHs8DbeFC0PVJ8UovzKq/Y213rw842zMvv0nvhaSWS0
	+owbAcWevX67lLOMqYW1GhBtQqh1BVVpw9nu9/BOKYleyEepzPNHW3WDMCyQ9oev
	oEZ/xX1D8SI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4417E0A45;
	Fri, 22 Oct 2010 00:23:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 326A4E0A43; Fri, 22 Oct
 2010 00:23:37 -0400 (EDT)
In-Reply-To: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
 (Sitaram Chamarty's message of "Fri\, 22 Oct 2010 09\:18\:32 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2588EBEA-DD94-11DF-9B87-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159638>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Subject line says it all... While working with people trying to use
> gitolite's new support for the "smart HTTP" mode, I find sometimes
> they get side-tracked by this document.

Not everybody uses gitolite, and I do not think we have broken the dumb
HTTP support (however broken the original was ;-) to render the document
obsolete.

Perhaps we should do three and half things:

 - The said documentation should be fine as is if the reader is trying to
   set up a dumb HTTP push support; otherwise it should be updated.

 - It would be really nice if somebody wrote a similar document describing
   how to set up a smart HTTP server, and put it next to the said
   documentation.

 - When the above two is done, insert one line "This describes an older
   way; see <<insert the name of the other document here>> for insn to set
   up an experimental smart HTTP server" at the beginning of the original
   document.

and finally:

 - On the gitolite side, refer to the "new" document in git.git
   documentation set.
