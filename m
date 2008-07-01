From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 13:41:49 +0200
Message-ID: <20080701114149.GB6662@neumann>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
	<20080701101414.GG31309@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 13:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDeG1-0000tr-24
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 13:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbYGALlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 07:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYGALlw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 07:41:52 -0400
Received: from francis.fzi.de ([141.21.7.5]:16546 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752489AbYGALlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 07:41:51 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jul 2008 13:41:49 +0200
Content-Disposition: inline
In-Reply-To: <20080701101414.GG31309@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 01 Jul 2008 11:41:49.0024 (UTC) FILETIME=[72946600:01C8DB6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87027>

Hi Ingo,

On Tue, Jul 01, 2008 at 12:14:15PM +0200, Ingo Molnar wrote:
> i have a tip-curr (shortcut: 'tc') scriptlet to answer the "where I a=
m=20
> amongst 100+ branches" question:
>=20
>   earth4:~/tip> tc
>   tip/master 200a86b: Merge branch 'x86/unify-setup'
>=20
> which is just a thin wrapper around git-log:
>=20
>   earth4:~/tip> cat ~/bin/tip/tip-curr
>   #!/bin/bash
>=20
>   . ~/bin/tip/tip-lib
>=20
>   echo "tip/"$(get_current_branch)" "$(git log -1 --pretty=3Dformat:"=
%h: %s")
how about displaying the current branch in the command prompt?

>From contrib/completion/git-completion.bash:

  #    4) Consider changing your PS1 to also show the current branch:
  #        PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
  #
  #       The argument to __git_ps1 will be displayed only if you
  #       are currently in a git repository.  The %s token will be
  #       the name of the current branch.

Regards,
G=E1bor
