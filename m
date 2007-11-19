From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 23:59:40 +0100
Message-ID: <vpqd4u5zvs3.fsf@bauges.imag.fr>
References: <1195477504.8093.15.camel@localhost>
	<8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
	<E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
	<8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com>
	<25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr>
	<vpqtznirtlk.fsf@bauges.imag.fr>
	<60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr>
	<vpq63zxq5s2.fsf@bauges.imag.fr>
	<0E0AA90A-2282-4AFE-8B94-EA0E35B57D65@lrde.epita.fr>
	<7v7ikdna24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFbk-0001Y2-1l
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 00:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbXKSXAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbXKSXAa
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 18:00:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:44652 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbXKSXA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 18:00:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJMxeiV025502
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 23:59:40 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IuFae-0005L3-6F; Mon, 19 Nov 2007 23:59:40 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IuFae-00010r-1g; Mon, 19 Nov 2007 23:59:40 +0100
In-Reply-To: <7v7ikdna24.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 19 Nov 2007 14\:29\:39 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 23:59:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65515>

Junio C Hamano <gitster@pobox.com> writes:

> I think the ref naming syntax is so commonly used and
> fundamental that we could treat it as prerequiste for individual
> manual pages.  Maybe move the section to git(7)?  That would
> certainly be better than having it in git-rev-parse(1), but does
> not reduce the cross referencing complaints.

Well, obviously, something which isn't addressed by my patch is the
fact that some of the documentation an average user needs is in the
plumbing man pages.

(Gosh, I was going to cite the manpage for git-log and git-rev-parse
as an example, but it has already been fixed :-). Good job !)

git-rev-parse(1) is full of terribly usefull information, and that
information is definitely not in the place an average user would look
at.

I have no ideal solution for that. git(7) is already really long.
Perhaps some "topic man pages" would be good. By "topic man page", I
mean "man git-something" where "something" isn't a git command, but a
crosscutting concept. For example, here, "man git-refspec" to document
reference specifiers like HEAD@{42}, master~55, d71c6c8e24a and
friends. "man git-i18n" would be another candidate.

Anyway, my patch is definitely a step forward, even if it's just the
first, small one ;-).

-- 
Matthieu
