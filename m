From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Mon, 05 Dec 2011 14:30:04 -0800
Message-ID: <7v39cylkib.fsf@alter.siamese.dyndns.org>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
 <20111205215148.GA22663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXh3A-00013P-6I
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609Ab1LEWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 17:30:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1LEWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 17:30:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D176A6A5F;
	Mon,  5 Dec 2011 17:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXtx9Azqj77FT6XmfbtNN83VKjc=; b=L78Rxu
	Q+jcqeysElKR6pmGkSx4RatC20YAIuzKYNBvSaEZ8ZV7DUOdoDs6DjiuU8gXfVOh
	JDCOgAUHVtgf+gqSt30BsDzusmo9804pLaQJ1FBLp0Cogl3GD13ddYjDiW4YD/+l
	73mr4vGGxFwq58ZNheGjQAmBXErlPNuu30Gm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsQiUSsgxXSTQW3R0VsPHTZg3c6jLbqb
	jZcxQTUcSveRtLS8xDV7P9TeYpCjoGlOGUMt81gIvlpHmfQll5TT+p6AqlxA4+FA
	RseKpsF/FH7whod9xeRKKisWTZ4O9FdQt/uN6bY8zctJ8La0JCYavbNUkg4gy1nt
	ig0kj15UNco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C87226A5E;
	Mon,  5 Dec 2011 17:30:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CB686A5B; Mon,  5 Dec 2011
 17:30:06 -0500 (EST)
In-Reply-To: <20111205215148.GA22663@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 5 Dec 2011 16:51:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEA96F28-1F90-11E1-9E55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186295>

Jeff King <peff@peff.net> writes:

> More importantly, though, this seems to break t6300 badly. I haven't
> looked into why yet, though.

Also breaks 7004 which is _about_ tags.

Rolling a broken patch in quick succession to v4 without ever running
tests (and not adding new test pieces to protect new feature) is not a
very productive way to use the reviewer bandwidth on this list.
