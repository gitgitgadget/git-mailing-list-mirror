From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 15:59:14 -0700
Message-ID: <7vsjh48af1.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org>
 <7v62e09sig.fsf@alter.siamese.dyndns.org> <4F67B78B.6080208@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:59:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lXv-0004JE-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411Ab2CSW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:59:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567Ab2CSW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 18:59:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79D17C2B;
	Mon, 19 Mar 2012 18:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2QZX6djBquDUyKQfPFE553iY8t0=; b=UWOoYE
	t1dTXGNaxztAzTYj4sEWDeecMPr43EKf9zvmLgOAv9zn+OBrstDKQtSWinQI8xrq
	H64EpOIp7mDb/Taz4GrHFnMweova67GhECrQyDVXPpEh8mb2+tLMV1tLdFbR/uQs
	eLC3p77Gvx+IFzyM/n1yGgO/+TIWKKQnu5bUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4qA8dpzrf313L7YLwDBW82dwV2kyvZL
	O818eyzyTbotRMUVgWYDg83rYa0199/uukJKmhciaZYtVwfjr5KEkuPs3Klb2bTN
	9eJ48yL1oJhRMz8ntVOaSqkPUV5Gng80yP6mQSu3aR7najJxERqqjW1VJPIzgsAL
	p/fXh2i6+Ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF0647C2A;
	Mon, 19 Mar 2012 18:59:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BB507C29; Mon, 19 Mar 2012
 18:59:16 -0400 (EDT)
In-Reply-To: <4F67B78B.6080208@pileofstuff.org> (Andrew Sayers's message of
 "Mon, 19 Mar 2012 22:47:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27092DC2-7217-11E1-B261-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193472>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> On 19/03/12 21:43, Junio C Hamano wrote:
>> 
>> The same response applies. These administrators are taking responsibility
>> for their users by making them out of our reach.
>
> I'm not sure I follow.  It sounds like you're saying we should avoid
> helping anyone that doesn't stick to our upgrade schedule,...

I am not saying "should avoid".  I am saying it is not much use.

All we can do is to inform, educate and help those who are taking
responsibility, be it LTS distro or these administrators, to help their
users.  I've already outlined what LTS distros could do with backporting
and reverting in the previous message.

We can make sure that the "default flip" and "stop warn" patches can be
easily cherry-picked by them, even though we cannot force them to do so.
