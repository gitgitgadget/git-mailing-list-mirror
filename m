From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Wed, 12 Nov 2008 22:14:15 -0800
Message-ID: <7vhc6ci24o.fsf@gitster.siamese.dyndns.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
 <20081108142756.GC17100@coredump.intra.peff.net>
 <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
 <20081109014926.GA31276@coredump.intra.peff.net>
 <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
 <20081112084412.GA3860@coredump.intra.peff.net>
 <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com>
 <20081113053735.GA5343@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <kyle@moffetthome.net>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 07:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0VUj-0002ve-Ce
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 07:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYKMGOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 01:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbYKMGOl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 01:14:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYKMGOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 01:14:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C2AFC7BB3F;
	Thu, 13 Nov 2008 01:14:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8B7E67BB3E; Thu,
 13 Nov 2008 01:14:22 -0500 (EST)
In-Reply-To: <20081113053735.GA5343@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 13 Nov 2008 00:37:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A1298E8-B14A-11DD-9F7B-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100855>

Jeff King <peff@peff.net> writes:

> And then the "push to current branch" problem is neatly solved: you have
> no current branch.
>
> So:
>
>   $ git checkout new/branch/to/test^0
>   $ make, configure, etc

Exactly.

I keep a handful pseudo worktrees around (created with git-new-workdir on
top of a single repository) for quick patch test and build purposes.  I do
not push into them but pushing into a non-bare repository and checking out
the same branch twice in such a setup share exactly the same issue, and I
keep their HEADs all detached for exactly the same reason.
