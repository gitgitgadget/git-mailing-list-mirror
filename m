From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames.
Date: Thu, 15 Sep 2005 23:20:45 -0700
Message-ID: <7vk6hhsfcy.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
	<u5tek82bmlb.fsf@fidgit.hq.vtech>
	<7v1x41g3c6.fsf@assigned-by-dhcp.cox.net>
	<7vfysg2wvo.fsf_-_@assigned-by-dhcp.cox.net>
	<43290D0F.9060408@zytor.com> <7vr7bqahb8.fsf@assigned-by-dhcp.cox.net>
	<7vr7bq4ssc.fsf@assigned-by-dhcp.cox.net> <432A5BCE.3030200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 08:21:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG9af-0002NV-Rx
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 08:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVIPGUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 02:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVIPGUt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 02:20:49 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32432 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161048AbVIPGUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 02:20:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916062048.VNEV3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 02:20:48 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <432A5BCE.3030200@zytor.com> (H. Peter Anvin's message of "Thu,
	15 Sep 2005 22:44:46 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8664>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Urk.  Why do this rename anyway?

The "big rename"?  Or these two environment variables?

The former is because it was brought up by somebody who was
introduced to git not so long time ago (i.e. fingers not so
trained to use the old names and the brain wired to terminology
found in the glossary document) for consistency, with favorable
response from the git list.  The latter is just me feeling that
would make things more consistent.

As I outlined, if you keep using the git-ssh-{push,pull} names,
nothing should break.  They call each other using old names, and
0.99.7 will ship both new and old, so one end having 0.99.5 and
the other having 0.99.7 should not be a problem both ways.  The
same goes for those GIT_SSH_* environment variables -- backward
compatible commands honor environment variables with old names.

> Typically when doing new environment variables like this you do:

Yes that was what we did with the other old environment names,
but I can finally deprecate them in 0.99.7.

Initially I said 0.99.8 will stop supporting the old names
(including git-ssh-{push,pull}) and switch to new names only,
but I could be talked into carrying that beyond that, although I
have not heard any objections for that "dropping" plan since I
initially announced it when 0.99.6 was done.

But I personally prefer dropping the old names before we hit 1.0.
