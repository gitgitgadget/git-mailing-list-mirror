From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git
Date: 21 Mar 2006 19:26:22 -0800
Message-ID: <86hd5rma75.fsf@blue.stonehenge.com>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
	<86y7z3mdcz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 04:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLtzg-0006kP-1R
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 04:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCVD02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 22:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCVD02
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 22:26:28 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:23404 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750714AbWCVD01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 22:26:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E5B278F3B2;
	Tue, 21 Mar 2006 19:26:22 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 26288-01-19; Tue, 21 Mar 2006 19:26:22 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 717E78F3BB; Tue, 21 Mar 2006 19:26:22 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.13; tzolkin = 7 Ben; haab = 11 Cumku
In-Reply-To: <86y7z3mdcz.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17799>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I'm waiting for that CVS tree to change again.  It changes every
Randal> 4-5 days.

Speaking of which, I *know* you sent me a patch to apply to incorporate the
one difference, but is there a more automatic way of cherry-picking
git-cvsimport.perl from "next" into a new topic branch of mine?

For example, I can do this:

$ git-checkout next
$ cp git-cvsimport.perl DUMMY
$ git-checkout -b my-playground
$ mv DUMMY git-cvsimport.perl
$ git-commit -a -m 'trying that other version'

But this wastes a commit.  Is there any way to get an index that simply
includes the file from that other branch?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
