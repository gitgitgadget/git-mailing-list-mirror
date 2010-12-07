From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: interfacing M$-TFS
Date: Mon, 6 Dec 2010 19:20:11 -0600
Message-ID: <idk26n$c5t$1@dough.gmane.org>
References: <20101203210139.GB14508@nibiru.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 02:21:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPmFb-0006Pa-Dl
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 02:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab0LGBVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 20:21:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:46138 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab0LGBVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 20:21:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PPmFQ-0006Nv-SR
	for git@vger.kernel.org; Tue, 07 Dec 2010 02:21:40 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 02:21:40 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 02:21:40 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163065>


"Enrico Weigelt" <weigelt@metux.de> wrote in message 
news:20101203210139.GB14508@nibiru.local...
>
> Hi folks,
>
>
> is there any way for directly interfacing M$-TFS (w/o its svn proxy) ?
>
> I'm currently working on an embedded linux project and my customer
> has a company wide policy to put everything into - please put on
> you intellectual seatbelt - M$ TFS.
>
> Needless to mention that TFS' VCS stuff is practically unusable,
> but some collegues still committing directly to TFS (haven't
> conviced them to switch over to git), and releases have to be
> put there, as QA folks dont know anything else.
>
> My current workflow is:
>
> #1: a main branch, frequently copied over TFS manually (;-o)
> #2: lots of topic branches which get rebased onto master
> #3: finished topic branches are rebased to latest master and
>    then copied over to and committed in TFS
>
> Of course, that much manual work - especially with the need of
> checking out / locking invidual files in TFS - really suxx and
> wastes a lot of time. So I'm looking for way to:
>
> a) track remote branches from TFS
> b) push back changes into a TFS remote tracking branch
>
> Both should be possible from Linux side, using the native protocol
> (very unlikely that IT department can be convinced to install the
> svn proxy for TFS).
>
>
>
> thx
> -- 
> ----------------------------------------------------------------------
> Enrico Weigelt, metux IT service -- http://www.metux.de/
>
> phone:  +49 36207 519931  email: weigelt@metux.de
> mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
> ----------------------------------------------------------------------
> Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
> ----------------------------------------------------------------------

I'm not familiar with TFS, but have you looked at the vendor-branch 
methodology described in the git-rm manpage?  It seems like it could cover 
just about anything.

v/r,
Neal 
