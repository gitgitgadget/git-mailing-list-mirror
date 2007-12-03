From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Mon, 3 Dec 2007 14:10:21 +0100
Message-ID: <20071203131021.GA9674@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com> <Pine.LNX.4.64.0711282039430.27959@racer.site> <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <20071201203759.GA11710@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 14:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzBGH-00065T-1J
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 14:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXLCNWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXLCNWl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 08:22:41 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4860 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXLCNWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 08:22:40 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IzB41-0002Yb-00; Mon, 03 Dec 2007 13:10:21 +0000
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071201203759.GA11710@atjola.homenet>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66918>

On 2007-12-01 21:37:59 +0100, Bj=F6rn Steinbrink wrote:

> So how about adding --fetch/--no-fetch (maybe with a configurable
> default?) to git-merge/git-rebase and deprecate git-pull over time?

=46WIW, I like this idea. rebase/merge is the complicated part of the
operation, so the UI should focus on that. Updating or not updating
the remote-tracking branch that is merged from/rebased on is a simple
binary choice, so a flag is perfect.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
