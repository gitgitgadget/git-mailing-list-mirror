From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Fri, 30 Nov 2007 08:32:17 -0800 (PST)
Message-ID: <379331.84167.qm@web55014.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 17:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy8n9-0004pf-Ev
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 17:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934349AbXK3QcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 11:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934267AbXK3QcT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 11:32:19 -0500
Received: from web55014.mail.re4.yahoo.com ([206.190.58.148]:22087 "HELO
	web55014.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934260AbXK3QcS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 11:32:18 -0500
Received: (qmail 84514 invoked by uid 60001); 30 Nov 2007 16:32:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=hwkJzrahqxbyVj7eKgFXGReUDhqF3jtj0vrfdeC20YDkyLBS1uslTAWqGIBERkqgCZS3lUscqis6juPeO2BixdAQEgi2MHwTZX/roZjwjEyzc9Ybirn32T/wBjFBbruXdk4LzvRnSLDqoszyKCAqarvHrD2G962zuGdXI7yErhQ=;
X-YMail-OSG: sQYMK8IVM1mc7TfnkFjcZNXXh6GyiYNgZpm91IiYfDDTA90jIX_pS94CxKhY2AMcLpMu1CKJjnhgGvDKQKMfzCXCcecbfu.O7Xhfgsu8JrW0Ry2lVGc-
Received: from [64.243.89.222] by web55014.mail.re4.yahoo.com via HTTP; Fri, 30 Nov 2007 08:32:17 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66649>

On Wed, 28 Nov 2007 12:08:40 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> You can still do that by hand, by doing something
like:
> 
> 	$ git merge --squash A
>         $ resolve only partly
>         $ git commit -m 'Prepare to merge A'
>         $ git reset --hard
>         $ git merge A
> 	$ resolve the rest
>         $ git commit -m 'Fully merged A'
> 
> For such a multi-step merge to make sense, the
change between B---M
> should make sense by itself for people who have to
read such a history
> later.  Such a half-a-squash-merge may probably not
make sense by itself
> in most cases, so I suspect the above workflow would
not be useful in
> general.
> 

Junio,
	I resolved all the merges and then committed
different files as groups to make it easy to
cherry-pick after this merge.  Does this "mess up" the
merge info?  What does the "git reset --hard" do after
the commit (I'm assuming it throws away the
non-resolved changes not committed)?  But from my
experience git wouldn't let me do the commit above it
w/o first fixing the conflicts.

	Am I mis-interpreting your example or are you saying
that you think git would let me do the commit w/o
resolving all conflicts?

Bill



      ____________________________________________________________________________________
Get easy, one-click access to your favorites. 
Make Yahoo! your homepage.
http://www.yahoo.com/r/hs 
