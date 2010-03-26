From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] fmt-merge-msg: hide summary option
Date: Fri, 26 Mar 2010 12:30:40 -0700
Message-ID: <7vpr2qlw2n.fsf@alter.siamese.dyndns.org>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
 <1269414964-9518-8-git-send-email-bebarino@gmail.com>
 <7v4ok5dsqr.fsf@alter.siamese.dyndns.org> <4BAAF264.7050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFFC-0001e4-0V
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab0CZTax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:30:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0CZTaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:30:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15CAEA5268;
	Fri, 26 Mar 2010 15:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQvNcAC0HDRMpjXZUYMVM/04+Ks=; b=SdPdsj
	/jU431PO35sgy1cspaM7zuVuiAU3kGE75FmIBM500hTotY1ktsdzAb1HWOcY/0gP
	XQ4RTGCOnuV6Bij+XVuM4jgqaUhJ3JuTiq+h11UTmREuo0GKjEfwKMgIPr3d8seV
	XOd3E/rT7NK3XkKAyln2hBdk7dGk6Y3hAGLn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3RFyQPrdAT8bzJd5ZzuTX0iOUFmquLv
	1g9LX9+VBu6UUpCyfkh1xVGPgI5WakaLs30OY8Dk/IbXATdOpG5StF6isSzKYpVm
	vdm2powsQcU0CEklLWqSsDSm/9l5JexedQdj08/PnVHd5LQGX4wcIf8Y0w/doM7E
	erPf6PwuLuY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85178A5265;
	Fri, 26 Mar 2010 15:30:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77756A525F; Fri, 26 Mar
 2010 15:30:41 -0400 (EDT)
In-Reply-To: <4BAAF264.7050003@gmail.com> (Stephen Boyd's message of "Wed\,
 24 Mar 2010 22\:19\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14A108BA-390E-11DF-9901-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143268>

Stephen Boyd <bebarino@gmail.com> writes:

> On 03/24/2010 07:45 PM, Junio C Hamano wrote:
>> We could do that sometime in this autumn timeframe if we start making
>> noises when they are used, just like we did during the 1.7.0 transition
>> against soon-to-be-deprecated "features".
>
> We already make noises when the option is used. Probably need to make
> some noises in release notes though.

Then it would be one of the 1.7.2 items, I guess, as we haven't shipped
1.7.1 yet.
