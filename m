From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 18:53:43 +0100
Message-ID: <vpqpr7havh4.fsf@bauges.imag.fr>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	<7vy6n065os.fsf@alter.siamese.dyndns.org>
	<7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	<94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	<7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	<94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	<20091025111438.GA11252@progeny.tock>
	<94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	<4AFBF18E.7070906@drmicha.warpmail.net>
	<20091114060600.6117@nanako3.lavabit.com>
	<94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
	<20091117210625.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 18:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NASGI-0006y6-V4
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 18:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbZKQRy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 12:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbZKQRy2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 12:54:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46149 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbZKQRy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 12:54:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAHHqgPY023199
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 18:52:42 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NASFM-0005Y4-3W; Tue, 17 Nov 2009 18:53:44 +0100
In-Reply-To: <20091117210625.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Tue\, 17 Nov 2009 21\:06\:25 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Nov 2009 18:52:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAHHqgPY023199
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259085164.85269@QKOMcBwlN/Banzrz/e8sQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133094>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I don't see how you can make them sanely be usable to 
> other commands like "git log v1.0.0..WORKTREE".

See what gitk is showing you when you have uncommited changes. You
have some kind of "pseudo-commits" on top of your history for the
index and the worktree. "git log v1.0.0..WORKTREE" could very well be
a text-mode version of what's already in gitk.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
