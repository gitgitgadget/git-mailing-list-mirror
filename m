From: Junio C Hamano <gitster@pobox.com>
Subject: Extending this cycle by a week and reverting !reinclusion topic
Date: Fri, 18 Mar 2016 11:37:23 -0700
Message-ID: <xmqq60wjr5ss.fsf_-_@gitster.mtv.corp.google.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
	<1458219254-16343-1-git-send-email-pclouds@gmail.com>
	<xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com> <56EB8961.70302@fb.com>
	<CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
	<xmqqa8lvr7ix.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:37:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzH9-0001hK-Ao
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbcCRSh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:37:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754136AbcCRSh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:37:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3E9E4DA37;
	Fri, 18 Mar 2016 14:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e3yRFomrfNL0Q1XPtyPJA3K3QwY=; b=MFUY8X
	iu33yfhA08CRj8Hu5U9UEsaBIb+ROI8Y7FJkvGojs8pWciU4p/Ye0xn9InGNKfwo
	teWn/Ix6lbjjsku53bSKToHKCBJ8Tufu5jRwwR65iM6FN8CQ2N/Obk8dut1G6cQ/
	9Mugs6I2MrCxOKOVqQJK5ptqRL58QWX+oM6b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vSiTOevk3Ph41KbQ5TIEQcw4/NsrVLQd
	D48tpHO9lv3klEVaiLC/FMUQXMSuVDBIUs0y+V9z/7SDaShI4QXs92W+XpsXjums
	HgMAqzCwgHCIB36TG9R0wABCUXGGMKz5sHpyy73BrGARcFkgzHsmuBWsCbzcDWjd
	NfHzHOsrjmM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB4D34DA34;
	Fri, 18 Mar 2016 14:37:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B7D44DA30;
	Fri, 18 Mar 2016 14:37:24 -0400 (EDT)
In-Reply-To: <xmqqa8lvr7ix.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 18 Mar 2016 11:00:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 752D6E78-ED38-11E5-8C74-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289240>

It seems that people are still finding regressions in the topic for
this item in the 2.8-rc3:

 * Another try to improve the ignore mechanism that lets you say
   "this is excluded" and then later say "oh, no, this part (that is
   a subset of the previous part) is not excluded".  This has still
   a known limitation, though.

Known limitations in a new feature are somewhat OK, but I am getting
an impression that this is not nearly complete yet and it needs more
time to be tested before it inflicts pain to the general public.

I've reverted the offending changes from 'master' and will be
tagging an extra -rc (2.8-rc4) early next week, as reverting a topic
this late in the cycle is something I feel uncomfortable with.

Thanks.
