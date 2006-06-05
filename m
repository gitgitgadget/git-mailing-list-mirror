From: Sean <seanlkml@sympatico.ca>
Subject: Re: irc usage..
Date: Mon, 5 Jun 2006 12:07:43 -0400
Message-ID: <BAYC1-PASMTP029677186C792C538C1921AE940@CEZ.ICE>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
	<46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
	<447D043D.1020609@gentoo.org>
	<46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
	<447DA028.3040606@gentoo.org>
	<46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
	<447E4611.7000309@gentoo.org>
	<46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
	<44837BDB.2090601@gentoo.org>
	<46a038f90606041906k66d85152v6e402c65151d7ab8@mail.gmail.com>
	<448398BC.5090402@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, spyderous@gentoo.org, torvalds@osdl.org,
	ydirson@altern.org, git@vger.kernel.org, smurf@smurf.noris.de,
	Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Jun 05 18:08:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnHd5-0000He-97
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 18:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWFEQIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 12:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWFEQIc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 12:08:32 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:15318 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750929AbWFEQIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 12:08:31 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Jun 2006 09:08:30 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0582C644C28;
	Mon,  5 Jun 2006 12:08:29 -0400 (EDT)
To: antarus@gentoo.org
Message-Id: <20060605120743.566fb85f.seanlkml@sympatico.ca>
In-Reply-To: <448398BC.5090402@gentoo.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 Jun 2006 16:08:30.0655 (UTC) FILETIME=[4996C4F0:01C688BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 04 Jun 2006 22:36:44 -0400
Alec Warner <antarus@gentoo.org> wrote:

> I'll keep chugging on this one; it won't be the final import as I 
> haven't used the complete Authors file, so I will try the repacking 
> optimization next time I do an import.

Hi Alec,

You may want to go back and do another import for other reasons, but if
the only reason is to fix up the author information it would be _much_
faster to simply rewrite the git commit history.  Cogito has something
called "cg-admin-rewritehist" which should do what you need and there
are other scripts floating around specificially for rewriting just the
author information.

HTH,
Sean
