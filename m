From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sparse-checkout test failures [powerpc-darwin8]
Date: Wed, 04 Apr 2012 14:34:43 -0700
Message-ID: <7v1uo389l8.fsf@alter.siamese.dyndns.org>
References: <Pine.LNX.4.64.1204041616001.16407@hal-00.csl.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Fang <fang@csl.cornell.edu>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXqu-0002Q1-RR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab2DDVes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:34:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935Ab2DDVer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:34:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EBA3AE0;
	Wed,  4 Apr 2012 17:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NrIhkwuAv6ecC5eBTgFhZmTj1DU=; b=BkKJ6L
	zU33m+WA0RRpOEuVyV1br9N/1oN9Si5YWJWe28Sl4/KBjVwO6fAiKCKX1B5STdt/
	rntKE/Pn8VdlX6w2CVrxBHy0L9NWfy2oy/xB92Tgkh0aUWsuEqt+GUVLFwv8d0+T
	enzL+PnpxK0X+iBKSLdm5ot4XkJ/rlTCFg+ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p5SXVmT5buKemql9bkOzz0A0gRCRO/jL
	r4ud24qavhqoNqpcAx0Jj9AWiIUHwRT19NpvDHS0ZjjQEjQISAtC93Y64P5SNtYC
	M/l3ENagPWAjvKPOTdR/5nBXwrHsJT6yJun1pqJJQj4v6sJXjnv3NVHpFwpCYSCl
	thV6Wt7cbZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7613C3ADF;
	Wed,  4 Apr 2012 17:34:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 450BE3ADD; Wed,  4 Apr 2012
 17:34:45 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.1204041616001.16407@hal-00.csl.cornell.edu>
 (David Fang's message of "Wed, 4 Apr 2012 16:20:08 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF1DD900-7E9D-11E1-8059-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194746>

David Fang <fang@csl.cornell.edu> writes:

> 	With git 1.7.9.4, I'm seeing test failures with
> t1011-read-tree-sparse-checkout.sh.

Hrm.  Do you mean 1.7.9 worked and 1.7.9.4 doesn't, or you just happened
to try 1.7.9.4 and do not know if this is a regression?

I do not have any Darwin or PowerPC boxes, but the answer to the above may
help others who do to help diagnosing the issue further.

Thanks.
