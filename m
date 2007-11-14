From: Ivan Shmakov <ivan@theory.asu.ru>
Subject: Re: tracking remotes with Git
Date: 15 Nov 2007 00:26:11 +0600
Message-ID: <m2r6isiszg.fsf@cherry.siamics.int>
References: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
Reply-To: Ivan Shmakov <oneingray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Shmakov <oneingray@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 19:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsMwe-0002cw-L4
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 19:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbXKNS0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbXKNS0U
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 13:26:20 -0500
Received: from mx.asu.ru ([82.179.20.33]:43679 "HELO ns.asu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751807AbXKNS0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 13:26:19 -0500
Received: (qmail 15015 invoked by uid 1002); 14 Nov 2007 18:26:12 -0000
Received: from unknown (HELO th2.phys.asu.ru) (82.179.21.199)
  by ns.asu.ru with SMTP; 14 Nov 2007 18:26:12 -0000
Received: from localhost ([127.0.0.1] helo=cherry.siamics.int)
	by th2.phys.asu.ru with esmtp (Exim 4.63)
	(envelope-from <ivan@theory.asu.ru>)
	id 1IsMwG-00076O-EL; Thu, 15 Nov 2007 00:26:13 +0600
In-Reply-To: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64996>

>>>>> "IS" == Ivan Shmakov <oneingray@gmail.com> writes:

[...]

 IS> * it looks like `git-cvsimport' uses its own CVS protocol
 IS> implementation which doesn't support compression; I've tried to
 IS> clone a repository of a project hosted in CVS since circa 1998 and
 IS> it 20 MiB or so to obtain revisions until 2000 or so; any ways to
 IS> minimize traffic?

	I've switched to tailor instead.  It uses native cvs(1), which
	supports compression.

 IS> * how many revisions will `git-svn fetch' obtain from the SVN
 IS> repository?  I had to run it for several times to get the full
 IS> history; I've tried to use (undocumented) `--fetch-all' option,

	BTW, how about documenting that one?

 IS> but it appears to help (may be but for a little.)

	s/to/not to/.

[...]
