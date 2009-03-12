From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 16:40:10 +0000
Message-ID: <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com> <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com> <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl> <20090312153738.GA24690@coredump.intra.peff.net> <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com> <20090312163533.GA28205@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhnyg-0006kN-20
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZCLQkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 12:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbZCLQkV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:40:21 -0400
Received: from frim.nl ([87.230.85.232]:42764 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508AbZCLQkU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:40:20 -0400
Received: from vpn-014.vpn.net.ed.ac.uk ([129.215.37.14])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Lhnx9-0000xd-QI; Thu, 12 Mar 2009 17:40:15 +0100
In-Reply-To: <20090312163533.GA28205@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113087>


On Mar 12, 2009, at 4:35 PM, Jeff King wrote:

> I think the future-proofing is probably not worth the effort. Catching
> things that are ambiguous _now_ will cover the "oops, I typed the  
> wrong
> thing" case, which I think is really the issue.

Exactly, that's the common case where things go wrong. I guess using  
dwim_ref
should be DWIM enough? :)

- Pieter
