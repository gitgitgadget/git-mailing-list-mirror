From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Super long branch names corrupt `.git/config`
Date: Thu, 04 Oct 2012 12:28:39 -0700
Message-ID: <7v391uyr2w.fsf@alter.siamese.dyndns.org>
References: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: Ben Olive <sionide21@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgQ-00033L-Na
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab2JDT2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:28:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab2JDT2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:28:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF149F92;
	Thu,  4 Oct 2012 15:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8z/Cn9f+mzeafdTi00WAyy0h9c=; b=gMj8i8
	w2OJLVC84gQhHgvEgG0XqxWD9FlAXVu+C04AJEdfoGUX3kAZBQSfNJ/+bMYO6FE8
	tKPTINwBqaIbr9DgKSEo++FIiZwRMSYWaNWN9WY7JnYGTqJmv96aFMFSAiwHSY+q
	BPVrQHGhNzkIGj7Qc/jMri6j4c2rXBARX+F50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MEqJlK5j+x5rX6ziE2fXIWHy/Ys7neoA
	7HdF/7hwIQh7RqI3rZ+h1gCBEDJq4BFExQS+PmtAHkvcJ3h/iAp6rp4g6AO+wM5Z
	mje13s9Nt/MaSmrboB/cHl8jp4j/Fqm+0eE0uAMSAEfkfjl1dVuUN/BosdmRMIKV
	5v7lcE2wUuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4859F91;
	Thu,  4 Oct 2012 15:28:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 986409F90; Thu,  4 Oct 2012
 15:28:40 -0400 (EDT)
In-Reply-To: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com> (Ben
 Olive's message of "Thu, 4 Oct 2012 13:15:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3D25BAA-0E59-11E2-8C24-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207018>

Ben Olive <sionide21@gmail.com> writes:

> My `.git/config` can be corrupted if I try to get a local branch with
> an extremely long name to track a remote branch.
>
> Here is a (contrived) example to reproduce the issue:

Don't do that, then ;-)

I think we have a change that is already cooking.

Ben (Walton), want to add a test for your 0971e99 (Remove the hard
coded length limit on variable names in config files, 2012-09-30)
before it hits 'next', perhaps?
