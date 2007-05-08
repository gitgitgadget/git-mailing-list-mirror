From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Mon, 07 May 2007 18:42:49 -0700
Message-ID: <7vr6ps5bvq.fsf@assigned-by-dhcp.cox.net>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
	<20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
	<20070505034615.GE16538@spearce.org>
	<7vps5efnv8.fsf@assigned-by-dhcp.cox.net>
	<20070508013532.GA11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 03:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEjH-00040s-Jl
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934597AbXEHBmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934600AbXEHBmv
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:42:51 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55348 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934597AbXEHBmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:42:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508014249.SDRA13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 21:42:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wRio1W00Z1kojtg0000000; Mon, 07 May 2007 21:42:49 -0400
In-Reply-To: <20070508013532.GA11311@spearce.org> (Shawn O. Pearce's message
	of "Mon, 7 May 2007 21:35:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46509>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Gerrit's patch to try and use COMMIT_MSG feels wrong to me, as
> git-commit overwrites that file with what it gets from its "input".

Yes.

> I agree my patch steps us further from a "git whatnow", but we're
> already in deep with MERGE_MSG.  We might as well keep that existing
> convention that it can be used to prep the commit message for the
> next git-commit invocation, and record other data somehow for the
> "git whatnow" case.

Fair enough.
