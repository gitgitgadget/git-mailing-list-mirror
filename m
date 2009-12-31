From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: die explicitly why when calling "git branch
 [-a|-r] branchname".
Date: Thu, 31 Dec 2009 15:09:04 -0800
Message-ID: <7vaawyrban.fsf@alter.siamese.dyndns.org>
References: <1262184331-9102-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 01 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQUAQ-0001iM-LR
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 00:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbZLaXJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbZLaXJN
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 18:09:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbZLaXJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 18:09:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC6E58C66C;
	Thu, 31 Dec 2009 18:09:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ft70sKORSGlpkEfksVd2rP9R96A=; b=lwcKzxrlg9e0BxopticGKp9
	gNxBmdIJK2rAs76wmrN1y5NdBADkUd+Rjfqc9HyWfqsjXKykSSvc55/q8j1dfW6s
	urpS4ZJT9E8S8bl0exSWfJbwdgdgglOShJkr++aO+svdh3e65j7l+8A36zTssz94
	BEkXtUKPDDqqnds1pCkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JHR03MftK+3x88xwvMtib5EFPTMlp5TNgtT5GhPoIKCZVmyiD
	QRhFpHVcJBp4b+jMcshcf0vSHTOdm3UbSg0bsj2NzhH29g11TyfY1EuBrtmzhv9y
	YC1Ia9EC7uY/3MoQ3evCiQbRIrhqQQ/rpPmv8KkP6c07sR/4iVNOBPIMXM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C64518C665;
	Thu, 31 Dec 2009 18:09:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3143B8C661; Thu, 31 Dec
 2009 18:09:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80049530-F661-11DE-A363-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135981>

Thanks; will apply to 'maint', together with the SubmittingPatches
addition.

Interestingly, this revealed a long-standing breakage in t5403.
