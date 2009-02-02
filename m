From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Extend mailmap functionality
Date: Sun, 01 Feb 2009 19:03:26 -0800
Message-ID: <7vpri1o801.fsf@gitster.siamese.dyndns.org>
References: <cover.1233520945.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 04:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTp7K-0007Cv-18
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZBBDDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbZBBDDc
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:03:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbZBBDDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:03:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F14982A42E;
	Sun,  1 Feb 2009 22:03:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C9B12A41F; Sun, 
 1 Feb 2009 22:03:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 122F8FE2-F0D6-11DD-AC39-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108036>

Marius Storm-Olsen <marius@trolltech.com> writes:

> 2) Lets you replace both name and email of an author/committer, based
> on a name and/or email. So, should you have done commits with faulty
> address, or if an old email simply isn't valid anymore, you can add
> a mapping for that to replace it. So, the old style mapping is
>     Proper Name <commit@email.xx>
>
> while this patch series adds support for
>     Proper Name <proper@email.xx> <commit@email.xx>
>     Proper Name <proper@email.xx> Commit Name <commit@email.xx>
>
> This extended mapping is necessary when a company wants to have their
> repositories open to the public, but needs to protect the identities
> of the developers. It enables you to only show nicks and standardized
> emails, like 'Dev123 <bugs@company.xx>' in the public repo, but by
> using an private mailmap file, map the name back to
> 'John Doe <john.doe@company.xx>' inside the company.

I do not find the "necessary" argument very convincing nor I find the
particular use case sane.  You may want to do things that way, but I do
not know if it is the best way to go about it.

The new mapping however brings in more flexibility, and there may be other
use cases where people benefit from that flexibility.  I am slightly in
favor than neutral to this new feature.
