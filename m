From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Remove "historical" objects from repository to save place
Date: 21 Jan 2006 12:49:39 -0800
Message-ID: <86slrhe270.fsf@blue.stonehenge.com>
References: <200601212218.51055.arvidjaar@mail.ru>
	<7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
	<20060121200615.GM28365@pasky.or.cz>
	<7virsdl44q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:49:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0PgC-0002oj-D4
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAUUtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWAUUtp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:49:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:16529 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932343AbWAUUto
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 15:49:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 4BF498EBDB;
	Sat, 21 Jan 2006 12:49:40 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 02263-01-4; Sat, 21 Jan 2006 12:49:39 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D01618EBE3; Sat, 21 Jan 2006 12:49:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.17.14; tzolkin = 13 Ix; haab = 12 Muan
In-Reply-To: <7virsdl44q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15019>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Most likely what the original requestor cloned from Linus has
Junio> been already packed so git-prune would not do much.

Wait.  Does that mean that:

$ git-checkout -b playground
$ work work work
$ git-commit -m 'snapshot'
$ git-checkout -b master
$ git-repack -a -d

means that even if I do

$ git-branch -d playground
$ git-repack -a -d

I still have the commit from playground as objects inside my one big pack?

Ick.  How do I make that go away?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
