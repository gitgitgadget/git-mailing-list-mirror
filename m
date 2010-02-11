From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-mailsplit: add `mailsplit.keep-cr` configuration variable.
Date: Thu, 11 Feb 2010 12:36:05 -0800
Message-ID: <7vmxzf33yi.fsf@alter.siamese.dyndns.org>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
 <20100211181354.GC15028@scotty.home> <m3k4uj8vts.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:36:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nffls-00075k-H5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 21:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab0BKUgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 15:36:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786Ab0BKUgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 15:36:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05314986BF;
	Thu, 11 Feb 2010 15:36:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uCQ89y/6weT4ocQOo6Eo6tB6GFM=; b=pxTQp8QVD9ab5MeSghhx4Kk
	TsLxz304RWejaoHA6YLynHn3Xy54fHM9h45pXgUo7qPZuoL/owDIi/Z6q/mTEgsV
	yImJ+bM6vI0SyQmloatNOPwQykrgDxjrw+1ZedrF7qm5KgYESYQTSjRhXj442mv7
	Cd/zUBPCpU9CjVSHXsAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KtQZpGoDyiT7IZB0BLZ2YlEX0s7b8Trzk9Miv1Skr10kTtvTM
	EP6Zns13cYWdod06YlvLWL3O2L4N+qvgYE7E+YSn2mFKU50SWbIPTqJS3p3pfVDK
	QAF2rNb9l8IGXSgBi9iy0hwWRuDOcngtpfYrvC6bgaRzG8eSLJCk0XthHo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDEE1986B5;
	Thu, 11 Feb 2010 15:36:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AF8D986B0; Thu, 11 Feb
 2010 15:36:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16D5CDEC-174D-11DF-8613-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139621>

Jakub Narebski <jnareb@gmail.com> writes:

> etc., with the only outlier being add.ignore-errors.

Perhaps a synonym add.ignoreErrors would help, so that later we could
deprecate that outlier?
