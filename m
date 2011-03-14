From: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>
Subject: git bisect plus fixes (was: PATCH: Add --size-check=[error|warning])
Date: Mon, 14 Mar 2011 14:16:23 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110314131623.119020@gmx.net>
References: <20110311165802.GA3508@intel.com>
 <4D7A64670200007800035F4C@vpn.id2.novell.com>
 <AANLkTikG8wa1Em0bEUddbYpYs2TzFFTDb95qWFJ3xSbv@mail.gmail.com>
 <4D7DE39302000078000362E6@vpn.id2.novell.com>
 <20110314095534.GB18058@elte.hu>
 <20110314104131.GG6275@bubble.grove.modra.org> <20110314122342.GA26825@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	binutils@sourceware.org, linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 14:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz7dW-0006zk-PB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 14:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab1CNNQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 09:16:28 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:34351 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753467Ab1CNNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 09:16:27 -0400
Received: (qmail 27823 invoked by uid 0); 14 Mar 2011 13:16:25 -0000
Received: from 131.220.223.4 by www168.gmx.net with HTTP;
 Mon, 14 Mar 2011 14:16:23 +0100 (CET)
In-Reply-To: <20110314122342.GA26825@elte.hu>
X-Authenticated: #13673931
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Mutt-Fcc: =git
X-Mutt-References: <20110314122342.GA26825@elte.hu>
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1+86LdEcsC83AfpL64lSuTjzb+WnFcD5/aFJg5ZfI
 Tbw8HrecaezDupFW31Ot3CowzX5X5aYFk+/g== 
X-GMX-UID: RnkVJTd7TlI8TqPAp2hrBBZOU2poZZne
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168986>

[ adding the git list; this is
  http://thread.gmane.org/gmane.comp.gnu.binutils/52601/focus=1112779 ]

Hello,

* Ingo Molnar wrote on Mon, Mar 14, 2011 at 01:23:42PM CET:
> Also, i hope you are not suggesting to break projects just because
> they are not important to you personally? The fix is exceedingly
> simple to do for the binutils project - and impossible to do for the
> kernel project (because during bisection - which is a very powerful
> debugging tool - older versions of the source get checked out).

FWIW, I don't have an opinion on this particular binutils issue, but
it would be very helpful if 'git bisect' made it easy to denote
"when going back, you might also need some of these changes".
(I'd just use a patch -p1 with a here-file in the bisect script, but
that might not be enough for all practical use cases.)

This issue has come up several times with high-profile issues.

Thanks,
Ralf
