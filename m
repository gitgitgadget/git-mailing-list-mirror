From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Rename 'tagcontents' to 'cached_tagcontent'
Date: Sat, 08 Sep 2012 22:11:34 -0700
Message-ID: <7v392ru6ex.fsf@alter.siamese.dyndns.org>
References: <1347130993-69863-1-git-send-email-davvid@gmail.com>
 <1347133996-70908-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZot-0003hC-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab2IIFLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:11:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab2IIFLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 01:11:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF26542A9;
	Sun,  9 Sep 2012 01:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFNqKFxfDudKJofOXp2IQ6qZHsE=; b=WPuf4P
	L9DIKxybnEL+a3s9IU6YzKI5SQIxy+YooepGMFbIXKBKbPyi2CRwS6IIlFzgDCPU
	J4YxlTSjFFfV/YA43tBMbopNSpHvyYpVX7TD9jTETO6WFvSX3bXpyNqOgSEmaR7D
	0sx5SjTHYhmO9CmZSkv06Suv+qvfKVKEgODVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gCoVOIuo5jBLWLLc/wQMzxSg3nB9r1lR
	vc4ZBPfAXyNxaBiHpINN6MaUFaOD/5I5eCu3Ji+ur31D4fRaqxrAMjPGrUvLYoFv
	FPNOtRYfOFgJ7ZsZ5E1HIrdS4Y12hhZKxMLeQEBj9MEV31i/D7UnsCtiRPPtDPBj
	iUFZp6hLB0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD67B42A8;
	Sun,  9 Sep 2012 01:11:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B8C842A7; Sun,  9 Sep 2012
 01:11:36 -0400 (EDT)
In-Reply-To: <1347133996-70908-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat, 8 Sep 2012 12:53:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D422E252-FA3C-11E1-8141-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205044>

I've applied these two, on top of Paul's master branch at

    git://ozlabs.org/~paulus/gitk.git

and tentatively queued in 'pu', but I would prefer to see it
eyeballed by and queued in his tree first.

Thanks.
