From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 10:21:21 +0100
Message-ID: <4F997D24-1853-4B53-9865-F456ECA43FD7@wincent.com>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain> <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 10:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZjef-0003av-Ro
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 10:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYCMJWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYCMJWU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 05:22:20 -0400
Received: from wincent.com ([72.3.236.74]:38739 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbYCMJWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 05:22:20 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2D9Liti002933;
	Thu, 13 Mar 2008 04:21:45 -0500
In-Reply-To: <alpine.LSU.1.00.0803122153440.1656@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77055>

El 12/3/2008, a las 21:55, Johannes Schindelin escribi=F3:

> Alas, git-prune recently learnt the option --expire <minimum-age>, =20
> which
> makes it a much safer operation.  This allows us to call prune from =20
> git-gc,
> with a grace period of 2 weeks for the unreferenced loose objects =20
> (this
> value was determined in a discussion on the git list as a safe one).

Just a really minor quibble: I don't think you mean "alas" here; =20
"alas" basically means "unfortunately" or "regrettably".

Cheers,
Wincent
