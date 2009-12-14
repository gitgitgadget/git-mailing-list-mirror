From: "Richard" <richard@webdezign.co.uk>
Subject: RE: Undoing merges
Date: Mon, 14 Dec 2009 11:42:02 -0000
Message-ID: <8440EA2C12E50645A68C4AA98871665131D9AC@SERVER.webdezign.local>
References: <8440EA2C12E50645A68C4AA98871665131D8D8@SERVER.webdezign.local> <vpqpr6pqrvq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK9Jk-0002Vz-78
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbZLNLmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 06:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756931AbZLNLmF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:42:05 -0500
Received: from mail.webdezign.co.uk ([213.123.201.79]:46645 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756788AbZLNLmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 06:42:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <vpqpr6pqrvq.fsf@bauges.imag.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Undoing merges
Thread-Index: Acp4LqD6hlnLFxlQSuiCz9gPZumegwEgkuUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135202>

Hi again Matt,

Thanks for the reply.

> > Hi git list,
> >
> > I'm trying to find out how to undo a merge.
> 
> When sitting on a merge commit,
> 
>   git reset --merge HEAD^
> 
> will undo this merge commit (i.e. pretend the merge has never
> occurred, at least in your branch). Don't do that if you already
> published this merge commit.

The problem that I'm far past the merge commit.

> > I know that my branches are independent and that I can just carry on
> > working on them and merge again later, but I'm just trying to keep
> > my revision graph tidier. Should I even be undoing merges?
> 
> If it's about cleaning up your history, "git rebase" is your friend,
> too (with the same limitation: don't do that on published history). By
> default, it does some kind of history flattening.

I had a look at the git-rebase man page and it showed to remove a commit
from the middle of a range of commits. I think as I am on longer on the
merge commit and cannot use "git reset --merge HEAD^", I can rebase all
the commits from the commit just after the merge onto the commit just
before the merge and that will remove the merge. Unfortunately I didn't
get a change to try that out so I don't know whether it will work or
not.

Richard
