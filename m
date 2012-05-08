From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Please review this pull request for maint branch with update of de.po
Date: Tue, 8 May 2012 09:32:20 +0200
Message-ID: <87ipg75drv.fsf@thomas.inf.ethz.ch>
References: <CANYiYbFf73hVen2sg1viNrXxt-g+tP=bF_ryBF8JYp0ZAL0b6A@mail.gmail.com>
	<CANYiYbFiwvy8Lw+XQTehbc3k2FukrvhCvR6urfAR_3xVqXxNZA@mail.gmail.com>
	<7vtxzr1kbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 08 09:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SReuN-0001wF-EY
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 09:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2EHHc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 03:32:27 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:41663 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2EHHc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 03:32:26 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 8 May
 2012 09:32:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.195) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 8 May
 2012 09:32:24 +0200
In-Reply-To: <7vtxzr1kbd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 7 May 2012 19:24:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.195]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197345>

[+cc Pat]

Junio C Hamano <gitster@pobox.com> writes:

>  - git-gui/ part of my tree is maintained without the rest of git.git/
>    tree by Pat Thoyts, and an update needs to go through that tree. I
>    cannot take a change directly to that part.  Doing so would make
>    it impossible to update git-gui/ project independently.
>
> Please redo your tree by having the originating author separate the
> git-gui part out, make sure everybody on the l10n team is happy with the
> result, and then throw me another pull request.  Also arrange the git-gui
> patch to go through Pat.

I suspected something like this might happen, but proposed a
simultaneous change anyway.  My bad.  Ralf, can you split it or should I
resend?

But for next time, can there be another solution?  It seems that this
process will make it very hard in general to keep the git-gui and core
git translations in sync.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
