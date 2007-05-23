From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git branching & pulling
Date: Tue, 22 May 2007 17:35:33 -0700
Message-ID: <7vwsz05qcq.fsf@assigned-by-dhcp.cox.net>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	<7vveepxr7m.fsf@assigned-by-dhcp.cox.net>
	<d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>
	<200705202230.24362.Josef.Weidendorfer@gmx.de>
	<d4cf37a60705221722t2167a0e8x810689218b87fb39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Wink Saville" <wink@saville.com>
X-From: git-owner@vger.kernel.org Wed May 23 02:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqepK-00007t-U7
	for gcvg-git@gmane.org; Wed, 23 May 2007 02:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649AbXEWAfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 20:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758058AbXEWAff
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 20:35:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58528 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757649AbXEWAff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 20:35:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523003534.UWEX13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 22 May 2007 20:35:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2QbZ1X00a1kojtg0000000; Tue, 22 May 2007 20:35:34 -0400
cc: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
In-Reply-To: <d4cf37a60705221722t2167a0e8x810689218b87fb39@mail.gmail.com>
	(Wink Saville's message of "Tue, 22 May 2007 17:22:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48136>

"Wink Saville" <wink@saville.com> writes:

>> Creation of a branch from another local one never has created
>> "branch.x.remote" or "branch.x.merge" entries. I am not even sure
>> that setting "branch.x.remote" to "." is working in the current version.
>
> I tired to create the appropriate entries and it didn't work,
> but maybe operator error.
>
>> BTW: There was some old behavior of "git pull" to always pull the master
>> branch from remote "origin" without any further parameters. I suppose that
>> you did not want this to happen in your example above ?!
>
> I expected it to pull from its upstream (i.e. the branches parent).

While "I branched and that means I will always merge from that
branch" does not hold true for everybody, we do have an option
to make that easy to work in recent git.  Look in git-branch
documentation and check autosetupmerge configuration option.

I notice that Paolo did not update Documentation/config.txt
when he add this feature with 0746d19a; care to send in a patch
to correct this?
