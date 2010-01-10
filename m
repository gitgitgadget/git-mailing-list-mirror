From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging with dirty trees
Date: Sun, 10 Jan 2010 13:16:47 +0100
Message-ID: <201001101316.49164.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch> <20100110044949.GA8974@progeny.tock> <7vskaefp2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwj1-0000DG-Pp
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab0AJMQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309Ab0AJMQv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:16:51 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:7844 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0AJMQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:16:51 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:16:49 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:16:49 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <7vskaefp2v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136573>

Junio C Hamano wrote:
> >> while possible, it leaves you in a state that is hard to
> >> +back out of in the case of a conflict.
> >> +
> >
> > Oh, that is a problem.  Maybe 'git merge' should refuse to merge
> > unless told otherwise, if there is a dirty index and there might be
> > conflicts.

Actually I'm worried about a dirty *worktree*.  Do you think that
should be clarified?

> "git reset --merge" will keep your local changes after such a merge, and
> "mergy" operations (not just "merge" but also "revert", "am -3", etc)
> won't get you into a situation where you cannot, by refusing to do
> anything when e.g. your index is dirty.  Especially when Christian's
> "reset --merge" update becomes solid, "... is hard to back out of" will
> become a false statement.

Does that apply to dirty worktrees, too?  I admit I didn't follow that
topic at all.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
