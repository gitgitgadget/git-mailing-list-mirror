From: Junio C Hamano <junkio@cox.net>
Subject: Re: FYI: git-am allows creation of empty commits.
Date: Fri, 24 Feb 2006 22:04:32 -0800
Message-ID: <7v64n47z4f.fsf@assigned-by-dhcp.cox.net>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
	<7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
	<m18xs1dmp3.fsf@ebiederm.dsl.xmission.com>
	<7vy8019d44.fsf@assigned-by-dhcp.cox.net>
	<20060224131922.GA19401@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Sat Feb 25 07:04:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCsXx-0004Y0-I2
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 07:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWBYGEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 01:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWBYGEh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 01:04:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38900 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932569AbWBYGEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 01:04:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060225060123.BSNS17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 01:01:23 -0500
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16756>

Eric Wong <normalperson@yhbt.net> writes:

>> I think 99.9% of the time it is a mistake if a single-parented
>> commit has the same tree as its parent commit has, so having a
>> check in commit-tree may not be a bad idea.
>
> This would break importers, more than 0.1% I think...  Arch
> definitely allows empty commits for getting log messages in.
> SVN forbids them from their POV, but they also have things
> that we can't see when we import (properties like: mime,
> externals, eol-style) causing us to write the same tree twice.
> Not sure about CVS...
>
> Maybe a flag such as --force could be added.

Good point perhaps.  Maybe an explicit --no-empty should ask for
it, and git-am should use it.  As to git-commit I am unsure.

In the meantime I'd drop the patch.
