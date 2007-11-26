From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 09:26:20 -0800
Message-ID: <7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:26:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhjN-0005Hg-LK
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbXKZR0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757079AbXKZR03
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 12:26:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45485 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbXKZR03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 12:26:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 049DB2FA;
	Mon, 26 Nov 2007 12:26:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7297F99C2E;
	Mon, 26 Nov 2007 12:26:44 -0500 (EST)
In-Reply-To: <474AC136.8060906@viscovery.net> (Johannes Sixt's message of
	"Mon, 26 Nov 2007 13:51:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66087>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Introduce an environment variable _GIT_CHERRY_PICK_HELP (note the
> leading underscore), which git-rebase sets; if it's set,
> git-cherry-pick uses that text instead of the usual one.

With precedences like GIT_REFLOG_ACTION and GITHEAD_${objectname}, I
think it would be consistent without the leading underscore.

I would not object to renaming all of them to have the leading
underscore, though.  That would make it clear that they are very
different from ordinary environment variables for the user to set
(e.g. GIT_INDEX_FILE, GIT_AUTHOR_NAME).  Does any third party tool like
qgit already use GITHEAD_${objectname} and/or GIT_REFLOG_ACTION?
