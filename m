From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-push: fix an error message so it goes to
 stderr
Date: Mon, 08 Feb 2010 12:45:46 -0800
Message-ID: <7vzl3jihhh.fsf@alter.siamese.dyndns.org>
References: <20100208201956.GA7015@cthulhu>
 <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:46:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeaUb-0003GA-D1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab0BHUp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:45:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHUpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:45:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D39D9892D;
	Mon,  8 Feb 2010 15:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSlBcukDp1rxI0sO3wfrgsDWUps=; b=IJni8Q
	YpP2OSMHqymTKSEvuKk67pBCI7pQauf53ZkG7OXNeLVT/GIN1sftoaLBsrN4tgtp
	ynWvcSEYYqWUo1/zCYSAVZ2BHgo7uM5g2A6NKhN7+3d/dkOXPqRvjZcXYZHTCn2Z
	ot50euKWJ+vC+N/47n73UbCsrrb4z5EMXMcbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYsxOX8lQ9xe4i3dBdxXp+uC+itNgSyV
	skYVSJoJFtm3Nzk5AIgTUfGolS2myDs87Nkmhy1i5JlaRiawVMfxcQkKOrD8pvFu
	6Faadyt9ddSyb8mxi/9jILzRx4aVaR/332RX1pW+Hh1XEQ8h5nWGkKOz1ZEqTsLN
	Qg0Tu3D7/Ws=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E5298928;
	Mon,  8 Feb 2010 15:45:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8024B98922; Mon,  8 Feb
 2010 15:45:47 -0500 (EST)
In-Reply-To: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> (Larry D'Anna's message of "Mon\,  8 Feb 2010 15\:31\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F0F040DC-14F2-11DF-B3F9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139316>

Larry D'Anna <larry@elder-gods.org> writes:

> Having it go to standard output interferes with git-push --porcelain.

Could you at least update this rationale?

You will be squelching this in [2/3] when --porcelain is used, so the
above is no longer a good justification.  It won't interfere at all.
