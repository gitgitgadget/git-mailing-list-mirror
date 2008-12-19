From: Alan <alan@clueserver.org>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Fri, 19 Dec 2008 10:07:38 -0800
Message-ID: <1229710058.5569.1.camel@rotwang.fnordora.org>
References: <200812182039.15169.bss@iguanasuicide.net>
	 <alpine.DEB.1.00.0812190353520.14632@racer>
	 <7vej04eui5.fsf@gitster.siamese.dyndns.org>
	 <200812182129.01021.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 19:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDjmg-0000oe-CB
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 19:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbYLSSHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 13:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYLSSHw
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 13:07:52 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:47066 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbYLSSHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 13:07:51 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id E8FEFF501C8;
	Fri, 19 Dec 2008 10:07:42 -0800 (PST)
In-Reply-To: <200812182129.01021.bss@iguanasuicide.net>
X-Mailer: Evolution 2.24.2 (2.24.2-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103573>

On Thu, 2008-12-18 at 21:29 -0600, Boyd Stephen Smith Jr. wrote:
> On Thursday 2008 December 18 21:03:46 Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 			warning("revert on a merge commit may not do what you "
> > > 				"expect.");
> >
> > [T]he new warning does
> > not give you enough clue where to go next, so this warning does not give
> > real value.  It is pretty much meaningless noise to users.
> 
> At least, it might make someone read the manpage again.  Still, I'm unhappy 
> with the message, but I didn't want to be too wordy.  A URL or manpage 
> reference would be nice, but I didn't know of a good guide that explained the 
> dangers of reverting a merge commit as well as Linus's emails.

That would be OK if the man page actually explained how this is supposed
to work.  it does not.  (Especially where it concerns "parent number"
and reverts of merges, which has no real explanation.)
