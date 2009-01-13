From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 07:48:00 +0100
Message-ID: <vpqiqojpuqn.fsf@bauges.imag.fr>
References: <20090113045422.GA6940@b2j>
	<slrngmodgv.ple.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 07:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMd8A-0005CZ-Ng
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 07:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbZAMGum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 01:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZAMGum
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 01:50:42 -0500
Received: from imag.imag.fr ([129.88.30.1]:36251 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbZAMGul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 01:50:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n0D6m0jD021925
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Jan 2009 07:48:00 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LMd4C-00084p-Ls; Tue, 13 Jan 2009 07:48:00 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LMd4C-0005IS-Im; Tue, 13 Jan 2009 07:48:00 +0100
In-Reply-To: <slrngmodgv.ple.sitaramc@sitaramc.homelinux.net> (Sitaram Chamarty's message of "Tue\, 13 Jan 2009 06\:35\:11 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Jan 2009 07:48:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105462>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I like using "git rebase -i HEAD~5" (if I want to rebase the
> last 5 commits).  In the editor that pops up, I reorder the
> ones that I know should be together, and on each set to be
> squashed, I change the "pick" to "s" (for squash) on all but
> the first one.  Save the file and it's all done.

And right after, you probably want to do stg like

  git diff master@{1} master

to see whether you actually changed the result by reordering your
patches.

-- 
Matthieu
