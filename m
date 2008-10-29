From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: Some updates to refspec documentation
Date: Wed, 29 Oct 2008 21:41:13 +0100
Message-ID: <878ws7b0d2.fsf@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:42:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHs5-00037Q-Eq
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYJ2UlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYJ2UlQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:41:16 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:38925 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbYJ2UlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:41:15 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 72A7014062
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 21:41:16 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4C80F1405A
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 21:41:16 +0100 (CET)
In-Reply-To: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk> (Anders Melchiorsen's message of "Wed\, 29 Oct 2008 21\:25\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99413>

During my struggle, I also found a git push usability problem. The
refspec ":dst" will delete the remote branch without warning.

While this is indeed documented, you cannot blame somebody for
thinking that a left out <src> will default to HEAD, as it does for so
many other commands.

In a CVS-like setup, with everybody pushing to master, this could
cause havoc.

As the "git push <repository> :<dst>" operation is destructive, I
think it should be protected by the -f option.

For the record, I did realize this before trying to push ":master" :-).



Anders.
