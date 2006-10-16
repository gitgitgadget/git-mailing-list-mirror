From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:24:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160920250.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:25:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVHE-0003Pu-W1
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743AbWJPQZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWJPQZH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:25:07 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:16099 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422736AbWJPQZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 12:25:05 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5273> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 09:25:02 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28966>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> 
> Davide? I'm quoting the whole report, because I suspect you don't follow 
> the git lists, and this is all original libxdiff code.
> 
> Jim: the annotation failure _may_ just be due to a "valid" diff change 
> (there is not always a unique correct answer for a diff, and so two 
> different diff algorithms can validly give two different answers, which 
> will also mean that git-annotate/blame would give different explanations). 
> 
> But it could certainly also be that you just broke the diffs entirely, so 
> I would like to wait for Davide to comment on your diff before Junio 
> should apply it. 
> 
> Others may be intimately familiar with the diff algorithms too, of course. 
> It just scares me personally ;)

The test is fine as is. Only really bad hash collisions can show O(M*N). 
Can I have the two sample files to test?



- Davide
