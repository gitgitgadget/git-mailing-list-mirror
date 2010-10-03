From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2  0/6] Extensions of core.ignorecase=true support
Date: Sun, 03 Oct 2010 16:34:32 -0700
Message-ID: <7vtyl2df5j.fsf@alter.siamese.dyndns.org>
References: <20101003043221.1960.73178.stgit@SlamDunk>
 <201010031017.35112.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y4u-00064p-A5
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0JCXen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:34:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0JCXem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:34:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3042DDB262;
	Sun,  3 Oct 2010 19:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c9soSroJRM9opbMW+Hjp6StwSug=; b=WD3OMXVFHXmNXRsJhAkkq9U
	tpPH9MiWDqEu83VKe74guFLmoRKjpB/+nsZa8001fDMnRmdA8Jjb3CpaJzMF1vax
	eQ31sq+vEZSwmhcIq5f7Z6rkY2ltlI1s06aGOfq04y25K+yhliMGrMpFvVoFYNE2
	3j4ByPg2KGqr7U+cc1ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kGplSvR5N+Wijv3MZlaUarlJgQWTKYe/g1DwGX5s8NiBx1UjU
	VdIFjssbaJehrAi1XA1sqgM1m2qjC5Cp57pZdWZDY0hb/njj02rxPj27+PluC2i4
	qX+6lf5+NeqmpUtmPCGLrkMGgNkKk9Lo5ILqPip7nAbaO/87p5noWFDEV4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0D8EDB261;
	Sun,  3 Oct 2010 19:34:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 288DADB25E; Sun,  3 Oct
 2010 19:34:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA1744C4-CF46-11DF-8494-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157952>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio, IIRC, the series appeared in next for some time before the 1.7.3 
> release. Does this imply that you reviewed the series and deemed the 
> implementation sound?

Not really.  I knew that I had an opportunity to rewind whatever crap I
throw in 'next' soon, and wanted to see if anybody screams upon stumbling
on breakages ;-)
