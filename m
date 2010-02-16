From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] grep documentation: clarify what files match
Date: Mon, 15 Feb 2010 18:03:48 -0800
Message-ID: <7vfx52rl6j.fsf@alter.siamese.dyndns.org>
References: <7vvddz5l1z.fsf@alter.siamese.dyndns.org>
 <1266279940-13251-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhCnN-0004OO-Kd
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab0BPCD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:03:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab0BPCD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:03:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE6179A0FD;
	Mon, 15 Feb 2010 21:03:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxOAkdJETzeJ2Lb4O35UfRy6xNQ=; b=bkOOuN
	1Daq9Wn/su4hCZlWMiceImOPXiPvPoF04M6RBS/1QHNcmHebEdzmIYqyWZIeoyAa
	3pGOy1WH0g9KqSd425v8iv7PB4mG+t4qtoAkkrjTTXUVIOa9gH6Nbt2RPc8485A0
	YOGnouU/h8sdiDmpQFGrX7nhywqIkOTHD3G+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWDE6digsqc3WrB+m19n4ybzsZCS42np
	mWOL9rZkMRlua0gwZWSKonFKQnnVqZyjxUfrHgxrYFBU7CV/y/JbE8T0XAKbXLIU
	Sba86yYHzvl8Ogzd6th2byUb67suZdLcQTyr++rK2lrt5xCCfQyeXr3tPXEMJxyi
	JBSY66MV8gM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C55149A0FC;
	Mon, 15 Feb 2010 21:03:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EBA99A0F9; Mon, 15 Feb
 2010 21:03:50 -0500 (EST)
In-Reply-To: <1266279940-13251-1-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Mon\, 15 Feb 2010 19\:25\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87F89A0E-1A9F-11DF-95F1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140057>

Mark Lodato <lodatom@gmail.com> writes:

> Clarify that git-grep(1) searches only tracked files, and that each
> <path> is a glob, as in git-add(1).  Add an example to show a simple use
> case for searching all .c and .h files.
>
> The meta-variable <path> should be changed to an official term for
> a path glob, and the description for this should be in git(1), not
> git-add(1).  However, we don't yet have such an official term, so just
> use <path> and reference git-add(1) for now.
>
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---

Looks much better, even though I personally prefer a shorter "work tree"
and also think the official name of the stuff is "pathspec".

Will queue until an alternative materializes (if ever) ;-).

Thanks.
