From: Sebastien Cevey <seb@cine7.net>
Subject: Re: What's cooking in git.git (Feb 2009, #04; Sun, 15)
Date: Mon, 16 Feb 2009 16:27:22 +0100
Message-ID: <1234798042.499985da2915e@mail.nimag.net>
References: <7v1vu0nfu4.fsf@gitster.siamese.dyndns.org> <m3ocx4t0mv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:29:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5Oy-00066N-J6
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZBPP12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZBPP11
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:27:27 -0500
Received: from mail.hebweb.net ([62.220.136.4]:41037 "HELO
	mail-unsh.hebweb.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751445AbZBPP10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:27:26 -0500
Received: (qmail 17583 invoked by uid 33); 16 Feb 2009 15:27:22 -0000
Received: from 146.101.142.69 ([146.101.142.69]) 
	by mail.nimag.net (IMP) with HTTP 
	for <postmaster@cine7.net@mail.nimag.net>; Mon, 16 Feb 2009 16:27:22 +0100
In-Reply-To: <m3ocx4t0mv.fsf@localhost.localdomain>
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 146.101.142.69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110191>

Selon Jakub Narebski <jnareb@gmail.com>:

Hello Jakub,

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
> >  - gitweb: Optional grouping of projects by category
> >  - gitweb: Split git_project_list_body in two functions
> >  - gitweb: Modularized git_get_project_description to be more generic
> > 
> > Design discussion between Jakub and Sebastien seems to have stalled.
> 
> But I am bit stalled at second patch in the series, which extract
> _printing_ the rows in separate function... while it should IMHO also
> refactor _filtering_ projects list, and not have "filtering as we
> print" current code uses... which would be night incompatibile with
> dividing projects list into pages.
> 
> I think this patch series is definitely for after 1.6.2

Okay, I am sorry but I'm going to give up at this point. This patch has been in
the pipeline since July 27, 2008. I understand the iterative review process to
ensure a certain code quality and acknowledge that these patches weren't
perfect
(and probably still aren't), but it's a bit too much of extra rewrite to
support
features that didn't exist and still don't exist yet AFAIK (page splitting of
projects page?). Feel free to take over and do the changes you have in mind,
it'd probably be faster than trying to guide me through it; I still believe
it'd
be a welcome feature, and we've been waiting for it to be merged upstream for
quite a while to activate it on the XMMS2 gitweb.

I have to admit I'm not particularly fond of hacking Perl, but the effort to
get
this rather simple and isolated feature merged don't make it very attractive.

It's a single 6300+ line Perl script we're talking about after all.

Regards,

-- 
Sebastien Cevey - inso.cc
