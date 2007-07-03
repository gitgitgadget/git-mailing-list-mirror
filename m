From: "Patrick Doyle" <wpdster@gmail.com>
Subject: How to create & switch to a branch after changes have already been made?
Date: Mon, 2 Jul 2007 22:18:05 -0400
Message-ID: <e2a1d0aa0707021918mb335856j278b3128203a793a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 04:18:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Xy9-0000MR-Ej
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 04:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbXGCCSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbXGCCSH
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 22:18:07 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:46516 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXGCCSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 22:18:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1077989nze
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 19:18:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DnMJgvJ0KGolortYeLjD+3JPnr3oSUi69PrzgJPbYta23R4kJn+TANXPU0z3tfL55EqtTVORjMUlSXcl1gz98E1Cnc+0buMmgyzxL/jR/A2VLoMV7OLrKL/eYL+8iQpF3qVxtfPg4OWvK7Jb6sQCK1dj85dWcmwYLkvlM4Qjk4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xv8FYd0GtW9UDSOj906agWz/csaBM58B/MMOQ/dCVlypyUx3R0QN6QVNg4Z4ygbd1G1F7CZMmoQaEN3zMslqMqTYRtyIKLlZOnchJ34nr4U2sfPbPpLjh+4oyZl/AUPtBeu0mG5lwU0DZRFeWMv8Gm71STj6F2itb4aNERaHYf0=
Received: by 10.114.108.15 with SMTP id g15mr5694889wac.1183429085250;
        Mon, 02 Jul 2007 19:18:05 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Mon, 2 Jul 2007 19:18:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51440>

Suppose, hypothetically speaking, one were a long time user of CVS who
converted to subversion in the last 18 months or so, and who never
really understood branches and merging because the syntax was so
obtuse and because the projects this hypothetical person had worked
were short lived enough that (s)he never really needed to create a
branch.

Now suppose this hypothetical person was working on a new project,
decided to use git as the project's version control system, got
halfway through changing a bunch of files, wanted to commit them as
they were, since they worked, but were ugly as sin, and wanted to
clean them up before committing them back to the main line of
development.

I would tell that hypothetical person, "Gee, it sounds like a branch
is exactly what you need here".  Unfortunately I don't know how to
tell the person to do the equivalent of a "svn switch" when the local
repository has been modified.

$ git branch newbranch
 that works, but
$ git checkout newbranch
complains that an untracked file would be overwritten by the merge
(since one of the things that this hypothetical person may have done
would have been to do a "git mv somefile someotherfile").

What would you suggest I say to this person other than "get in the
habit of creating a new branch _any_ time you start something new".

--wpd
