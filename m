From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 16:26:36 -0800
Message-ID: <7vaavso537.fsf@alter.siamese.dyndns.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
 <7vwrywplxz.fsf@alter.siamese.dyndns.org>
 <ron1-ABA66E.15563101022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6bf-0002pD-8X
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab0BBA05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:26:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab0BBA04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:26:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8055796764;
	Mon,  1 Feb 2010 19:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5u2HEgUQtAdw2YPsRwiXCrJ8pmM=; b=tu94Sz
	9rgG78W6hzSHjoZ476LrbrZ4YeP1JDFigcgAONKgzZPh543A5m475QP3HEWQk/Xg
	zLjvAt16Cf7zThLlCSRMY4VXqxM6lRzLoXAIsYocXc3bZQGRJSqlpnl0V3KAYsam
	vdXer/FThWnxXWdbqOF65MnlSbcazwFLRgYTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+CIPqkHIqBXLVHk1qCKFtPnLnDlSuRz
	qx3Wdrujecdf26yW4+IXZEcU2Ynd4NCL8mmTbLhutR/kcFIFyO6sv8dljE32r0kw
	02EUu2bkTUKxJYFvv8D9Oo5EykzhO1eMZuAHcZ3BFpQ2UMzO2ZyiWdfP+6pZZ91b
	AG2rn8MzRIk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3B496761;
	Mon,  1 Feb 2010 19:26:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EE019675E; Mon,  1 Feb
 2010 19:26:42 -0500 (EST)
In-Reply-To: <ron1-ABA66E.15563101022010@news.gmane.org> (Ron Garret's
 message of "Mon\, 01 Feb 2010 15\:56\:31 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA240FDC-0F91-11DF-92BB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138664>

Ron Garret <ron1@flownet.com> writes:

>> This shows that you are still thinking a branch is a line (or multiple
>> lines).  It is not.
>
> The git user's guide says it is:
>
> "When we need to be precise, we will use the word "branch" to mean a 
> line of development..."

I think the last paragraph "to put it in another way" in my other message
to you will clear this confusion.
