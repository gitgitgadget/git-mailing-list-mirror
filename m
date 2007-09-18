From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 16:19:21 -0700
Message-ID: <20070918231921.GA17652@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org> <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Sam Vilain <sam@vilain.net>, Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmLr-0008Nq-BI
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXIRXT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXIRXT0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:19:26 -0400
Received: from mail.davidb.org ([66.93.32.219]:49650 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbXIRXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:19:26 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXmLh-0004qE-NB; Tue, 18 Sep 2007 16:19:21 -0700
Mail-Followup-To: Reece Dunn <msclrhd@googlemail.com>,
	Sam Vilain <sam@vilain.net>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58658>

On Tue, Sep 18, 2007 at 06:53:45PM +0100, Reece Dunn wrote:

>The main issues with using client workspaces is that they require you
>to use `p4 sync`, whereas git-p4 uses `p4 print` and that they may
>change as the repository changes, but Perforce does not track these
>changes.

Unfortunately, we have one project that heavily abuses P4 client specs.
For every release, someone creates a >900 line client spec and labels the
files in it.  Those are the versions that need to get checked in, and
without rewriting much of what P4 does, I'm going to have to let P4 do the
syncing and checking out.

>I would not do that. It is a good idea to keep the original log
>messages, even if it does make for an uninformative shortlog. Look at
>some of the CVS/SVN imported logs!

I think what I want then is something to filter between 'git log' and 'git
shortlog' that would find a summary line in the commit message and copy it
to the top.  It wouldn't change the history, but clean it up for shortlog's
purpose.

David
