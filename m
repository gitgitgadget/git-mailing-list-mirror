From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 02 Oct 2007 12:15:42 -0700
Message-ID: <7vbqbhl44h.fsf@gitster.siamese.dyndns.org>
References: <47029414.3080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnDn-0003dd-Au
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbXJBTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbXJBTPs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:15:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:53760 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbXJBTPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:15:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id AF3CC140601;
	Tue,  2 Oct 2007 15:16:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A4B6140587;
	Tue,  2 Oct 2007 15:16:05 -0400 (EDT)
In-Reply-To: <47029414.3080100@gmail.com> (Dan Zwell's message of "Tue, 02 Oct
	2007 13:55:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59714>

Dan Zwell <dzwell@gmail.com> writes:

> ... It is the same after I commit the new changes--at that point,
> "git-diff-tree HEAD^ HEAD -p" spits out a nice patch, but "git-diff
> HEAD^ HEAD" gives nothing.

This part is most interesting.  They are both about comparing
two commits and do not interact with anything in the work tree
nor your index.

> I have tried git versions 1.5.1.6-1.5.3.3, and they all act the same,

Do you mean 1.5.1.5 was Ok?  Can you bisect it?

> so I think the repository is corrupt. Does sound familiar to anybody?

Not to me; and I do not think repository is corrupt from the two
"HEAD^ vs HEAD" diff.  There is something entirely different
going on.

> ... I can
> restore from a recent backup and redo some changes, but I would like
> to help troubleshoot this behavior if it is a git bug.

Thanks.
