From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Wed, 4 Jun 2008 01:10:20 +0200
Message-ID: <20080603231020.GB6588@neumann>
References: <200806030314.03252.jnareb@gmail.com>
	<alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
	<7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
	<7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
	<20080603104009.GA559@neumann>
	<7vabi22u5h.fsf@gitster.siamese.dyndns.org>
	<20080603203924.GA6588@neumann>
	<7vk5h6189b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 01:11:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ffK-000403-3D
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 01:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbYFCXKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbYFCXKv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 19:10:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56696 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbYFCXKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 19:10:50 -0400
Received: from [127.0.1.1] (p5B133079.dip0.t-ipconnect.de [91.19.48.121])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1K3fe01xPL-0004Yw; Wed, 04 Jun 2008 01:10:21 +0200
Content-Disposition: inline
In-Reply-To: <7vk5h6189b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/VIHkB0TlcfcmHBYqjqGhYxQ8fVA1DL1DDbWj
 uatbDMKFXYNi/yTUG+Ee015+6ZJpz8zQ+nFYqMoEqPLGjoHh/I
 HK6RHuF+ByoPOdSK2lsbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83726>

On Tue, Jun 03, 2008 at 03:08:48PM -0700, Junio C Hamano wrote:
> Here is a potential fix.
>=20
> The first hunk is the more relevant one; although the second one is a=
lso a
> fix, it is independent.  It is a fix to unnecessarily loosely written=
 test
> that was done in early February.
Yes, the first hunk fixes the problem (and the second one does not
introduce any new breakage on my system ;)

However, I don't really see why the new test failed only at me...

Thanks,
G=E1bor
