From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: 15 Oct 2005 06:03:00 -0700
Message-ID: <863bn3lypn.fsf@blue.stonehenge.com>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 15:04:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQlh9-0007AG-5e
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 15:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJONDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 09:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVJONDP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 09:03:15 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:18101 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751150AbVJONDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 09:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 080738F6CE;
	Sat, 15 Oct 2005 06:03:02 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11504-01-4; Sat, 15 Oct 2005 06:03:01 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 92EFA8F765; Sat, 15 Oct 2005 06:03:01 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
x-mayan-date: Long count = 12.19.12.12.16; tzolkin = 6 Cib; haab = 14 Yax
In-Reply-To: <Pine.LNX.4.63.0510141543030.23242@iabervon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10132>

>>>>> "Daniel" == Daniel Barkalow <barkalow@iabervon.org> writes:

Daniel> Can you give a general description of what happens? I've
Daniel> noticed that I sometimes get spurious error messages that
Daniel> don't actually affect the download, which I haven't tracked
Daniel> down yet.

OK, it happened this morning.  While syncing to update from
yesterday's version, I got:

    localhost:~/MIRROR/git-GIT % git-pull
    Fetching refs/heads/master from http://www.kernel.org/pub/scm/git/git.git using http
    Getting alternates list
    got 4546738b58a0134eef154231b07d60fc174d56e3
    walk 4546738b58a0134eef154231b07d60fc174d56e3
    got d402d5566fdf226697a386dfb9858e5d954e9b91
    got 873d8e5652c06c3891278f33546c437efc209c2d
    walk d402d5566fdf226697a386dfb9858e5d954e9b91
    error: 
    Getting pack list
    got 0207ab18a3876249a928e7539d8f594a4f6921f1
    got 9f7534accdf34b980a2de670cb1009dd84ee56c4
    error: Unable to find 5ad4a2766d34569f3a1278544ab64978fab14cc8 under http://www.kernel.org/pub/scm/git/git.git/

    Cannot obtain needed blob 5ad4a2766d34569f3a1278544ab64978fab14cc8
    while processing commit d402d5566fdf226697a386dfb9858e5d954e9b91.

Definitely broken.  But I can "rsync" just fine.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
