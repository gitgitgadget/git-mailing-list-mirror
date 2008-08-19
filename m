From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:11:33 +0200
Message-ID: <vpqk5edid2y.fsf@bauges.imag.fr>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	<alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	<7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	<905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	<48AA7BE9.4040108@sneakemail.com>
	<7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
	<ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"" Peter Valdemar =?iso-8859-1?Q?M=F8rch?= (Lists) "" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Alexander E Genaud" <alex@genaud.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 11:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVNYX-0004Tq-8z
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 11:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYHSJaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYHSJaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 05:30:09 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56086 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbYHSJaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 05:30:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7J9IPZM020575;
	Tue, 19 Aug 2008 11:18:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KVNFV-0006AC-OI; Tue, 19 Aug 2008 11:11:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KVNFV-0003rG-Lr; Tue, 19 Aug 2008 11:11:33 +0200
In-Reply-To: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com> (Alexander E. Genaud's message of "Tue\, 19 Aug 2008 10\:57\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 19 Aug 2008 11:18:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92842>

"Alexander E Genaud" <alex@genaud.net> writes:

> There is no indication in the documentation distinguishing porcelain
> from plumbing.

Well, there is somehow one: "git" and "git help" show just the
porcelain. Still, I agree with you: marking plumbing as such more
explicitely could help newbies not to bother with it. For example,
"man git-update-index" could say right after the synopsys something
like "This command is meant for scripting purpose. See git-add and
git-rm for a user-friendly interface".

> Git-add adds to the index but does not create, however git-rm
> removes from the index and does delete (an --index-only or --keep
> flag might be nice).

git rm actually had a documented --cached flag now, and git rm
gives an error message pointing to it in the case where it would lose
data and --force is not provided.

> A single term for cache and index should be decided upon.

+1 on this.

I find "staging area" the most explicit wording for users, but I say
that as a non-native english speaker.

Unfortunately, it's not only a matter of documentation. Renaming "git
diff --cached" to "git diff --staged" would cause backward
compatibility problems for example.

-- 
Matthieu
