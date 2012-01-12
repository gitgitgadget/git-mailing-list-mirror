From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t9200: On MSYS, do not pass Windows-style paths to
 CVS
Date: Wed, 11 Jan 2012 18:06:01 -0800
Message-ID: <7vvcoh4quu.fsf@alter.siamese.dyndns.org>
References: <4F0D5367.1000506@gmail.com> <4F0D544E.6010105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlA3T-00060v-Ie
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2ALCGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 21:06:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2ALCGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 21:06:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAAB37FE8;
	Wed, 11 Jan 2012 21:06:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8nQw2bm4wgXzAGif7Cn/VTR62c=; b=yBWDFz
	mGuxaNChnCuZLOI3p9TWK5pxuhrXYoDpurdRQoHhyTeQi+Fvo70sUsUTdKeFL+Bz
	LUON0LJesB8vVnA0P88c43LnN/d03vR3xViZfymA6SIZgMwa1zN/LI+qN0VgvwgL
	1Da162VbiU4O3htgaokLhUphZP+q0aEFExITk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+o3xGcoh1rgmCC5OWNuYDbo+LtMpmaM
	/lDzQVfu0pLu10Q3/rVOp1hl2Pr6YRGOHTUp/zZMXLIcPLK0wrzqBGfL5f4W1CBT
	ilPcIGCmt1VwraWtY7mPDB7boWlw4ve/OIQ6JC3651wZlrkVcT1TJHrMHSqfap/l
	qQEG++HjN58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 756B37FE6;
	Wed, 11 Jan 2012 21:06:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8B4D7FE4; Wed, 11 Jan 2012
 21:06:02 -0500 (EST)
In-Reply-To: <4F0D544E.6010105@gmail.com> (Sebastian Schuberth's message of
 "Wed, 11 Jan 2012 10:20:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAAB191E-3CC1-11E1-A91B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188413>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> For details, see the commit message of 4114156ae9. Note that while using
> $PWD as part of GIT_DIR is not required here, it does no harm and it is
> more consistent. In addition, on MSYS using an environment variable should
> be slightly faster than spawning an external executable.

Thanks. It seems that the "Dos and Dont's" from t/README needs to be
stressed a bit more strongly.
