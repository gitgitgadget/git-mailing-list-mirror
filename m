From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 11:34:02 -0700
Message-ID: <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
	<7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
	<1190654052.6078.14.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZsl6-0003Ke-Se
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 20:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXIXSeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXIXSeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 14:34:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbXIXSeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 14:34:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7893813B25D;
	Mon, 24 Sep 2007 14:34:26 -0400 (EDT)
In-Reply-To: <1190654052.6078.14.camel@beauty> (Josh England's message of
	"Mon, 24 Sep 2007 11:14:12 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59069>

"Josh England" <jjengla@sandia.gov> writes:

>> What's the _semantics_ you are trying to achieve?
>
> I'd like to get a hook that runs whenever the working dir gets
> updated.  The 'git-checkout otherbranch path.c' case should
> run it also, so I view that as a bug.

I think that _is_ INSANE.  Do you run the hook for these then?

	$ edit path.c
        $ git-cat-file otherbranch:path.c >path.c

Why "git checkout otherbranch path.c" should be any different?
