From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 22:30:26 +0200
Message-ID: <87bo92l5el.fsf@hexa.v.cablecom.net>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	"Simon Ruderich" <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSoO-0004vk-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164Ab3DYUac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:30:32 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25872 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758806Ab3DYUaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:30:30 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 22:30:24 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 22:30:26 +0200
In-Reply-To: <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 14:20:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222442>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> But I do not care that much really. The patch is good either way, if
> you don't like it, you go ahead and fix it, because I won't. I have
> 174 remote-helper related patches in my queue, and nobody benefits
> from rambling about a one liner that is obviously correct, not you,
> not me, not the users, not the developers.

You don't stick to the rules of this project, which have been pointed
out already:

  The body should provide a meaningful commit message, which:

    . explains the problem the change tries to solve, iow, what is wrong
      with the current code without the change.

    . justifies the way the change solves the problem, iow, why the
      result with the change is better.

    . alternate solutions considered but discarded, if any.

Your project is moving too fast to put up with the established
procedures in this community.

In fact you are pretty much holding us hostage with a "take it or keep
it broken while causing more work" attitude:

> Junio of course might disagree and drop this patch, but then he would
> need to deal with the fallout of possible conflicts.

You did not respond well to reviews and criticism.  Even the
constructive fine-let's-do-the-work-for-him kind that Peff offered.

And on top of that, remote helpers are written against an interface that
was designed to allow working with external programs.

So why is this in git.git?

Why should we take any more contrib additions from you?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
