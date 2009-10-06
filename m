From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Tue, 06 Oct 2009 07:53:55 +0200
Message-ID: <4ACADB73.1080504@viscovery.net>
References: <4AC8F22F.5070101@gmail.com> <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com> <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de> <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com> <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com> <87ab05r5hg.fsf@dylle.kalibalik.dk> <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de> <7vbpkl8s8x.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052318230.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@spoon.kalibalik.dk>,
	=?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 08:01:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv36a-0003Aj-5n
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 08:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbZJFFyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 01:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275AbZJFFyj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 01:54:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55998 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231AbZJFFyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 01:54:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mv2zk-0006Nz-40; Tue, 06 Oct 2009 07:53:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C4E4D4E4; Tue,  6 Oct 2009 07:53:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0910052318230.4985@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129606>

Johannes Schindelin schrieb:
> Are you serious?  "rebase -i" was _always_ about showing an edit script, 
> i.e. to tell Git _what_ you want to do with _which_ commits, identified by 
> short commit names.
> 
> The oneline was _always_ meant as a pure convenience for the user.

Good that you mention it: The one-liner is really convenient. I tend to
replace it by reminders like "====== fix unused var", "===== edit msg",
etc. (after marking the commit "edit") and I'm glad that rebase-i later
prints the one-liner from the insn file rather than the original subject
line before it stops.

(I do it this way because on Windows I can't afford to call rebase-i on a
long patch series for every single task. Rather, I plan the tasks while
the insn editor is open, and this way I keep reminders about what the plan
was.)

No, I definitely don't want the one-liners to end up in the commit
message. ;-)

-- Hannes
