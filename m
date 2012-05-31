From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 11:33:17 -0700
Message-ID: <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Thu May 31 20:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaABZ-0006ri-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214Ab2EaSdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 14:33:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758340Ab2EaSdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 14:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D4B8C42;
	Thu, 31 May 2012 14:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EqGZwaYMEWpv421WulCc/YJH9h4=; b=eb4koz
	snASnlAYHjCOCsyHu3zBOebo+oTny0g1/c+fIvSojz+Jqs6Nql1zSY+5cA/HtoCM
	v6LcRFYMpwj02t8mGPVMwZ4Tfrza+txmS1admDvTBCQI/QF9yKCr8SiSdAgko965
	ShXAN6VT5BqT7Cl2JoqZCCgMVDOu8d/PnAdlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TA6g+oMG1LmJX0qKzlGqSoZi6SpO31Ul
	oNPTWT1DUuyQ/xEtkB8gP0jWUmLfQtpmuPXAJNvO0l5m3fi3RhrhpHQnX+7MRthK
	Zv8jh4GfGGD+Nic6RcN4BmmOO1pUHpxE5mkmTnyxoZXlSP/OkqkgKk0yYfaqdllT
	f+nGRWgJNOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E35D8C40;
	Thu, 31 May 2012 14:33:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 232A18C3D; Thu, 31 May 2012
 14:33:19 -0400 (EDT)
In-Reply-To: <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com> (Lanny
 Ripple's message of "Thu, 31 May 2012 12:49:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1804A61E-AB4F-11E1-B146-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198938>

Lanny Ripple <lanny@spotinfluence.com> writes:

> Perhaps the error message in git-am could be modified to indicate
> sed is a suspect?.  E.g.,
>
>  lanny(master);<work/IdeaProjects/Piper> git rebase master rl-clean292
>  First, rewinding head to replay your work on top of it...
>  /sw/lib/git-core/git-am: line 692: Leblond: command not found
>  Patch does not have a valid e-mail address.  (Used /sw/bin/sed found on PATH).
>                                               ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
>  lanny((ae6c220...)|REBASE);<work/IdeaProjects/Piper> 

Hrm, that does not sound an attractive way going forward.

Do we have to suspect any and all uses of POSIX tools, just in case
somebody installs a broken implementation from random places?  Is
sed the only thing that is possibly broken?

By the way, have you filed a bug report to whoever supplied your /sw/bin/sed?
