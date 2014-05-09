From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 9 May 2014 08:15:07 +0000
Message-ID: <20140509081507.GA26494@dcvr.yhbt.net>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:15:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wifxh-0002yY-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbaEIIPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:15:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37309 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbaEIIPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:15:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1018C20945;
	Fri,  9 May 2014 08:15:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <536c7f9089b77_182dd0d31084@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248531>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Eric Wong wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > No updates since 2010, and no tests.
> > 
> > Who benefits from this removal?  Is this causing a maintenance
> > burden for Junio?
> 
> It is cruft that nobody uses and we are not even testing.

We do not know nobody uses it.  I have old GNU Arch projects I have not
looked at in a decade.  There is a small chance I may use archimport
again (whether for nostalgia or contractual/legal reasons).

Of course I know to extract archimport from history, but someone in
the future may not know the existence of it.

> > > Plus, foreign SCM tools should live out-of-tree anyway.
> > 
> > Even if so, there ought to be a transitionary period in case there are
> > any users.  We would need to warn potential users of its impending
> > removal in the documentation and at runtime.
> 
> All right, so you are OK with adding deprecation warnings whenever the
> tool is run, and a note in the documentation?

No, I am not convinced existing foreign SCM tools should move
out-of-tree.  Perhaps something like the following would be helpful:

  Warning: Like GNU Arch, git-archimport is unmaintained.  Please
  contact us at git@vger.kernel.org in case you run into problems,
  want to help, or just want to tell us it still works.
