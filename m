From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [Patch] Using 'perl' in *.sh
Date: 10 Jul 2006 06:09:25 -0700
Message-ID: <86veq5sj22.fsf@blue.stonehenge.com>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
	<200607091441.16161.michal.rokos@nextsoft.cz>
	<7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
	<200607100741.26377.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 15:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzvVz-00015s-CF
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 15:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWGJNJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 09:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWGJNJ2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 09:09:28 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:10524 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1161095AbWGJNJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 09:09:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 12B958FAB0;
	Mon, 10 Jul 2006 06:09:27 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22049-02-33; Mon, 10 Jul 2006 06:09:25 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5B8628FAC9; Mon, 10 Jul 2006 06:09:25 -0700 (PDT)
To: Michal Rokos <michal.rokos@nextsoft.cz>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <200607100741.26377.michal.rokos@nextsoft.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23617>

>>>>> "Michal" == Michal Rokos <michal.rokos@nextsoft.cz> writes:

Michal> I don't se the point. If you ask me, I'd say it should be either:
Michal> - controlled fully via env: which means 'perl' in scripts and /usr/bin/env in 
Michal> *.perl; or

which *pointlessly* doesn't work if *I* have installed a private Perl and a
private git on a large shared systems, and *you* on the same system want to
use my git installation, but not necessarily have my Perl in your path.

There's *no* point to the env hack.  You're *installing* the file, which means
you can *rewrite* it as needed.  The env hack is a quick hack in case you have
a no-install file (something you're rsync'ing from one machine to another) for
strictly personal use.  Don't introduce that to something like the formal
git installation.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
