From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: Re* [PATCH] builtin-rerere: fix conflict markers parsing
Date: Tue, 08 Jul 2008 12:42:05 +0200
Message-ID: <4873447D.5090208@free.fr>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr> <alpine.DEB.1.00.0807071400180.18205@racer> <7vy74d4mr8.fsf@gitster.siamese.dyndns.org> <7vwsjwvmlk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAek-0003JA-Ve
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYGHKlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 06:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYGHKlu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:41:50 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52179 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbYGHKlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:41:49 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3298712B6B6;
	Tue,  8 Jul 2008 12:41:48 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0A2FE12B721;
	Tue,  8 Jul 2008 12:41:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vwsjwvmlk.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87744>

Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> I am wondering if a patch like this on top of your patch may make thi=
ngs
> even safer.  The idea is the same as the earlier a1b32fd (git-rerere:
> detect unparsable conflicts, 2008-06-22) to fail rerere unless the ma=
rkers
> are unambiguous.
>=20
> Thanks to your isspace(buf[7]), it is slightly less likely that this
> safety triggers on false positives.
>=20
> Thoughts?

My main concern was the error message that most users will not understa=
nd
after a "git rebase --continue", for example. So, I tried to remove it =
and
let things work as before because rerere seems to work even with ambigu=
ous
cases.

But I think your patch is the right thing to do: safe is better.

Olivier.
