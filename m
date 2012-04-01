From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Sat, 31 Mar 2012 19:22:47 -0700
Message-ID: <7vehs8i420.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
 <CA+7g9JxK5DHj3vbdGgF2dEJxvn=_ZfjAv7Y+AL_P-aO1FVB6-w@mail.gmail.com>
 <201203312348.q2VNmsmc015543@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 04:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEARe-0005YX-Aw
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 04:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab2DACWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 22:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056Ab2DACWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 22:22:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78BA56A9B;
	Sat, 31 Mar 2012 22:22:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gy+QWebGB+auA2V74y9iDRIxsHM=; b=h8hcHK
	KS7eU/6cTd1TGBKpepz0ISPM4BA9UZ1y816dDI+39ywE1bPWwmiAdjCujDXboatj
	fczzE3tAT15vI472VO8FOBgN1EiBdOAOihOBDufpQdCVLVgM/gxSu2wS+MOHzvqj
	wpF58XZUL6dFWy4iJfDcMSo8+ZVXjn5EhB1K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dl99+pAUTMgEB+NajBVK8GW513fEhT+w
	0P+8Cg0lqUb+ihO5e0XS29+J97vxcZdKK5dT/0dxACPnvvSjPGAx8P9W2L+80bKc
	UlShRpINMfCgeW1whZ+2YdKXHg+lE27QdUl5QhUI5AOQFaDRVjZdRJdfjMOxKYZW
	JulWGncaKbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7106A6A9A;
	Sat, 31 Mar 2012 22:22:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04F5D6A99; Sat, 31 Mar 2012
 22:22:48 -0400 (EDT)
In-Reply-To: <201203312348.q2VNmsmc015543@no.baka.org> (Seth Robertson's
 message of "Sat, 31 Mar 2012 19:48:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9360064C-7BA1-11E1-842F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194473>

Seth Robertson <in-gitvger@baka.org> writes:

> However, the current message for this use case could seem to be
> tweaked to take care of this:
>
> $ git branch BB origin/B
> Branch BB set up to track remote branch B from origin.
>
> Add "If you push your changes will go there."

But you need to limit that only when push.default is set to "upstream",
no?  Otherwise the message will be confusing the user.
