From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My use case
Date: Sat, 30 Jan 2010 11:07:29 -0800
Message-ID: <7vtyu3o1hq.fsf@alter.siamese.dyndns.org>
References: <ron1-09825C.00261930012010@news.gmane.org>
 <1264840729-sup-5264@ezyang> <ron1-CC0A6E.00541330012010@news.gmane.org>
 <20100130174844.GD788@thunk.org> <ron1-A58BC7.10295430012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 20:07:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbIfW-0008Rq-8D
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 20:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab0A3THh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338Ab0A3THg
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 14:07:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab0A3THf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 14:07:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5555F95CFC;
	Sat, 30 Jan 2010 14:07:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3efR3VkfDUAMwf24HSGfB0Zt1T8=; b=maEKJlG9EToBFtYWByuA9ye
	/AjbR80/VB3LQw9HKYhxgiPWn2gJQIi+Zhv62yzxV+dAPYgQplD/Km9ltJVp+ewb
	ol2DWsKh2Uj0M5ovaYpLVlDZLjcF7Al5N1NW3Q+ap2CG01xDKW2oE2UMt7Ogc6Lp
	5lxW2QtvAxc+ZVvbH+Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Oxl6+LdluHhAA57AsjupCeaMuFdaKWFG/s/xdSBnY+mwKOrif
	RwLn/EVcyD7qVFAJu9q2U5RrX0LX8P5d0Rnp9jicZHS+IdpdZySlEFuGZS7eVCyS
	9RHK6o6VjgHOyejQMJXifMXvmyXI5Qn4Ced9PbFWn1QlMZyTn3wtHDUB5s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E0B95CFB;
	Sat, 30 Jan 2010 14:07:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87F2695CF5; Sat, 30 Jan
 2010 14:07:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B855587E-0DD2-11DF-9765-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138494>

Ron Garret <ron1@flownet.com> writes:

> You are absolutely right.  That is another reason why having the 
> individual files tracked separately from the main project would be a 
> good thing if I can get it to work.  (It would be kind of like having a 
> git-stash on a per-file basis.)

When you have more than one functions defined in a file, and the
interactive Lisp development cycle works primarily on s-exp basis, not
necessarily constrained by file boundaries, don't you want even finer
grained control than "stash per-file"?

I don't think of a good solution myself, but I find your "finer than whole
tree" an interesting topic.
