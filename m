From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 30 Oct 2008 16:20:28 +0100
Message-ID: <vpqmygmw1mr.fsf@bauges.imag.fr>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	<20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:39:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZcY-0005yg-Ob
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbYJ3PiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbYJ3PiZ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:38:25 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:51882 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbYJ3PiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:38:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9UFZTtv016688;
	Thu, 30 Oct 2008 16:35:31 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KvZK0-00023l-Hh; Thu, 30 Oct 2008 16:20:28 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KvZK0-0002kJ-FQ; Thu, 30 Oct 2008 16:20:28 +0100
In-Reply-To: <20081030143918.GB14744@mit.edu> (Theodore Tso's message of "Thu\, 30 Oct 2008 10\:39\:18 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 30 Oct 2008 16:35:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99489>

Theodore Tso <tytso@mit.edu> writes:

> * Add the command "git revert-file <files>" which is syntactic sugar for:
>
>         git checkout HEAD -- <files>

I don't think "revert-file" is a good name for this: although other
SCM often call this "revert", what Git calls "revert" is about
reverting an existing commit (it's "backout" in hg for example). The
terminology to revert the working tree to the last commited version is
already here in Git, it's "reset".

I've already argued in favor of allowing "git reset --hard <files>",
which is consistant with existing terminology and doesn't add an extra
command, but without success.

-- 
Matthieu
