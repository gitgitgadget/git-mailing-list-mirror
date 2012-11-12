From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 1/1] Wire html for all files in ./technical and ./howto
 in Makefile
Date: Mon, 12 Nov 2012 09:45:31 -0800
Message-ID: <7vpq3iiukk.fsf@alter.siamese.dyndns.org>
References: <20121025094205.GI8390@sigill.intra.peff.net>
 <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
 <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
 <884264929.71955.1351535627736.JavaMail.ngmail@webmail09.arcor-online.net>
 <20121029215739.GG20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy4x-0006Oc-RI
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab2KLRpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:45:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:45:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03709610;
	Mon, 12 Nov 2012 12:45:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nGfaTxbonzCVxzZRYs8plFKcRfY=; b=Hfe3ToOyPK03TApxhj2v
	H4V6nYB2d2Z6cdbAPwCYJ4feXHCQcp/hCPFoMYTg/1giXMNYuigEiv26snZ1t6Ci
	NHp7LSBggwDlYgv8Sc7JGbNMTyRdaV6l1zuFBPwXpyzgbBHqb9UB9a0BhuKBddDe
	MonLcxeJ8fE6bzXHBZwbNSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OkkAjv1w2qqkwcC0HjbFbhTN/heiaAbe8vPd10IAF8oHIi
	pT+fR/LxzkNjn2WeFHSzBmYRzaHNJ2NlU0u51P0WeNBsWd9HMeOmlIAnXHRnFSoW
	Tvj4z7cGS8Vk4yw0R8G55U6shLWdB/RLvvEUwelWQiLb2DL5mt7QvRQ6yrwzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE45D960E;
	Mon, 12 Nov 2012 12:45:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0A8960C; Mon, 12 Nov 2012
 12:45:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1E456B6-2CF0-11E2-9F23-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209502>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 29, 2012 at 07:33:47PM +0100, Thomas Ackermann wrote:
>
>> This patch addresses Junios comment in WC:
>> "Misapplication of a patch fixed; the ones near the tip needs to
>>  update the links to point at the html files, though."
>> 
>> See older mail in this thread:
>> [...]
>> That means that for the patch [6/8], which adds content-type to the
>> text files, to be complete, it needs to update Makefile to produce
>> html files from them.
>> [...]
>> So IMHO no open issues with this patch.
>
> OK, that explains the situation. Thanks, I'll merge it to master in the
> next iteration.

What happened to this topic?
