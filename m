From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 05:53:37 -0700
Message-ID: <8662cdjui6.fsf@red.stonehenge.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
	<4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com>
	<4FA05E9F.9090709@palm.com>
	<85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
	<947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com>
	<63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu May 03 14:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPvXa-0005dt-10
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 14:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab2ECMxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 08:53:42 -0400
Received: from lax-gw16.mailroute.net ([199.89.0.116]:54589 "EHLO
	gw16.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2ECMxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 08:53:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw16.lax01.mailroute.net (Postfix) with ESMTP id A17D55BC2C5;
	Thu,  3 May 2012 12:53:39 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw16.lax01.mailroute.net ([199.89.0.116])
	by localhost (gw16.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id zvYENe25KXQT; Thu,  3 May 2012 12:53:38 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw16.lax01.mailroute.net (Postfix) with ESMTP id 999F85BC2C1;
	Thu,  3 May 2012 12:53:38 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 8EC91124A; Thu,  3 May 2012 05:53:37 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.8; tzolkin = 6 Lamat; haab = 11 Uo
In-Reply-To: <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no> (Hallvard Breien
	Furuseth's message of "Thu, 03 May 2012 14:23:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196905>

>>>>> "Hallvard" == Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:

Hallvard> I mean 'git clone --bare bar.git foo.git' does not give foo.git
Hallvard> a remote named 'origin' with a branch origin/master.  Not sure
Hallvard> if there is a _simple_ way to do it well either.  init + fetch
Hallvard> above does not try to hardlink objects/packs like clone does.

Interesting.  I was surprised by this, but I've confirmed it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
