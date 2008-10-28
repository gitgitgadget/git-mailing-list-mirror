From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add mksnpath and git_snpath which allow to specify the
	output buffer
Date: Tue, 28 Oct 2008 18:31:32 +0100
Message-ID: <20081028173132.GB7054@blimp.localdomain>
References: <20081026215913.GA18594@blimp.localdomain> <7v8wsak4mr.fsf@gitster.siamese.dyndns.org> <20081027064537.GA4751@blimp.localdomain> <7vd4hlgzo7.fsf@gitster.siamese.dyndns.org> <81b0412b0810280547nf5e6834t4049e92d374926b6@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:33:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KusRa-0004YP-27
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYJ1Rbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYJ1Rbg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:31:36 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:24081 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbYJ1Rbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 13:31:35 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A082pEts
Received: from tigra.home (Facd6.f.strato-dslnet.de [195.4.172.214])
	by post.webmailer.de (fruni mo27) (RZmta 17.14)
	with ESMTP id k00248k9SHF1L4 ; Tue, 28 Oct 2008 18:31:32 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 6D5E8277C8;
	Tue, 28 Oct 2008 18:31:32 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 47FB136D27; Tue, 28 Oct 2008 18:31:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <81b0412b0810280547nf5e6834t4049e92d374926b6@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99308>

Alex Riesen, Tue, Oct 28, 2008 13:47:21 +0100:
> 2008/10/28 Junio C Hamano <gitster@pobox.com>:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> >> Maybe I should resend the patches without it, following by patches
> >> introducing git_snpath and replacing calls to git_path.
> >
> > I took the liberty of doing the first half of just that ;-)
> >
> 
> Thanks. And am sorry... I did that too, and stupidly forgot to send.
> I also considered replacing xstrdup(mkpath) with a function which does
> just that (patches 8-9). Patches 1 and 2 are unrelated, will send them
> separately.
> 
> FWIW now, I'm sending the patches.

Err... The builtin-revert.c hunk of path 0009 depends on the patch I
sent later: "Plug a memleak in builtin-revert". The patch removed const
in front of "char *defmsg".
