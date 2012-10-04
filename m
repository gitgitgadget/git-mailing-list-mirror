From: Stephen Bash <bash@genarts.com>
Subject: Re: fa/remote-svn (Re: What's cooking in git.git (Oct 2012, #01;
 Tue, 2))
Date: Thu, 4 Oct 2012 09:16:20 -0400 (EDT)
Message-ID: <1550217065.62365.1349356580255.JavaMail.root@genarts.com>
References: <20121004083001.GA9745@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtYB-0001w8-Fq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab2JDNQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 09:16:27 -0400
Received: from hq.genarts.com ([173.9.65.1]:26496 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756729Ab2JDNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 09:16:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id EAE19BE1754;
	Thu,  4 Oct 2012 09:16:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J+Ug6M97JDUA; Thu,  4 Oct 2012 09:16:20 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4DC31BE15D5;
	Thu,  4 Oct 2012 09:16:20 -0400 (EDT)
In-Reply-To: <20121004083001.GA9745@elie.Belkin>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC22 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206974>

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> Sent: Thursday, October 4, 2012 4:30:01 AM
> Subject: Re: fa/remote-svn (Re: What's cooking in git.git (Oct 2012, #01; Tue, 2))
> 
> > > * fa/remote-svn (2012-09-19) 16 commits
> > > - Add a test script for remote-svn
> > > - remote-svn: add marks-file regeneration
> > > - Add a svnrdump-simulator replaying a dump file for testing
> > > - remote-svn: add incremental import
> > > - remote-svn: Activate import/export-marks for fast-import
> > > - Create a note for every imported commit containing svn metadata
> > > - vcs-svn: add fast_export_note to create notes
> > > - Allow reading svn dumps from files via file:// urls
> > > - remote-svn, vcs-svn: Enable fetching to private refs
> > > - When debug==1, start fast-import with "--stats" instead of
> > > "--quiet"
> > > - Add documentation for the 'bidi-import' capability of
> > > remote-helpers
> > > - Connect fast-import to the remote-helper via pipe, adding
> > > 'bidi-import' capability
> > > - Add argv_array_detach and argv_array_free_detached
> > > - Add svndump_init_fd to allow reading dumps from arbitrary FDs
> > > - Add git-remote-testsvn to Makefile
> > > - Implement a remote helper for svn in C
> > > (this branch is used by fa/vcs-svn.)
> > >
> > > A GSoC project.
> > > Waiting for comments from mentors and stakeholders.
> >
> > I have reviewed this topic and am happy with the design and
> > implementation.  I support this topic for inclusion.
> 
> Thanks!  I'll try moving the tests to the first patch and trying it
> and hopefully send out a branch to pull tomorrow.
> 
> If I don't send anything tomorrow, that's probably a sign that I never
> will, so since I like the goal of the series I guess it would be a
> kind of implied ack.

I seemed to have missed the GSoC wrap up conversation... (links happily
accepted)  Looking at the big picture (as much as I can remember) it
seems to me the missing pieces now are branch mapping (lots of hard
work), and possibly parts (all?) of the "push to SVN" functionality?

Thoughts?

Thanks,
Stephen
