From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 11:32:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:34:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5C8-0000ML-F8
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYKCTdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 14:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbYKCTdV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:33:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59401 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbYKCTdU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:33:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JWdRT021964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 11:32:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JWbgJ022473;
	Mon, 3 Nov 2008 11:32:38 -0800
In-Reply-To: <200811031439.12111.brian.foster@innova-card.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, 3 Nov 2008, Brian Foster wrote:
>=20
>   A colleague and I recently wanted to examine the
>  history in a broad sense without worrying too much
>  about the individual commits.  What we (think we)
>  wanted is a =E2=80=98gitk --all=E2=80=99 history graph showing only
>  =E2=80=9Cnamed=E2=80=9D historical points;

Ok, this is actually really easy to do with git. We have all the=20
infrastructure in place, and what you're asking for is fundamentally=20
really just an odd form of commit history simplification. Instead of=20
comparing the *contents* of the commits (the trees) to see if they are=20
interesting, you'd only check if there is a decoration (ie a tag or a=20
branch) pointing to the commit.

I'll post a simple series of four commits in a moment. They're all=20
trivial, and the first three are just setting stuff up (in fact, the ve=
ry=20
first one is a commit I've already posted, and it's technically totally=
=20
unrelated, but since it touches the same area as one of the other ones,=
=20
I'm too lazy to try to separate it out).

Patchbombing to commence in 5.. 4.. 3.. 2.. 1..

		Linus
