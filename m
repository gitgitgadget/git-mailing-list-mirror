From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 15:07:54 -0800
Message-ID: <7v3av1n8ad.fsf@gitster.siamese.dyndns.org>
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
	<vpqd4u5zvs3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFjA-00048e-8R
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 00:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbXKSXIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbXKSXIG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 18:08:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55577 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbXKSXIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 18:08:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 306972FC;
	Mon, 19 Nov 2007 18:08:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 911E49799D;
	Mon, 19 Nov 2007 18:08:19 -0500 (EST)
In-Reply-To: <vpqd4u5zvs3.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	19 Nov 2007 23:59:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65517>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I have no ideal solution for that. git(7) is already really long.
> Perhaps some "topic man pages" would be good. By "topic man page", I
> mean "man git-something" where "something" isn't a git command, but a
> crosscutting concept. For example, here, "man git-refspec" to document
> reference specifiers like HEAD@{42}, master~55, d71c6c8e24a and
> friends. "man git-i18n" would be another candidate.

Yeah, gitattributes(5), gitignore(5) and gitmodules(5) can take
advantage of the fact that they define file formats and describe
the underlying concepts in their own corner while describing the
file format.  But there are many other things (e.g. syntax for
refspec, ref naming) that would benefit from having their own
topic-centric documents, without defining their own file format,
so git-refspec(5) trick is not an option for them.
