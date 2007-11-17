From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-cvsimport bug with dates
Date: Sat, 17 Nov 2007 22:36:17 +0100
Message-ID: <20071117213617.GG5198@efreet.light.src>
References: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com> <7vr6iq207f.fsf@gitster.siamese.dyndns.org> <51419b2c0711160612r1a80bd5o686040f945e8d9c3@mail.gmail.com> <200711171112.23150.robin.rosenberg.lists@dewire.com> <51419b2c0711170739p1a2bf6c7g87f615676f72aedf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItVLM-0008Mp-0L
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbXKQVgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbXKQVgb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:36:31 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:43045 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbXKQVga (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:36:30 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 610CB572A6;
	Sat, 17 Nov 2007 22:36:29 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id G9c7teaLnGMx; Sat, 17 Nov 2007 22:36:26 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B9DCE57325;
	Sat, 17 Nov 2007 22:36:25 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItVKr-0001Kw-4b; Sat, 17 Nov 2007 22:36:17 +0100
Content-Disposition: inline
In-Reply-To: <51419b2c0711170739p1a2bf6c7g87f615676f72aedf@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65313>

On Sat, Nov 17, 2007 at 08:39:08 -0700, Elijah Newren wrote:
> Okay...so I guess my suggestion could be translated as: don't worry
> about when the commit entered; instead make git-cvsimport mark the
> refs as changed as of the CVS date mentioned instead of as of the
> import time.
> 
> I guess there would be reluctance to do this whenever git-cvsimport
> would be used for incremental commits on a repository that also had
> local commits?  Sounds like the issue is deeper than I first realized
> and this probably isn't worth the effort it'd take.

Actually local commits don't need to be involved at all. Incremental import
is enough.

One good reason to use reflog is when you notice something does not work and
recall, that it worked yesterday evening. Than you need to know what you were
looking at at that time, not at what was latest, because you didn't
necessarily have to be up-to-date.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
