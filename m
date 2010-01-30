From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:09:54 -0800
Message-ID: <7vk4v041r1.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
 <ron1-8B7921.19261029012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5b5-000101-3d
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab0A3FKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781Ab0A3FKF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:10:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0A3FKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:10:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C196995138;
	Sat, 30 Jan 2010 00:10:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DZrbmAznl7w5NKa9+Ee4W2Vd/ZY=; b=YaUDHM
	E//GSfdk29TugcpC7A99kmJNfRl8xlFtf3MOwXIyJRJwkj+Gadzj9df+gLEemA+g
	rInoOeztE5RyHtNmpKx8/ZaomjigOV0WW3ML4cHjEl4jJuyfH+9aDI6E0Zvc+rw6
	IFR0CcEVHKGDCjv0CJV0LKfT92fquYjorOTBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdpSxmT7oQzNkhue7On5Zk/1S9DrTbnQ
	VfzgXUe5a8XkAdWoOZwimSqqzVuKvW/8VJfwFBueiX9qoqz6cfu5ZBgx1XJfkCjr
	660H2INICq8h6RuikNHYbKyvFZT7z31xFpVgsm/9KcO7brKvd9nildvOB+lqKyIt
	nU91F/ddQ/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D8F295137;
	Sat, 30 Jan 2010 00:09:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C784495133; Sat, 30 Jan
 2010 00:09:55 -0500 (EST)
In-Reply-To: <ron1-8B7921.19261029012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 19\:26\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B64E75DA-0D5D-11DF-8290-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138443>

Ron Garret <ron1@flownet.com> writes:

>> When HEAD points at a branch, making a commit advances _that_ branch.  And
>> we say you are "on that branch".  When HEAD is detached, because it is not
>> attached to anything, it advances no branch.  "detached HEAD" is detached
>> in the very real sense.  It is not attached to _any_ branch.
>
> OK.  The docs do not make that clear at all.  In fact, the following 
> statement, copied straight from the manual, flatly contradicts what you 
> just said:

There are many places in the documentation that simply predate the
introduction of detached HEAD.  The description talks as if you cannot be
in any state other than on a particular branch.  For example, "git pull"
talks about choosing where to fetch from and what to merge to the head
based on what your current branch is---obviously such a description is
ancient and doesn't talk about what should happen when you do not simply
have any "current" branch.

So it is understandable that you get confused and it is all
documentation's fault, not yours.

> "The special symbol "HEAD" can always be used to refer to the current 
> branch."
>
> Always.  Except when it can't.

Exactly.

We would need to update the documentation.  While doing so, a general
guideline would be to keep in mind that they were written back when you
had to always be on _a_ branch (and they called it "current branch",
"branch HEAD points at", etc.).  When they describe that "the current
branch is updated in such and such way", what happens in a detached HEAD
state is that only the HEAD pointer that directly points at the "currently
checked out commit" is updated, without affecting _any_ branch.
