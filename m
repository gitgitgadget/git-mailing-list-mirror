From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Wrong help text on git status -h ?
Date: Wed, 23 Apr 2008 18:00:47 +0200
Message-ID: <vpqfxtc36j4.fsf@bauges.imag.fr>
References: <loom.20080423T125136-135@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:17:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Johek-0004vn-NA
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbYDWQQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYDWQQX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 12:16:23 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:48964 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbYDWQQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 12:16:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m3NGFNe1012992;
	Wed, 23 Apr 2008 18:15:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JohOp-0002mc-HW; Wed, 23 Apr 2008 18:00:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JohOp-0002l8-Es; Wed, 23 Apr 2008 18:00:47 +0200
In-Reply-To: <loom.20080423T125136-135@post.gmane.org> ("Stefan
 =?iso-8859-1?Q?N=E4we=22's?= message of "Wed\, 23 Apr 2008 12\:54\:51 +0000
 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 23 Apr 2008 18:15:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80227>

Stefan N=E4we <stefan.naewe+git@gmail.com> writes:

> Getting help for commit on 'git status -h' can't be right, can it ?
> Or am I missing something?

I'd say: both.

git status could have been spelled "git commit --dry-run", they're
actually the same command, but "git status" stops before launching the
editor and doing the actual commit. So, they take the exact same set
of options.

That said, in an ideal world, "git status -h" would mention that the
commit message options are ignored with "git status".

--=20
Matthieu
