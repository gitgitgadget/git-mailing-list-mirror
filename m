From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:45:43 +0100
Message-ID: <vpq1vsjdqpk.fsf@bauges.imag.fr>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
	<49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCRT-00069j-UL
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbZC0NsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZC0NsN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:48:13 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56898 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbZC0NsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 09:48:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2RDjiuu012450;
	Fri, 27 Mar 2009 14:45:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LnCNT-0001js-N8; Fri, 27 Mar 2009 14:45:43 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LnCNT-0003vH-Kq; Fri, 27 Mar 2009 14:45:43 +0100
In-Reply-To: <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Fri\, 27 Mar 2009 14\:39\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 27 Mar 2009 14:45:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114892>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> Hi!
>
> AFAIK, "committing" in git is "kind of publishing your work" 

It's not. It's "take a snapshot". Publish is "push" (to a public
place).

> (others may pull it). I don't like publishing my mistakes ;-) Even
> if no-one pulls the commit, your "undo" refers to "committing a fix
> for the last committed mistake", right? Again, I don't really want
> to document/archive (i.e. commit) my mistake. Or did I miss
> something here? 

git commit --amend
git reset HEAD^ and friends (to uncommit something)

-- 
Matthieu
