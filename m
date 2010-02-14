From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix signal handler
Date: Sun, 14 Feb 2010 02:19:33 -0800
Message-ID: <7vsk94qfuy.fsf@alter.siamese.dyndns.org>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net>
 <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 11:19:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgbZw-00067n-PM
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 11:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758374Ab0BNKTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 05:19:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0BNKTr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 05:19:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A3A99A88;
	Sun, 14 Feb 2010 05:19:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6gGe9vEFl6W7abAj82WDJ3TEm4=; b=kCNAE4
	PdwG0VbAK1PKFpDlSATF+H7lmTLNzfX0Y0QgrM6VUS/Ozf9T5JlQooE1y+XsOUZf
	50tyZIkvGBxJFyBSGHJUISuC+iqyn/AEiCSu/kGImldnhFIuaor/enfIJICBI2Uo
	H0gEzghK8tB0SM8jiMqOkTtKhwsyK0N/KErnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZLVqyIy0JytT2ryPUn8TQH7XJqh602gJ
	GDUoif2DtFBo36GX8GOWcOPgHqhvXFo5QvYMp2QKGv9845SdNi8rw7vG/XO4Nq8c
	1ZfzHauYvGbDa6oXMgyGifO7JNXvJd37WkeWHYYwIcDW9ev60CM4eJ8WB0xYwNaw
	K5YmZMSpk2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C30A99A87;
	Sun, 14 Feb 2010 05:19:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C86899A86; Sun, 14 Feb
 2010 05:19:35 -0500 (EST)
In-Reply-To: <20100214064745.GC20630@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 14 Feb 2010 01\:47\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 758AF202-1952-11DF-BCB6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139893>

Jeff King <peff@peff.net> writes:

> You would have a better chance if you followed the directions in
> SubmittingPatches, including sending it to the maintainer, including
> your patch inline, and wrapping your commit message.

Please do not encourage a patch sent to the maintainer while it is still
under active discussion and refinement, aka "not quite ready yet".

Other than that, your comments all looked very sensible.

Thanks.
