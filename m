From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 21:17:00 +0100
Message-ID: <238738C7-960C-4847-A7F0-137712F7A7E8@wincent.com>
References: <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com> <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net> <alpine.LFD.1.00.0802140945520.2732@xanadu.home> <20080214151752.GB3889@coredump.intra.peff.net> <alpine.LFD.1.00.0802141103280.2732@xanadu.home> <20080214163101.GA24673@coredump.intra.peff.net> <alpine.LFD.1.00.0802141147200.2732@xanadu.home> <20080214175724.GA30689@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkY7-0000fQ-5L
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 21:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbYBNUSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 15:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760668AbYBNUSE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 15:18:04 -0500
Received: from wincent.com ([72.3.236.74]:53818 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763601AbYBNUSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2008 15:18:01 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1EKH1rK017796;
	Thu, 14 Feb 2008 14:17:02 -0600
In-Reply-To: <20080214175724.GA30689@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73914>

El 14/2/2008, a las 18:57, Jeff King escribi=F3:

> Of course the 'bar' commit is not lost. My point is not that you are
> losing commits this way, it is that finding the commit you wanted
> becomes more difficult (e.g., asking "what was at the tip of the =20
> branch
> when it was deleted").

I agree that keeping around reflogs for deleted branches would be a =20
nice convenience, provided they were pruned after an appropriate =20
interval. Space isn't really the concern, but clutter is, and that can =
=20
be fixed with pruning.

Cheers,
Wincent
