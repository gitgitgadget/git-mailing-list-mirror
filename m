From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Wed, 15 Feb 2006 23:33:12 -0800
Message-ID: <7v7j7vhi6f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	<7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	<1139685031.4183.31.camel@evo.keithp.com> <43EEAEF3.7040202@op5.se>
	<1139717510.4183.34.camel@evo.keithp.com> <43EF15D1.1050609@op5.se>
	<m1ek23rduh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Keith Packard <keithp@keithp.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Feb 16 08:33:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9de6-0001a3-Hf
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 08:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWBPHdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 02:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWBPHdP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 02:33:15 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5803 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932497AbWBPHdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 02:33:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216073135.NFVM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 02:31:35 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1ek23rduh.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 15 Feb 2006 23:56:38 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16276>

ebiederm@xmission.com (Eric W. Biederman) writes:

> I don't know how well multiple packs will work with the current git
> protocol...

Then I wonder why you are making this observation ... ;-)

In any case, I suspect this would be helped to a certain degree
by the pack-object that reuses delta data from existing packs,
if your repository is reasonably packed.
