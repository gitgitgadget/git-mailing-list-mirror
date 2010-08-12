From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 00/17] Reroll a version 5 of this series
Date: Thu, 12 Aug 2010 10:23:14 -0700
Message-ID: <7vzkwrsq2l.fsf@alter.siamese.dyndns.org>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbV4-0001MY-0O
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab0HLRX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:23:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab0HLRXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:23:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67CAACDA38;
	Thu, 12 Aug 2010 13:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=WfBM5qnxrIIfdnSoAy8vycUi7Lo=; b=L1/mC0AaRSg0wHd3FTFEslg
	WgHRlIIKefrHpfQcrBfGp5BwMRhqmbP/+a+U0Bu6qbh4EoEF5FjdVmVt2CpA8Ltq
	7qO35FHU0TM/3pWTIRaZz2Pb41Lk/7Ah6JtdSxfl5HC0Iuar1IpY4pDd+hTk7FHp
	KAxNkB0UHGqGGO1mj1bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vjY32mCCv5+bLmV3BigVtD7IKSYXvAsFJmaDskRR5WncUvQTL
	bnYtWUyr4f6eTf+a/2oV9dFUKuke5T+lmjH5pu4UmJi0t+5A33FKwrS9GSoe05aT
	9QU6NEYnXwFIQufHltf0tb8G4LIdicR7dHzM491KF/nARPHUG0mUkCBv6Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2227BCDA34;
	Thu, 12 Aug 2010 13:23:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 539C3CDA30; Thu, 12 Aug
 2010 13:23:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DFA9816-A636-11DF-A846-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153393>

Bo Yang <struggleyb.nku@gmail.com> writes:

> 3. '$' to represent the last line of a file;

That is probably a nice addition but a literal '$' is rather hard to type
from the shell.  I thought "-L n," already meant the same thing as
"starting at line n thru the end"?

It appears that this, when applied to v1.7.2 (with minimum compilation
fixes), does not pass its own self test.  I haven't looked at the details
but will queue the series to 'pu'.
