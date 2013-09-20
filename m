From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: What's cooking in git.git (Sep 2013, #05; Wed, 18)
Date: Fri, 20 Sep 2013 01:04:13 +0100
Message-ID: <20130920000413.GC482@quark>
References: <xmqqwqmdu6rg.fsf@gitster.dls.corp.google.com>
 <vpqob7pt8tj.fsf@anie.imag.fr>
 <xmqq7gecu1gg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 02:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMoCt-0003dL-7H
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 02:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab3ITAET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 20:04:19 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:39817 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3ITAES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 20:04:18 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-20-229-172.as13285.net ([92.20.229.172]:65514 helo=quark)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VMoCl-0006K8-g8 (Exim 4.80_167-5a66dd3)
	(return-path <prlw1@cam.ac.uk>); Fri, 20 Sep 2013 01:04:15 +0100
Content-Disposition: inline
In-Reply-To: <xmqq7gecu1gg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235042>

On Thu, Sep 19, 2013 at 11:10:39AM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> * mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
> >>   (merged to 'next' on 2013-09-13 at 82e8b91)
> >>  + rebase: fix run_specific_rebase's use of "return" on FreeBSD
> >>
> >>  Work around a bug in FreeBSD shell that caused a regression to "git
> >>  rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
> >>  success report 
> >
> > We just did:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/234825/focus=234870
> 
> That only talks about "more" not showing colors.
> 
>     ... goes and looks ...
> 
> Ah, there is another subthread that ends at 234833 that reports
> success; I am guessing from "pkgsrc" that this is either some
> variant of BSD or Solaris?

Sorry - I unsubscribed in the meantime. My rebase problem was on
NetBSD, your FreeBSD work around worked for me too, and I added
your patch to pkgsrc.

Thanks again,

Patrick
