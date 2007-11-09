From: Ivan Shmakov <oneingray@gmail.com>
Subject: Re: tracking remotes with Git
Date: 10 Nov 2007 00:11:25 +0600
Message-ID: <m2k5ormgqa.fsf@cherry.siamics.int>
References: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
	<87ode31iki.fsf@graviton.dyn.troilus.org>
Reply-To: Ivan Shmakov <oneingray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Shmakov <oneingray@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 19:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYR2-0002ot-17
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXKISSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbXKISSL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:18:11 -0500
Received: from ns.asu.ru ([82.179.20.33]:58495 "HELO ns.asu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754581AbXKISSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:18:10 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2007 13:18:09 EST
Received: (qmail 14134 invoked by uid 1002); 9 Nov 2007 18:11:26 -0000
Received: from unknown (HELO th2.phys.asu.ru) (82.179.21.199)
  by ns.asu.ru with SMTP; 9 Nov 2007 18:11:26 -0000
Received: from localhost ([127.0.0.1] helo=cherry.siamics.int)
	by th2.phys.asu.ru with esmtp (Exim 4.63)
	(envelope-from <ivan@theory.asu.ru>)
	id 1IqYKE-0002Rp-LW; Sat, 10 Nov 2007 00:11:27 +0600
In-Reply-To: <87ode31iki.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64240>

>>>>> Michael Poole <mdpoole@troilus.org> writes:

[...]

 >> * it looks like `git-cvsimport' uses its own CVS protocol
 >> implementation which doesn't support compression; I've tried to
 >> clone a repository of a project hosted in CVS since circa 1998 and
 >> it 20 MiB or so to obtain revisions until 2000 or so; any ways to
 >> minimize traffic?

 > What I do is arguably a horrible kludge, but it works well: rsync
 > to mirror the CVS repository to my local drive, and cvsimport from
 > that.  When I was tweaking the import process (command-line options
 > and the author conversion file), having the local copy helped a
 > lot.

	Well, rsync certainly gives CVS the ``disconnected operation''
	ability...  Any chances to get rsync (or scp/sftp, etc.) access
	to the CVS repositories on Savannah?  (I'm not one of the
	developers of the aforementioned project, if that matters.)
