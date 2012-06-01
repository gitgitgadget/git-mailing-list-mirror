From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Fri, 01 Jun 2012 10:57:14 -0700
Message-ID: <7vmx4m3og5.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
 <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
 <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
 <20120601093039.GD32340@sigill.intra.peff.net>
 <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
 <0A6ABBD7-01D5-4A24-BF0F-78A7F2C46938@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 19:57:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaW6J-0005YF-5r
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 19:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759979Ab2FAR5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 13:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759591Ab2FAR5S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 13:57:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F318BE4;
	Fri,  1 Jun 2012 13:57:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8CjO7G1DnrmW1QVid097BNY7YY=; b=TsNabR
	ML1NXt3p++yMh4khEENa++JyVhSrbPpGJYvvuFqidCpAk1vPw2mf+ZmgudlfiIqt
	0rv77P6xTFv/rIKR6hNZqzGVogS34Y6yV8fPhIEM0JZnv1r4tz4X9JG0KceVJbxr
	DUYpexb3muump1ygK6t1fUaS9wEYOeTO0Q7ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFrW//mdCiufcdcnWwFK8lNK/M+Gmtcl
	CZlitgnwJHkT0nWNq7R8q+8AP8PidtfoBupJUdEuMI6kB5Ci2SyG9ThTYKmZosnh
	Cri1/snj2WOP3koEh66KS7/R/mMLAvtOZDmLhR8GsUblBXolr0zlBHJHUFukW2XT
	wh/41MiyXWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513D18BE3;
	Fri,  1 Jun 2012 13:57:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D84D68BE2; Fri,  1 Jun 2012
 13:57:15 -0400 (EDT)
In-Reply-To: <0A6ABBD7-01D5-4A24-BF0F-78A7F2C46938@spotinfluence.com> (Lanny
 Ripple's message of "Fri, 1 Jun 2012 12:05:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3907631E-AC13-11E1-B4D5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199008>

Lanny Ripple <lanny@spotinfluence.com> writes:

> I still think the best solution is figuring out if the platform sed is sane at build time and using a full path (via config setup if being able to change the sed used is a priority).  Short of that something as simple as
>
> (git-am:699+)
>
>    if test -z "$GIT_AUTHOR_EMAIL"
>    then
>            # Can occur when sed in PATH will not handle UTF8 under LC_ALL=C.
>            gettextln "Patch does not have a valid e-mail address."
>            stop_here $this
>    fi

That is a real fix to the issue (can also happen to name, no?) and
is worth checking.
