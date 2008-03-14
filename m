From: Sean <seanlkml@sympatico.ca>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 15:17:16 -0400
Message-ID: <BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	<alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
	<20080314183731.GA2994@atjola.homenet>
	<alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
	<m34pb9xgrp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 20:18:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaFQ2-00054X-4X
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 20:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYCNTRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 15:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbYCNTRi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 15:17:38 -0400
Received: from bay0-omc2-s7.bay0.hotmail.com ([65.54.246.143]:52605 "EHLO
	bay0-omc2-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892AbYCNTRi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 15:17:38 -0400
Received: from BAYC1-PASMTP15 ([65.54.191.189]) by bay0-omc2-s7.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 12:17:37 -0700
X-Originating-IP: [70.54.5.51]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.5.51]) by BAYC1-PASMTP15.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 14 Mar 2008 12:17:37 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JaGLD-0008Cp-LR; Fri, 14 Mar 2008 15:17:23 -0500
In-Reply-To: <m34pb9xgrp.fsf@localhost.localdomain>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 14 Mar 2008 19:17:37.0439 (UTC) FILETIME=[107A9AF0:01C88608]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77276>

On Fri, 14 Mar 2008 12:11:33 -0700 (PDT)
Jakub Narebski <jnareb@gmail.com> wrote:

> AFAIK the porcelain equivalent to plumbing
> 
>   git read-tree -u -m 3
> 
> is just
> 
>   git checkout 3 -- .

Hi Jakub,

   git checkout .   won't remove paths, so you could end up with extra
state that didn't exist in the earlier commit.

Sean
