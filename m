From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: FYI: git-am allows creation of empty commits.
Date: Fri, 24 Feb 2006 04:24:08 -0700
Message-ID: <m18xs1dmp3.fsf@ebiederm.dsl.xmission.com>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
	<7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 12:25:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCb4Z-0007ZZ-Nt
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 12:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBXLZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 06:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWBXLZP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 06:25:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38562 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932156AbWBXLZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 06:25:13 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k1OBO8uI022667;
	Fri, 24 Feb 2006 04:24:08 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k1OBO8cS022666;
	Fri, 24 Feb 2006 04:24:08 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wxtgv02.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Feb 2006 21:56:29 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16694>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> After fixing it up and doing all of my edits I occasionally forget
>> the git-update-index step, before calling git-am --resolved.  This
>> proceeds along it's merry way and creates an empty commit.
>
> Certainly a safty measure is missing here.  Thanks for
> noticing.  How about something like this?

Just tested it the patch works, at least in my simple contrived
example :)

Is this something that we always want to test for in the porcelain
or do we want to move a check into git-commit-tree?

For getting a reasonable error message where you have the test
seems to be the only sane place, but having the check deeper
down would be more likely to catch this kind of thing.

Eric
