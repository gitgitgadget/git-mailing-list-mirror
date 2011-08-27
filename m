From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t/t3905: use the name 'actual' for test output, swap
 arguments to test_cmp
Date: Sat, 27 Aug 2011 11:50:36 -0700
Message-ID: <7vei06adtv.fsf@alter.siamese.dyndns.org>
References: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hilco.wijbenga@gmail.com, david@porkrind.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 20:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxNxr-0002lH-5j
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 20:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab1H0Suj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 14:50:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1H0Sui (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 14:50:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FCB39FE;
	Sat, 27 Aug 2011 14:50:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZdCieGn8sf1Q4zsfPkTcvSMs0d8=; b=jdqWTx
	IrBctO0d/3NLOFkURvNZcqbw3ECXm7kJZCVbpqAJXLFi+aEorXmAx0Rcmahv/sYz
	jitLpsLnNT0WUWOwbY9SMqqXKS73xnMG6qWNUGYCeyLvzYmAchINuaC6LHwti1V2
	qBVTl4fphUn7Q7wA2unM0HDtlHe4wFtFuAL3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HlYxqhUGc/AE7C0YiTqzD3nJ08fAcNBL
	vQsJ8XjcbMJRQ3OagXGcfvOnZmVQj05bwG3Gb5cbrtAXxQ20BcoC6/CzKu9Zb2hG
	u1eNo0LeHhjT7oPMZprez6QvW9bkO37xJs4dy1lPIrrulLS6qjSE/8ohFcIALRU0
	UxP4uc7d2w4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1CA939FD;
	Sat, 27 Aug 2011 14:50:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7407B39FC; Sat, 27 Aug 2011
 14:50:37 -0400 (EDT)
In-Reply-To: <1314406767-17832-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Fri, 26 Aug 2011 19:59:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7412D48C-D0DD-11E0-9B83-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180240>

Thanks; will queue all four patches.
