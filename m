From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/18] Rewrite dynamic structure initializations to
 runtime assignment
Date: Tue, 01 Jun 2010 21:39:16 -0700
Message-ID: <7vaareqc97.fsf@alter.siamese.dyndns.org>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093731.063765000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:39:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfjk-00029z-52
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab0FBEjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:39:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0FBEjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:39:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E49AB6EE7;
	Wed,  2 Jun 2010 00:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=b3I/+5Dd4uheUCr7/0iJz8b1MhE=; b=vfD/gsE2xi0Bhssidova9HP
	iw/hUi0ufEMogNkKDXK+6OtNU+cWw5eaOigKc2mAjrGzly3k4zmiHeyXim0J4qyf
	Z5/fJebmLF3OVZIBW4ryDWOTYG3JJiAzgf04n59pudP9k0cWJ6kg9o0Ei3aofhTT
	gggO3XCUtGfjOXdzi2lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kBz27KuFusUkCpYbIzlCk6bSiK1oLYvitf6z3Bg3VQRvhI61n
	khbf1TPy3nFiUYPk9f91XhVMk4oxCU0TINBQFW1Y4/QBZPhdOhcqVgZLFjgcH16l
	u30hMrMATlQttNN20w/HtW7iBMJBaVRUVA/cLUKukMBumCIHIYRTTnn2sI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A16B6EE2;
	Wed,  2 Jun 2010 00:39:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 754B4B6EE0; Wed,  2 Jun
 2010 00:39:17 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF493EAE-6E00-11DF-8274-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148194>

This one is really unfortunate, not just because it adds quite a lot of
noise, but because anybody touching the codebase in the future needs to be
aware of the limitation we are imposing on us.  The same comment applies
to 04/18 (enum without trailing comma) but the level of annoyance is much
lower there and I would say it is at an acceptable level.
