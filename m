From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: What's cooking in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 02:01:28 -0500
Organization: Exigence
Message-ID: <20081015020128.a5d2c83b.stephen@exigencecorp.com>
References: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0P5-0005nF-2x
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYJOHBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbYJOHBb
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:01:31 -0400
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:54127 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYJOHBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:01:31 -0400
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id E3FD6268325;
	Wed, 15 Oct 2008 03:01:30 -0400 (EDT)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 6FBF6268322;
	Wed, 15 Oct 2008 03:01:30 -0400 (EDT)
In-Reply-To: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98241>


> * sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
>  . rebase--interactive: fix parent rewriting for dropped commits
> 
> Tentatively dropped from everwhere, waiting for a reroll together with
> sh/rebase-i-p.

Assuming sh/maint-rebase3 goes before sh/rebase-i-p, there are no
changes to it. I rebased it on top of sp/maint and the tests passed.

> * sh/rebase-i-p (Wed Oct 8 01:41:57 2008 -0500) 7 commits
>  - rebase-i-p: if todo was reordered use HEAD as the rewritten parent
>  - rebase-i-p: do not include non-first-parent commits touching
>    UPSTREAM
>  - rebase-i-p: only list commits that require rewriting in todo
>  - rebase-i-p: fix 'no squashing merges' tripping up non-merges
>  - rebase-i-p: delay saving current-commit to REWRITTEN if squashing
>  - rebase-i-p: use HEAD for updating the ref instead of mapping
>    OLDHEAD
>  - rebase-i-p: test to exclude commits from todo based on its parents
> 
> Changes the `rebase -i -p` behavior to behave like git sequencer's
> rewrite of `rebase -i` would behave.

Attempting to follow your previous advice, I merged sp/master onto my
local sh/maint-rebase3, and rebased sh/rebase-i-p on top that resulting
merge, and got the changes fixed to play nicely with sh/maint-rebase3
+master, and integrated your feedback.

I'll be sending the new sh/rebase-i-p series soon.

Let me know if I did the wrong thing--your comment of maint-rebase3
"waiting for a reroll" makes me think you wanted that one rebased on
top of rebase-i-p, when I just got done doing the opposite (I hadn't
checked the git list before hacking on it).

Thanks,
Stephen
