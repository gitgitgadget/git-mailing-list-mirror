From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 07:38:26 +0200
Message-ID: <20120817053826.GB22313@suse.cz>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
 <502D5D97.3020906@kdbg.org>
 <7v4no21raw.fsf@alter.siamese.dyndns.org>
 <7vzk5uzgqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 07:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2FGa-0001mR-1E
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 07:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab2HQFie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 01:38:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38060 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab2HQFid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 01:38:33 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BE912A398E;
	Fri, 17 Aug 2012 07:38:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzk5uzgqa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2012 at 02:09:33PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> The reason I do not think "pull -r" gives much value to the users to
> trigger "pull --rebase" is because the use of "pull --rebase" is
> very project specific.  If you are working on a project that forbids
> merges, you would _always_ want to run "pull --rebase", which means
> you would likely have it configured and would not be typing from the
> command line.

I agree that it's a bit strange, but based on a quick search, it seems
multiple projects already advertise git pull -r (i.e. not --rebase and
not a configuration option):

http://lilypond.org/doc/v2.15/Documentation/contributor/pulling-and-rebasing
http://wiki.documentfoundation.org/Git_For_LibreOffice_Developers
http://www.wiremod.com/forum/wiremod-general-chat/29517-git-introduction-incomplete-unformatted.html

So it seems making -r refer to --recurse-submodules would already cause
quite some pain to users.
