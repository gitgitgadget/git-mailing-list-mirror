From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 14:57:52 -0800
Message-ID: <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
 <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
 <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu>
 <498231EA.3030801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfr5-0008JD-Ba
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZA2W6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZA2W6D
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:58:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbZA2W6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:58:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5F722A093;
	Thu, 29 Jan 2009 17:57:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E961E2A096; Thu,
 29 Jan 2009 17:57:53 -0500 (EST)
In-Reply-To: <498231EA.3030801@zytor.com> (H. Peter Anvin's message of "Thu,
 29 Jan 2009 14:47:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45D85EB2-EE58-11DD-9C3A-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107748>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Ingo Molnar wrote:
>>
>> So the repo itself is fine, correct?
>>
>
> Looks like it.

Correct.  It looks like "fsck" without --full is misreporting, which is
something we should find a fix on our end.

I am not sure how old this bug is (nor if I can make Linus admit it is
even a bug---I suspect the code that is involved in this did not change
that much over time).
