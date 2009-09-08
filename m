From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: tracking branch for a rebase
Date: Wed, 9 Sep 2009 00:17:37 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0909090003330.6055@reaper.quantumfyre.co.uk>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <4AA4D81A.1030203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 01:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlA0e-0002A8-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 01:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZIHXVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZIHXVZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 19:21:25 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43370 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbZIHXVY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 19:21:24 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 3004332D97F
	for <git@vger.kernel.org>; Wed,  9 Sep 2009 00:21:26 +0100 (BST)
Received: (qmail 10340 invoked by uid 103); 9 Sep 2009 00:17:37 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9782. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025755 secs); 08 Sep 2009 23:17:37 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 9 Sep 2009 00:17:37 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <4AA4D81A.1030203@drmicha.warpmail.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128049>

On Mon, 7 Sep 2009, Michael J Gruber wrote:

> Solution needs to be:
> - practical (short, clear)
> - not too brutal (on existing users of legal "exotic" refnames)
> - extensible (for later uses)

How about '/^' and 'ref/^'?  Since you can't create a ref ending / ...

-- 
Julian

  ---
When you ask a question, do you truly want to know the answer, or are you
merely flaunting your power?

   -- DMITRI HARKONNEN, Notes to My Sons
