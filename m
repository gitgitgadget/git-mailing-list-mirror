From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 12:20:21 -0800
Message-ID: <7vpr76uzju.fsf@alter.siamese.dyndns.org>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
 <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
 <20091125080812.6117@nanako3.lavabit.com>
 <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
 <7v7htexuxc.fsf@alter.siamese.dyndns.org>
 <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOLx-0000fH-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934998AbZKYUU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934997AbZKYUU3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:20:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934993AbZKYUU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:20:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E40AA1518;
	Wed, 25 Nov 2009 15:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvipN1eV9XRzLpqfVaXqjgy1r6g=; b=vOGoLS
	DffWCNQ6l4cJNEOMIfEkL4Kacg4VQVpmmn8kdDeZYMLSRHwlilZMJV2weJOJEjh0
	zG+zmfrk27NwPPrx6y8ftA5+7E63Xl8G0Kr+QLWeRk4/5SthEIOJphN9eMZLDlrt
	Jm5MVbfacR9BdVZOR73lVN3Bx71c8+W1ZBsjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djfCt+ayF6TA+ygRg58TmLAPbpYx0RbT
	YRG7AxWEv6DzHBZlMLHEK0bnYJm4lXK5v6PRVXXuuPJZa04nHa1JgUIp5+4UAom4
	vaJT9WFu1s9vJ4eJhJwfGljtEJ8q3I1gx4sawZwxMHLn+vu/TLOsfDHJfv1ogzBr
	/cffynPdGk4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E4DFA1517;
	Wed, 25 Nov 2009 15:20:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E49FA1510; Wed, 25 Nov 2009
 15:20:22 -0500 (EST)
In-Reply-To: <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com>
 (Avery Pennarun's message of "Wed\, 25 Nov 2009 14\:48\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9612728-D9FF-11DE-AEAC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133667>

Avery Pennarun <apenwarr@gmail.com> writes:

>> Look at http://github.com/gitster/git/commits/jc/merge-theirs/
>
> I also tried simply searching for things like 'git "-xsubtree"' in
> google, with no luck.  But thanks for the link.

I didn't _find_ the link ;-)  I just pushed it out a few minutes ago,
after looking for strings that appear in messages of these commits.  The
series was done over a few weeks, and would have been very painful to find
from the gmane archive.

> - What was the reason this never got merged?  What changes are needed
> to rectify that?

I do not remember there was any real reason.  I do remember some people
didn't like -X<option> syntax but I don't think there was any solid
counterproposal to achieve a similar goal to satisfy the need to pass
arbitrary parameters to the merge strategy backends.

> - Considering the earlier discussion, do we want to leave out the
> actual -Xtheirs feature and just have -Xours and -Xsubtree?

Both -Xtheirs and -Xours have the same degree of badness in the context of
"source code management", but there was a real-world use case that would
have benefitted from -Xours recently.

  cf. http://thread.gmane.org/gmane.comp.version-control.git/131902/focus=132920

If -Xours goes in, so should -Xtheirs, I think, because Peter's "web tree"
example could merge in both ways (i.e. he could be pulling from web tree
into his private area and then cleaning things up before pushing the
result back).

> - If I rebase them and the changes turn out to be minimal, do they
> still need a signed-off-by Junio?

"minimal" by definition means that you ased your work on mine and I still
have the copyright to the change as a co-author together with you.  We
both need to certify that the change is made under DCO.
