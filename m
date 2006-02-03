From: Dave Jones <davej@redhat.com>
Subject: Re: The merge from hell...
Date: Fri, 3 Feb 2006 11:21:33 -0500
Message-ID: <20060203162133.GF24201@redhat.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0602022139190.3462@g5.osdl.org> <7vbqxpj6qs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Brown, Len" <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 17:23:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F53hr-0005zb-3s
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 17:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWBCQWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCQWY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 11:22:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751015AbWBCQWY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 11:22:24 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k13GLcxF005521;
	Fri, 3 Feb 2006 11:21:38 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k13GLb113179;
	Fri, 3 Feb 2006 11:21:37 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k13GLbbv020301;
	Fri, 3 Feb 2006 11:21:37 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id k13GLaQk030335;
	Fri, 3 Feb 2006 11:21:36 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k13GLXsF030262;
	Fri, 3 Feb 2006 11:21:33 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqxpj6qs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15539>

On Thu, Feb 02, 2006 at 10:28:43PM -0800, Junio C Hamano wrote:

 > > One thing I'd ask for: would it be possible to have more descriptive 
 > > branch names than just numbers? Even if you want to track it by bugzilla 
 > > entry number, how about calling it "bugzilla-12345" instead? 
 > 
 > When kernel people (not just Len) talk about a "bugzilla ID",
 > does that ID always come from the same namespace, or do some
 > subsystems have their own bugzilla?

Not only do some subsystems have their own bugtracker (ALSA for eg),
but referring to 'bugzilla' alone is meaningless, as it could
mean bugme.osdl.org, bugzilla.redhat.com, bugzilla.novell.com,
bugzilla.ubuntu.com etc etc, all of which are a prime source of
juicy kernel bugs.

		Dave
