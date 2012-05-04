From: greened@obbligato.org
Subject: Re: Subtree in Git
Date: Thu, 03 May 2012 21:26:54 -0500
Message-ID: <87fwbgbs0h.fsf@smith.obbligato.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dag@cray.com, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Fri May 04 04:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ8JG-0003E3-J2
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 04:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab2EDCbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 22:31:50 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:37031 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755819Ab2EDCbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 22:31:49 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SQ8KE-00037M-ST; Thu, 03 May 2012 21:32:55 -0500
In-Reply-To: <4F9FA029.7040201@initfour.nl> (Herman van Rink's message of
	"Tue, 01 May 2012 10:34:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Herman van Rink <rink@initfour.nl> writes: >> We don't know
    right now. I want to take a look at Herman's patches >> first but have been
    delayed for various reasons. I hope to get to that >> this weekend. I also
    want to get at least one release under our belt. > > I've worked on this
   a bit over the weekend. > > I've forked the main git repo on github to merge
    my tree on top of that. > > I basically did a: git subtree merge --prefix=contrib/subtree
    <my > git-subtree branch> > > The work in progress in on: https://github.c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196982>

Herman van Rink <rink@initfour.nl> writes:

>> We don't know right now.  I want to take a look at Herman's patches
>> first but have been delayed for various reasons.  I hope to get to that
>> this weekend.  I also want to get at least one release under our belt.
>
> I've worked on this a bit over the weekend.
>
> I've forked the main git repo  on github to merge my tree on top of that.
>
> I basically did a: git subtree merge --prefix=contrib/subtree <my
> git-subtree branch>
>
> The work in progress in on: https://github.com/helmo/git (the
> subtree-updates branch)

This branch seems to have a bunch of commits from master or some other
branch:

on master:
git log subtree-updates --not HEAD

[...some git-subtree stuff...]
commit 10d4332e007132a38dc61f03c760d355da5cd550
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Apr 29 18:00:47 2012 -0700

    The seventh batch of topics graduated to 'master'
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit a75aba4a5306d0fee6a8ee8b48943e2c19eb2750
Merge: 55375e9 46e3581
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Apr 29 17:52:02 2012 -0700

    Merge branch 'js/daemon-test-race-fix'
[...]

Perhaps I'm doing something wrong.  Or does the subtree-updates branch
need to be refreshed?

                               -Dave
