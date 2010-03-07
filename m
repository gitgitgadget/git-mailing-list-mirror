From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Sat, 06 Mar 2010 21:52:46 -0800
Message-ID: <7vaaukadap.fsf@alter.siamese.dyndns.org>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 06:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No9QP-000604-Md
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab0CGFxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 00:53:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0CGFxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:53:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 874AE9F8D5;
	Sun,  7 Mar 2010 00:53:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iiKw87gUP5Wgm+OhGd1Eky+OPFU=; b=QrA2L6
	H3xijzlPnvmGJhmMVWFF5qkGG2m5k5EFUEai6ZJ551/7CBscJWk7SCotnKSPu6uk
	ae8UmTbXTAs4bkpOufBGwIFB0w6mag8buCEXjI6RRxV3JtuzE8M5nNU+zjjdygSW
	S3ENkQRENiQGJWDYNQkY+EieSvtjJswD+zpYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ip7cKkuTI/hlow3uJ1AwArO2hrxsQk59
	R8s1ILfLIYcotRhm8GUsX5dkBUuZcaLKC5tJPcL0Ov/sDKKFtPDkbIkXV2uBXzaa
	uW+elza4OynZul6ERj3LWQwDML9NCI+c2Al8ym8CAxr4vscGoiTBoPY0afVtYM5u
	Ps9jR0NrO1Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 178CD9F8D4;
	Sun,  7 Mar 2010 00:52:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 177AF9F8D3; Sun,  7 Mar
 2010 00:52:47 -0500 (EST)
In-Reply-To: <20100305202537.25469.73470.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri\, 05 Mar 2010 21\:25\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD74C574-29AD-11DF-A516-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141669>

Christian Couder <chriscool@tuxfamily.org> writes:

> and give an example to show how it can be used.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks.  With the example I think I can tell others that this at least has
one known use case that is not totally whacky.

I haven't re-read Peter Baumann's comments that you dismissed as a
mis-reading of your added documentation, but if somebody _can_ misread
what you wrote, that is a sign that it has a room to be improved for
clarity.
