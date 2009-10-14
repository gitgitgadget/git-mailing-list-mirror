From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bisect reset: Allow resetting to any commit, not just
 a branch
Date: Wed, 14 Oct 2009 02:13:45 -0700
Message-ID: <7v1vl6fid2.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
 <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0910131116300.5105@dr-wily.mit.edu>
 <200910132206.18460.chriscool@tuxfamily.org>
 <alpine.DEB.2.00.0910131700320.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzwU-0004qZ-Qb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbZJNJOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbZJNJOf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:14:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbZJNJOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D41658DC9;
	Wed, 14 Oct 2009 05:13:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8xWpsE+yefWJA5MgI4gMQpPFILM=; b=HWhWPbrFlhNsVgqXS5oy2eF
	2pPOFPatX9rFRuu4c3ogYcsFjPJRgW6qIjVuOFnIRCixgVvTT7LGZ30kI6G2RZN5
	UOvQf1c/sDHdsmyE/WQW8U9veYcVpyGL2XLaauVfI7BbECEpf3Yo+J7D4BbGQqlX
	EQL/2kGGPT0JyINQpmgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QZuMPiueWqztLiyRh/lfmc4yjQ35dKb8Fi7pkGoEQ2rczw1h/
	s3kWvw4iKYySdok97x6L5bPCUWzUsrmpYRQn54rbs56ye/m5by547xj5+OVsyTzs
	fFgfp30pcbXGpQpjNLan28Rp7p/EL4wdGCdQjvFgbq/BEW8Gl/y2L0eHrg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0647758DC8;
	Wed, 14 Oct 2009 05:13:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 689FD58DC7; Wed, 14 Oct
 2009 05:13:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2ADFDAA-B8A1-11DE-8BE3-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130271>

Thanks; will replace your v2 that was queued in 'pu'.
