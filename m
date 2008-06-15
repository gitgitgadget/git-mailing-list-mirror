From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] git add: add long equivalents of '-u' and '-f' options
Date: Sun, 15 Jun 2008 23:23:29 +0200
Message-ID: <20080615212329.GB7003@neumann>
References: <1213436881-2360-1-git-send-email-szeder@ira.uka.de>
	<200806142344.m5ENiLqk020529@mi0.bluebottle.com>
	<20080615085305.GA7003@neumann>
	<7vlk16cuu2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 23:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zim-0004yb-PT
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbYFOVXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYFOVXm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:23:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:50370 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYFOVXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:23:41 -0400
Received: from [127.0.1.1] (p5B13131C.dip0.t-ipconnect.de [91.19.19.28])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1K7zh93eNt-0004eM; Sun, 15 Jun 2008 23:23:31 +0200
Content-Disposition: inline
In-Reply-To: <7vlk16cuu2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+Z5KNe58OV2lchvGfbsvVLd/d/hGnQX1sxum6
 o/gbJtz3JLBCxcyNoKEUvGCDWinC54KhqUe0yCc51wyT5CNhdC
 SWOm+AgGrkIK7lMWLZQ8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85121>

On Sun, Jun 15, 2008 at 01:21:57PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > I think this patch is rather a bugfix in the user interface than a =
new
> > feature.
>=20
> Strictly speaking, this is a new feature but I think the documentatio=
n
> value to clarify -u stands for "update" is great enough to make it an
> exception.
Well, my reasoning was that every short option must have a long
equivalent, therefore the lack of long options is a bug (even if this
does not lead to e.g. a runtime error).

> I've rewritten (from empty!  Szeder, next time please write
> sensible commit log message to defend your changes, instead of having=
 _me_
> to defend your changes to others here, like this) the commit log mess=
age
> to clarify this point.
Sorry, I though the rationale behind the changes (i.e. "why?") is
trivial even from that one-liner:  add long options, because, well,
they do not exist.
In fact, I considered to write something like "these long options are
'--update' and '--force'" in the commit message.  But I dropped it,
because that explained _what_ the patch does, and I understood that
that should not go into the commit message.

Anyway, I will take care next time.

Regards,
G=E1bor
