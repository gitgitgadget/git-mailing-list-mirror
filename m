From: Adam Megacz <adam@megacz.com>
Subject: edit Author/Date metadata as part of 'git commit' $EDITOR invocation?
Date: Sun, 03 Jan 2010 23:32:57 +0000
Organization: Myself
Message-ID: <xuu2fx6m4vdi.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 21:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRtPb-0008Fk-Pq
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 21:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab0ADUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218Ab0ADUUT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 15:20:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:51504 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab0ADUUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 15:20:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NRtPK-00086e-1K
	for git@vger.kernel.org; Mon, 04 Jan 2010 21:20:06 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 21:20:06 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 21:20:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:p7xLPV9yCtO4AdcsdKeuJ2GAGB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136141>


Hi, folks.

>From the output of 'git show', it appears that a commit has a few fields
of metadata associated with it in addition to the comment.  These fields
seem to include Author, AuthorDate, Committer, and CommitDate.

  1. Are there other fields aside from these four?

  2. When I invoke 'git commit' without the '-m' argument I'm dropped
     into the cozy $EDITOR of my choice and given the opportunity to
     edit the commit message.  Is there any way to include the metadata
     fields in this editing session?  That way I could both sanity-check
     them as I perform the commit (important) and modify them if they're
     wrong (less important).

     I've been having problems lately with running git on machines where
     I forgot to set up my .gitconfig; I wind up with patches that have
     committers like root@mymachine and so forth.  Being automatically
     shown the committer/author when I make the commit would help me
     avoid these situations.

Thanks,

  - a
