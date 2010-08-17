From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Update compat/regex
Date: Tue, 17 Aug 2010 16:19:44 -0700
Message-ID: <7vzkwkaktr.fsf@alter.siamese.dyndns.org>
References: <20100817080322.GA28476@burratino>
 <1282037082-12996-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:20:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVS1-0005NY-SD
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab0HQXUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:20:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0HQXUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:20:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 975A3CE6F9;
	Tue, 17 Aug 2010 19:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LVRPfNPSYZznShy9+Wn6QWcwB/U=; b=DJL4d2
	6VfVnuWIEfIuwSRmhAXNLULvIFToqgAcgf4PiJjCTrTwbsoIU1grYAxJcIsV7pIi
	nNvt5joGwQTeTHl+prSat7lhA6/ySwufSCp0F/6yRk4hbfdd+sPMNquUzwZP41U+
	mQtq6cI0lX0qpkiu3kYpQexzZM5qbTu8UzV1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUPfh6L7ZPCGlgGCSgObYRLcL9z6T1Z8
	kwe0fJ5g1KOcErlgIE82pAJUuDWx6kFdCGQjfBKmXb+zwmo8gGV38daeAwhXnFnV
	B7wXI/qm4SG01LD9p6AaihK29cqqn8CBYSmSge77XG5gUknmhl1wpuaSFe9JPtMI
	8dP4tEF6UCw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 081ADCE6F4;
	Tue, 17 Aug 2010 19:19:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C77ACCE6F2; Tue, 17 Aug
 2010 19:19:46 -0400 (EDT)
In-Reply-To: <1282037082-12996-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 17 Aug
 2010 09\:24\:37 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F264B26A-AA55-11DF-A2FC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153787>

Hmm, is there [1/5] in the series?
