From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Vendor branches workflow
Date: Wed, 8 Dec 2010 15:54:27 -0600
Message-ID: <idoura$f8u$1@dough.gmane.org>
References: <AANLkTi=s9p3RycRCrocHEzfc4L-pnU6S9xCKfEL7TP=i@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 22:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQRyj-0007vK-3I
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab0LHVzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 16:55:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:46937 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389Ab0LHVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 16:55:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PQRyX-0007qN-UC
	for git@vger.kernel.org; Wed, 08 Dec 2010 22:55:01 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:55:01 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:55:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163226>

"Leonid Podolny" <leonidp.lists@gmail.com> wrote in message 
news:AANLkTi=s9p3RycRCrocHEzfc4L-pnU6S9xCKfEL7TP=i@mail.gmail.com...
> Hi, list,
> I would like an advice on organizing a vendor branch workflow, to
> minimize the risk of it biting me in the future.
> In our project, we have two upstreams, which are rather massively
> patched. One of the upstreams is an SF svn repository, the other
> arrives in form of tgz's with sources. Now git is tracking the patched
> version, and I want to add a vendor branch to simplify future vendor
> drops.
> Out of the SVN upstream, we use only specific directories.
> So, two questions:
> - How do I deal with unneeded directories? Do I filter them out before
> commiting to the vendor branch or while merging the vendor branch into
> the master?
> - Do you think it would be a good idea to keep .svn directories around
> at the vendor branch? (Kind of connected to the first question,
> because if I keep the .svn's, I will also have to keep the unneeded
> dirs).

The git-rm manpage explains a methodology for vendor branches.  Maybe you've 
already read it...

v/r,
Neal 
