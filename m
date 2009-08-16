From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 00:15:49 +0200
Message-ID: <87ab1ze76y.fsf@master.homenet>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
	<alpine.LFD.2.01.0908161306340.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 00:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mco2e-0005Jp-28
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 00:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbZHPWRX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 18:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbZHPWRX
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 18:17:23 -0400
Received: from joe.mail.tiscali.it ([213.205.33.54]:53794 "EHLO
	joe.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbZHPWRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 18:17:22 -0400
Received: from master.homenet (84.223.200.129) by joe.mail.tiscali.it (8.0.022)
        id 49EC55CD037EB29A; Mon, 17 Aug 2009 00:17:13 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1Mco0z-00009i-Fa; Mon, 17 Aug 2009 00:15:49 +0200
In-Reply-To: <alpine.LFD.2.01.0908161306340.3162@localhost.localdomain> (Linus
	Torvalds's message of "Sun, 16 Aug 2009 13:10:20 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126084>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I pretty much can guarantee you that it improves things only because =
it=20
> makes gcc generate crap code, which then hides some of the P4 issues.
>
> I'd also suggest you try gcc-4.4, since that apparently fixes some of=
 the=20
> oddest spill issues.


Thanks for the hint.  I tried gcc-4.4 and it produces slower code than
4.3 on the gnulib SHA1 implementation and my patch makes it even more!

I noticed that on my machine your implementation is ~30-40% faster usin=
g
SHA_ROT for rol/ror instructions than inline assembly, at least with th=
e
test-case P=C3=A1draig wrote.  Am I the only one reporting it?

Cheers,
Giuseppe
