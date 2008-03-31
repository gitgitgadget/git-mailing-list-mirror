From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 08:02:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803310757550.14670@woody.linux-foundation.org>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 17:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgLZ9-00088t-6D
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 17:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYCaPEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2008 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYCaPEI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 11:04:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41558 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751617AbYCaPEH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 11:04:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2VF2qIw008638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Mar 2008 08:02:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2VF2pEV012189;
	Mon, 31 Mar 2008 08:02:51 -0700
In-Reply-To: <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.723 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,OSDL_HIGH_ASCII_15,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78585>



On Sun, 30 Mar 2008, Junio C Hamano wrote:
>=20
> By the way, Linus, is your MUA UTF-8 challenged?  I see Bj=C3=B6rn's =
name on
> the To: header mangled.

My MUA is not utf-8 challenged per se, but it doesn't seem to like Bj=C3=
=B6rn's=20
headers.

=46or example, I see "=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>" perfectly=20
correctly (Content-Type: text/plain; charset=3DUTF-8), but Bj=C3=B6rn's=
 emails=20
tend to be (Content-Type: text/plain; charset=3Diso-8859-1) but then he=
 has=20
his email address in utf-8, and that seems to be what makes my MUA=20
unhappy about it.

			Linus
