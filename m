From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn error "Unable to extract revision information from commit ...~1"
Date: Tue, 26 Jun 2007 19:20:27 -0700
Message-ID: <7vfy4ervdg.fsf@assigned-by-dhcp.pobox.com>
References: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>
	<4681C27B.8040009@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Bogado da Silva Lins <victor@bogado.net>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N90-0001ld-Go
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbXF0CUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbXF0CUd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:20:33 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36808 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbXF0CUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:20:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627022028.JRUM17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:20:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSLU1X0011kojtg0000000; Tue, 26 Jun 2007 22:20:28 -0400
In-Reply-To: <4681C27B.8040009@midwinter.com> (Steven Grimm's message of "Tue,
	26 Jun 2007 18:50:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51013>

Steven Grimm <koreth@midwinter.com> writes:

> Victor Bogado da Silva Lins wrote:
>> The problem seem to be that when I merge the head with another branch
>> git-svn does not know where to follow to meet the "svn trunk".
>
> The current release of git-svn doesn't support committing merges. It
> has no clue how to walk nonlinear history, as you point out. The
> current practice is to do "git merge --squash" when merging into the
> git-svn branch that you want to use as the basis for your svn
> commit. The --squash option will make git merge the contents of the
> other branch(es) but record the resulting tree as a regular commit,
> not as a merge.
>
> There is a work-in-progress patch which might help you if you need to
> preserve merge ancestry on the git side. Search the mailing list
> archives for "[PATCH] git-svn: allow dcommit to retain local merge
> information" if you want to try it (but be aware that it is just an
> initial implementation and may have bugs; it was posted so people
> could try it out and report back any problems to the author.)

... which has been cooking in 'next' for the past two weeks.
