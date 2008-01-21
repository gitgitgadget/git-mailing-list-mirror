From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Sun, 20 Jan 2008 21:21:13 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 06:21:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGp6c-0000Dk-2U
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 06:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbYAUFV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 00:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbYAUFV2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 00:21:28 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55714 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834AbYAUFV1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 00:21:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0L5LEKO012270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 21:21:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0L5LDnX018818;
	Sun, 20 Jan 2008 21:21:14 -0800
In-Reply-To: <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.424 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_34
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71220>



On Sun, 20 Jan 2008, Junio C Hamano wrote:
>=20
>  * marking output from "diff --{no,src,dst}-prefix" as a non-git
>    diff (me)
>=20
>    Linus had an objection but I think I made a reasonable
>    argument against that.  Haven't heard back since then, so
>    this is in limbo.

I just didn'=CD=84t really care enough. I still don't think the prefix =
has=20
anything to do with git'ness, but at the same time it's just not someth=
ing=20
I'll ever use, so..

>  * various lstat(2) reduction changes (me, Linus and Dscho).
>=20
>    This will be queued in 'pu'; it appears this introduces a
>    timing related breakages in t75?? tests.

Can you send some more info on this? I obviously like that series, and=20
I've been running various versions of it for a while now, and have run=20
"make test" a lot. Haven't seen any failures (except the ones I've=20
introduced while developing), but would be happy to see reports.

			Linus
