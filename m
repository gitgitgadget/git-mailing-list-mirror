From: Thomas Rast <trast@inf.ethz.ch>
Subject: English/German terminology, git.git's de.po, and pro-git
Date: Mon, 13 May 2013 14:54:51 +0200
Message-ID: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Jan =?utf-8?Q?K?= =?utf-8?Q?r=C3=BCger?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	Ralph Haussmann <ralph@scanmyfood.de>
X-From: git-owner@vger.kernel.org Mon May 13 14:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbsHg-0003Ua-6s
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3EMMy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:54:56 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:23375 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab3EMMyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:54:55 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 14:54:50 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 13 May 2013 14:54:51 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224132>

Hi

I hope I got together a Cc list that pretty much represents everyone
involved in git core and pro-git book translation into German.

As I am sure you are all aware, there are two main religions as to how
one can translate technical material into German: leave the technical
terms mostly in English, or translate them to an appropriate
corresponding word.  I'll denote them G+E and Ger, respectively.  I
would really like to avoid rehashing that entire discussion in this
thread, if at all possible; we've flogged that horse enough.  See
e.g. [1] for previous threads on the git list about the transation.

However, an unfortunate and unsatisfactory situation has developed:
Christian Stimming's git-gui de.po uses a Ger translation, and Ralf
Thielow built core git's de.po on top of it, so it's also Ger.

Meanwhile, and independently, Sven Fuchs and Ralph Haussmann wrote a
translation of pro-git (which is also quite mature at this point, having
apparently begun in 2009), and as you probably guessed by now, it's G+E.

So that leaves us at a point where "the" libre Git book (and also the
one that happens to be hosted on git-scm.com, the official site) does
not match the terminology used by German git.

Like, at all.  They're not even remotely near each other.

Therefore, a total newbie would find at least one of those two totally
useless.  I haven't done a comprehensive survey yet, but it is my
impression that the commercial git books are also G+E, so the
hypothetical newbie would be stuck learning the English terms in one of
the two regardless.

So where to go from this mess?

Obviously -- unless the agreement is that the status quo should persist
-- we'd first have to sort out what the preferable translation should
be.  And I'm a bit scared of trying, except that a straw poll on IRC
gave me some hope that a simple majority vote could help settle it.

My vote is G+E.

After that, we should create a unified glossary.  Even in the G+E case,
a few terms would presumably be translated fully and some others might
have partial translations (checkout -> auschecken?).  The current
glossary for git's de.po is [2].  I have no idea what Sven and Ralph do.
Perhaps a github wiki page would be fine for everyone?

Finally, converting the existing translation will require some manpower.
I'll help review things, as I have previously done for translation
updates of core git de.po; perhaps with a few more volunteers it can be
done pretty quickly.

Thanks for your time.

- Thomas



[1]  http://thread.gmane.org/gmane.comp.version-control.git/58315
     http://thread.gmane.org/gmane.comp.version-control.git/156226/focus=156373
     http://thread.gmane.org/gmane.comp.version-control.git/196779/focus=196792

[2]  https://github.com/ralfth/git-po-de/wiki/Glossary

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
