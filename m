From: Dave Jones <davej@redhat.com>
Subject: Re: nightly tarballs of git
Date: Sat, 16 Sep 2006 20:03:51 -0400
Message-ID: <20060917000351.GA29108@redhat.com>
References: <20060914172754.GF8013@us.ibm.com> <20060914175116.GB22279@redhat.com> <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net> <20060914193616.GA32735@redhat.com> <7virjq2oyc.fsf@assigned-by-dhcp.cox.net> <20060916175853.GA24124@redhat.com> <7v3baradkb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 02:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOk8u-0001fw-Bf
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 02:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWIQAD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 20:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWIQAD5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 20:03:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19414 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964875AbWIQAD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 20:03:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8H03rtx004349;
	Sat, 16 Sep 2006 20:03:53 -0400
Received: from pressure.kernelslacker.org (vpn-248-26.boston.redhat.com [10.13.248.26])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8H03qOK008124;
	Sat, 16 Sep 2006 20:03:52 -0400
Received: from pressure.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k8H03qTb029151;
	Sat, 16 Sep 2006 20:03:52 -0400
Received: (from davej@localhost)
	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k8H03psH029150;
	Sat, 16 Sep 2006 20:03:51 -0400
X-Authentication-Warning: pressure.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3baradkb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27142>

On Sat, Sep 16, 2006 at 11:09:24AM -0700, Junio C Hamano wrote:
 > Dave Jones <davej@redhat.com> writes:
 > 
 > > This went well, right up until you checked something in :-)
 > >
 > > Generating pack...
 > > Done counting 155 objects.
 > > Result has 126 objects.
 > > Deltifying 126 objects.
 > >    0% (1/126) done
 > > ...
 > > Unpacking 126 objects
 > > Total 126, written 126 (delta 93), reused 0 (delta 0)
 > > * refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/git/git
 > >   from 38529e28a4f465ad5d5f2fa249ca17da680bac5f to fc2b2be031f44aef0106cf7f872b750cd90b2253
 > > * refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
 > >   not updating.
 > > Something wicked happend.
 > 
 > You care only about 'master' in that repository anyway, so I
 > would suggest removing other lines from remotes/origin and have
 > only these two lines:
 > 
 > 	URL:  git://git.kernel.org/pub/scm/git/git
 >         Pull: refs/heads/master:refs/heads/origin

Thanks, I updated the repo, and kicked the snapshot script, and
it seems to be doing the right thing again.

	Dave
