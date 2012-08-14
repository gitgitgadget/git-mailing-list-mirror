From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 13:49:58 -0700
Message-ID: <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1O46-0003rJ-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481Ab2HNUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:50:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756958Ab2HNUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:50:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C8D865D;
	Tue, 14 Aug 2012 16:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Z64Y+SVOqBq/siU75+HwTNpbH0=; b=AXZ+Xf
	ykkzQJ8kPeeESlDaHQuUHmibx9ItyiFeoJYCX87R1OzRfImX/CKmLJTPLj9Phgn7
	2vkNxmx2ohMHAZL8bKwCIml0bhZWUzPddddb+aBO8ouKxlOBKiOwdM5866AFdCg+
	U4Hr5+2cY9P0OLR9PMCm92ivAyFqJlsCjVeHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHyh5Odk3/b3QQVAqihoT8mWy2gDmabp
	n+wUtDIV3nXpuxVNkJD1kPfoyl5P1iqmvNZye2VgCpxrCZpyQ5ngDWzSh5KlzxbI
	n9M4hAUQ49INyYvgcUBHl5gJmUSQE3zJjiKuPK1dshCoyyXpNFzk8IVdsgf0j26h
	bo8meJZnBQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DC7865B;
	Tue, 14 Aug 2012 16:50:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60A7E8657; Tue, 14 Aug 2012
 16:50:00 -0400 (EDT)
In-Reply-To: <87lihh8c7s.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 14 Aug 2012 22:12:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D534AB8-E651-11E1-96CC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203450>

Thomas Rast <trast@student.ethz.ch> writes:

> In some sense this is a really bad case of wrong UI design, because we
> (this happens on #git a lot) have to teach users not to use the command
> so they won't trip over this problem.  It would be better to fix the
> real issue instead.  IIRC it was even on the 1.8.0 wishlist...

Is it?

There already is a way to ask it to update the single tracking
branch while fetching; "git fetch origin master" that
unconditionally updates refs/remotes/origin/master without a way to
tell it not to do so will be a grave usability regression.
