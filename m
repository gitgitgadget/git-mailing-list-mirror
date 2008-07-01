From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 20:01:09 +0200
Message-ID: <20080701180109.GA14026@atjola.homenet>
References: <20080701091347.GA11817@elte.hu> <7vlk0mne5d.fsf@gitster.siamese.dyndns.org> <20080701100725.GE31309@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 20:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDkB9-00016x-7D
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 20:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYGASBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 14:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYGASBO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 14:01:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:39689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbYGASBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 14:01:13 -0400
Received: (qmail invoked by alias); 01 Jul 2008 18:01:10 -0000
Received: from i577BBF97.versanet.de (EHLO atjola.local) [87.123.191.151]
  by mail.gmx.net (mp042) with SMTP; 01 Jul 2008 20:01:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1986cM5feJ8JXgBSCzG12k6nLgZZOsw9wEC8EDG6G
	wA7J4yC0rkr13Z
Content-Disposition: inline
In-Reply-To: <20080701100725.GE31309@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87059>

On 2008.07.01 12:07:25 +0200, Ingo Molnar wrote:
> There's a small detail i was thinking about: is there a way to get th=
is=20
> extra output without actually switching branches? Right now i do this=
:
>=20
>  earth4:~/tip> git-checkout tip; git-checkout master
>  Checking out files: 100% (2437/2437), done.
>  Switched to branch "tip"
>  Switched to branch "master"
>  Your branch is ahead of the tracked remote branch 'origin/master' by
>  50 commits.
>=20
> (Which is an admitted lame solution but the best i could figure.)

Just "git checkout" works for me:
git (master) $ git checkout
Your branch is behind the tracked remote branch 'origin/master' by 6 co=
mmits,
and can be fast-forwarded.

Bj=F6rn
