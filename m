From: Johan Herland <johan@herland.net>
Subject: Re: cvs revision number -> git commit name?
Date: Wed, 27 Jan 2010 23:19:30 +0100
Message-ID: <201001272319.30134.johan@herland.net>
References: <hbf.20100126bda0@bombur.uio.no>
 <201001270043.44614.johan@herland.net> <hbf.20100127jjbx@bombur.uio.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Aaron Crane <git@aaroncrane.co.uk>
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:19:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGEe-0003O2-4J
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0A0WTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756170Ab0A0WTe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:19:34 -0500
Received: from smtp.getmail.no ([84.208.15.66]:35899 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756155Ab0A0WTd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 17:19:33 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX005QVFCJNG70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 23:19:31 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX00DBIFCIHE30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 23:19:31 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.221225
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <hbf.20100127jjbx@bombur.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138201>

On Wednesday 27 January 2010, Hallvard B Furuseth wrote:
> Johan Herland writes:
> > You could consider adding the CVS revision numbers as notes (see "git
> > help notes" in >= v1.6.6) to the corresponding commits. Then they don't
> > pollute the commit messages, but instead live in a separate, but
> > parallel hierarchy that can be easily pulled in when you need to
> > reference them (e.g. GIT_NOTES_REF="refs/" git log).
> 
> Thanks, looks better than munging the log.  Though with one common
> weakness - should likely omit noting mass commits, since they'd clutter
> what 'git log' displays too much.  Of course, either could used combined
> with a mapping table.

Of course, you wouldn't put the cvs revision numbers on the default notes 
ref ("refs/notes/commits"). You would rather put them on a _different_ notes 
refs (e.g. "refs/notes/cvs"), where they would not clutter you "git log", 
and then when you _need_ to look at them, you simply run:

  GIT_NOTES_REF=refs/notes/cvs git log


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
