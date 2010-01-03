From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 12:08:37 +0900
Message-ID: <877hrzga16.fsf@catnip.gol.com>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
	<7v637nzky0.fsf@alter.siamese.dyndns.org>
	<7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
	<7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	<fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
	<7v7hs09tpi.fsf@alter.siamese.dyndns.org>
	<87ljgfgbl0.fsf@catnip.gol.com>
	<fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 04:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRGqP-0008Dg-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 04:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0ACDIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 22:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466Ab0ACDIr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 22:08:47 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:60471 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0ACDIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 22:08:47 -0500
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NRGpa-0002u1-2E; Sun, 03 Jan 2010 12:08:38 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 51AE3DF32; Sun,  3 Jan 2010 12:08:37 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
	(Miles Bader's message of "Sun, 3 Jan 2010 11:47:19 +0900")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136064>

Miles Bader <miles@gnu.org> writes:
>> Isn't "-e" a "classic" grep option tho?
>
> Hmm, a bit of googling, and it seems that while 7th Edition unix (as
> classic as I get) had -e, solaris indeed doesn't....

Tho solaris does have it in /usr/xpg4/bin/grep...

Since it's a general attribute of solaris that the default (/usr/bin)
tools are horrible sysv things and the actual useful tools are in
e.g. /usr/xpg4/bin, maybe it would be better to just try and add that
directory to the path...?

-miles

-- 
Americans are broad-minded people.  They'll accept the fact that a person can
be an alcoholic, a dope fiend, a wife beater, and even a newspaperman, but if
a man doesn't drive, there is something wrong with him.  -- Art Buchwald
