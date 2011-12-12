From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Update documentation for stripspace
Date: Mon, 12 Dec 2011 15:41:39 -0800
Message-ID: <7vwra1z7bg.fsf@alter.siamese.dyndns.org>
References: <7vy5ui5h0k.fsf@alter.siamese.dyndns.org>
 <1323728909-7847-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFVE-0003bd-TS
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab1LLXln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:41:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab1LLXll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:41:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B836D7F;
	Mon, 12 Dec 2011 18:41:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LN+GckGrMeSd4PIPL6qaRDC9EAc=; b=pFZilR
	P8h8fLXVJY3840uaLCY/UxIZJoxnxaSJhCk0CqyDPCOss5/stXjzkYl6uKRSdlZo
	Rm5DX+ZGx2Ym1PkhCGWICJGqHFkwSjgAQFnuZjcnW1R348rr3S/VWVYdqEUeyUg/
	rXJgh7XuP8REt/0Pgw/ViU0m1FfUK+dxNCMfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZqkYrU4q2yXfU+pmb+ZSWHegEAXFDJI
	NsbnnhGEEW3tLtzOuFVvK0yUV7bP51t8efNtV98K2iMV4Bdk6FVwIRLNcJ2dTqsa
	gWKBQJ0pulZESApnrTxuC5gwGQAbKHqCFc0He+C7Yo7ndki+7sr9pc2v3ov9tqE1
	UFaWZDVtEAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B946D7E;
	Mon, 12 Dec 2011 18:41:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 608386D7D; Mon, 12 Dec 2011
 18:41:40 -0500 (EST)
In-Reply-To: <1323728909-7847-1-git-send-email-conrad.irwin@gmail.com>
 (Conrad Irwin's message of "Mon, 12 Dec 2011 14:28:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6FC3D4A-251A-11E1-A441-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186974>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> ...
> I've moved the *NOTE* into a SEE ALSO section where I think it reads
> less opinionatedly ― is that better?

I think it looks a lot worse.

At least your original hinted that some people may confuse the two and the
NOTE was there for such people; other people who would not even dream of
such a confusion won't find the existence of the note a "Huh?". But the
updated patch with a link in SEE ALSO section without any explanation
would be a definite "Huh?" for those of us who find that stripspace does
not have anything to do with what "apply --whitespace=fix" does.

The new example section looks good. Perhaps we can just drop the extra SEE
ALSO and resurrect the *NOTE* from your v1 patch.

Thanks.
