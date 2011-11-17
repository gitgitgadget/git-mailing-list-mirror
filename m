From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone --reference not working
Date: Wed, 16 Nov 2011 21:55:12 -0800
Message-ID: <7vr517nvi7.fsf@alter.siamese.dyndns.org>
References: <20111116234314.GF3306@redhat.com>
 <7vobwbpnzr.fsf@alter.siamese.dyndns.org> <4EC4926D.5050004@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrea Arcangeli <aarcange@redhat.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 17 06:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQuzM-0006yo-8H
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 06:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab1KQFzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 00:55:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab1KQFzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 00:55:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFFD133FE;
	Thu, 17 Nov 2011 00:55:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGchWozdAkEu9nmspGgbAvDlMng=; b=s6HSqn
	W1Dj4mlFNmbUcbqBu8MiKYYG/9Zj25xXPdgokbzKl/rcHZg0Dubt504/06HDN865
	weyYz0kyvxgm5Ok0I774JOCTNL3pjsRPK2bXHt0MC9uDlwTybr3VmodP3bg1GnuB
	ukT6edDu5I9elG51grprDplwOM1ojIpXdkdxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JyHyHe+tEH8mLVh8AVDcu7ZjBOWIs1rj
	6FnPaNdTZZRlHK2R6CLakdOMEM/y1sI22SbGNj+IC+sQaYcuX7Ps+l8pzTl2YIKJ
	a6CJv3x6XJ2rllpRVBXHBxm8INS5ghIedMmUn6bZKTZKjbe/MOfMrUl5FEQJjJZN
	Asap1Tk/Hpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C767233FD;
	Thu, 17 Nov 2011 00:55:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5680F33FC; Thu, 17 Nov 2011
 00:55:14 -0500 (EST)
In-Reply-To: <4EC4926D.5050004@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 17 Nov 2011 05:49:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8017E76-10E0-11E1-9443-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185572>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/17/2011 01:54 AM, Junio C Hamano wrote:
> ...
> Looks good.
>
>>From SubmittingPatches it looks like I should authorize
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> Is there a standard way to do so?

That's perfect. I asked for an extra set of eyeballs from somebody who is
familiar with the codepath that had a problem, and that person eyeballed
and found the change to be an appropriate fix to the problem.

Either Acked-by or Reviewed-by is fine by me.

As a tentative measure, for tonight's pushout, I am inclined to queue an
equivalent of this patch on top of both mh/ref-api-2 and mh/ref-api-3
topic and merge them to 'next' and 'pu'. I'd appreciate if you can double
check the two merges on master..pu after I push them out in a few hours.

Thanks.
