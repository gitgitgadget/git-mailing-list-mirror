From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Advice on edits to git-rebase man page
Date: Thu, 05 Feb 2015 11:44:33 +0100
Message-ID: <vpqa90s4oz2.fsf@anie.imag.fr>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Matthew Brett <matthew.brett@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 11:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJJvY-0002yU-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 11:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbbBEKon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 05:44:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42897 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbbBEKom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 05:44:42 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t15AiXWD024459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Feb 2015 11:44:33 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t15AiXab006628;
	Thu, 5 Feb 2015 11:44:33 +0100
In-Reply-To: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
	(Matthew Brett's message of "Wed, 4 Feb 2015 12:21:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Feb 2015 11:44:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t15AiXWD024459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1423737876.91266@umwhDbz5FCUMVEkT3npEOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263370>

Matthew Brett <matthew.brett@gmail.com> writes:

> Obviously my page as it is now is very different in tone from the
> git-rebase page, but I think there are some aspects that could be
> fruitfully merged.   Would you be interested in patches of this sort,
> or does the page seem too far from the intention of the man page?

I think it is deliberate that manpages are not written as tutorial, but
as more advanced technical documentation. Just like learning Unix can
hardly be done by reading "man ls", "man cd", ... the best entry point
to learn Git is not the manpages. OTOH, I usually like Git's manpages
when I know what I'm looking for.

All that being said, there's a lot of room for improvement in our
manpages, event remaining in a technical-style. I'm not a good juge
because I already learnt how rebase works long ago, but the git rebase
man page does seem terrible for bare mortals:

  NAME
       git-rebase - Forward-port local commits to the updated upstream head

=> Quite technical already.

  DESCRIPTION
       If <branch> is specified, git rebase will perform an automatic
       git checkout <branch> before doing anything else. Otherwise it
       remains on the current branch.

=> Ouch, do we really want to start a documentation like this?

So, the DESCRIPTION part can definitely be improved IMHO. Your notation
<graft-point>, <exclude-from> and <include-from> may be an improvement
already.

Some concrete examples may help too, like "I started developing against
origin/foo, on local branch bar, and now want to rebase my work on top
of origin/boz".

My 2 cents,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
