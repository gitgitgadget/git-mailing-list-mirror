From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-show-ref doc: typeset regexp in fixed width
 font
Date: Fri, 13 Jan 2012 11:51:00 -0800
Message-ID: <7vwr8vxty3.fsf@alter.siamese.dyndns.org>
References: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
 <1326472756-15227-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jan 13 20:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rln9c-00026s-1r
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928Ab2AMTvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:51:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab2AMTvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 14:51:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A1075D65;
	Fri, 13 Jan 2012 14:51:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NbvX4uoCkEszczwkB54SjE4ToU8=; b=lMFL7p
	VhhzqwwkddvP/wTEc5ZMs1BF5ZtvbfYlKC1ljhwks/rd0YmXIos0LQ4Q20kENRIy
	geKacjFOu0QD/y1EpV5kzzQTsbr+JhflRvAYaewM3+x9tZ2xI/ky0LbR2XefJTmY
	F0IgqIolsQjesCeo1o34zpeQnVGCc+fkeU4A4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=odbb/xaUqPRAiUMrW5NtaYfcoHTvoskU
	J1Dj8V5W/fy73goW9YGSHTML7B9Q/IHRsHiLbqXVf9lZiHQQDB3Sj0+uHsypXjoX
	DT2GDcr9E71DUJcF6JbygQV8r/H1/p3t2zp8qCA7As9+TpE7YVRE1Apbgt39fDGW
	qY9HrrFkxek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8148E5D63;
	Fri, 13 Jan 2012 14:51:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE9DB5D60; Fri, 13 Jan 2012
 14:51:01 -0500 (EST)
In-Reply-To: <1326472756-15227-3-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Fri, 13 Jan 2012 17:39:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBDD6A68-3E1F-11E1-BC85-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188535>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Optional; I think it looks better.

I agree it looks better, too, as long as everybody's copy of AsciiDoc
groks it. I see "`<something>`" in many places in the other pages, so this
should be safe.

Thanks for resending. Will queue.
