From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Fri, 03 Feb 2006 22:12:39 -0800
Message-ID: <7virrv8xew.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	<17380.15836.61062.401906@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 07:12:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5GfA-0002d8-94
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 07:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946312AbWBDGMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 01:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946314AbWBDGMm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 01:12:42 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41949 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1946312AbWBDGMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 01:12:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204061116.JTPP6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 01:11:16 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17380.15836.61062.401906@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 4 Feb 2006 16:38:36 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15571>

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> In fact, git-diff-tree now gets the subtle cases right for things that 
>> "gitk" for some reason gets wrong. I haven't figured out what's wrong with 
>> gitk, but I don't think it's even worth it: it would be better to just 
>> teach gitk to use git-diff-tree --cc.
>
> Working on it now.  That will let me cut out about 500 lines of pretty
> hairy Tcl code from gitk, which is nice.
>
> Paul.

Excited to hear that.  Please be sure to base your work on the
latest updated format, described in my earlier message

    Subject: [Attn - repository browser authors] diff-tree combined format.
