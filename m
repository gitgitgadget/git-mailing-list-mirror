From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 10:32:24 +0200
Message-ID: <vpqk5repwpz.fsf@bauges.imag.fr>
References: <200708290348.02853.zack@kde.org>
	<7vfy22squc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Rusin <zack@kde.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJ0T-0006rM-Io
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbXH2Iea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbXH2Iea
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:34:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:39517 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798AbXH2Ie3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:34:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7T8WPeh028702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Aug 2007 10:32:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IQIyO-0005rA-Gj; Wed, 29 Aug 2007 10:32:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IQIyO-0007AD-C8; Wed, 29 Aug 2007 10:32:24 +0200
In-Reply-To: <7vfy22squc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 29 Aug 2007 01\:11\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 29 Aug 2007 10:32:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56909>

Junio C Hamano <gitster@pobox.com> writes:

> Zack Rusin <zack@kde.org> writes:
>
>> http://ktown.kde.org/~zrusin/git/git-cheat-sheet.svg
>
> Nice drawing 

True!

> and no typo.

Except for the blue closing parenthesis for (git-config --help), while
the opening one is black ;-).

> + "git commit" is not about publishing at all.

It does not publish in itself, but it's mostly necessary in order to
publish. For a short summary, I think it's OK to have it in the
publishing section, as long as it's just before "format-patch" and
"push".

otherwise, about the suggested flow on the top right, I'd move
"commit" to the left. Most of the time, "commit" comes before pull or
fetch. It normally comes before "revert", but after "reset" (revert
creates a new commit, you want to do it from a clean tree, so either
reset or commit before).

-- 
Matthieu
