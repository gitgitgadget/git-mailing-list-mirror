From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for backward compatibility.
Date: Fri, 05 Sep 2008 08:31:40 +0200
Message-ID: <vpqaben6r3n.fsf@bauges.imag.fr>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
	<1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
	<20080904123046.GX10544@machine.or.cz>
	<7v63pb3emm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUvu-0001R1-JO
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYIEGfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 02:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYIEGf3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:35:29 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:41653 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbYIEGf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 02:35:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m856VgK1021662;
	Fri, 5 Sep 2008 08:31:42 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KbUr6-0007K1-4z; Fri, 05 Sep 2008 08:31:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KbUr6-0001Rc-2l; Fri, 05 Sep 2008 08:31:40 +0200
In-Reply-To: <7v63pb3emm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 04 Sep 2008 12\:17\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 05 Sep 2008 08:31:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94996>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> Can you please also mark it deprecated in the bash completion and
>> command-list.txt?

[...]

> While I do not mind marking annotate as ": infrequently used ;;" in t=
he
> completion script, I am skeptical about the value of such a change.
> Dropping annotate from the completion is a _slight_ improvement in th=
at
> when people type "git a<TAB>" they will see one less candidates, but =
it is
> not a great deal of improvement: four down from five.

Hm, right. Someone used to "$scm annotate" will probably try
"git=A0an<TAB>" and not finding anything there would be misleading
(probably why svn has "annotate" as an alias for "blame").

> Mentioning that we support both names for findability in both annotat=
e and
> blame manual pages (not just annotate page) might be a better thing t=
o do.

git-blame.txt already somehow has it in the documentation for "-c". I
can't think of a good wording to improve it.

--=20
Matthieu
