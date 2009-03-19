From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Thu, 19 Mar 2009 12:22:04 +0100
Message-ID: <49C22ADC.6020404@drmicha.warpmail.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org> <49C22166.3000807@drmicha.warpmail.net> <alpine.DEB.1.00.0903191159110.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, ydirson@altern.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkGLs-0002HO-NA
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbZCSLWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 07:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbZCSLWW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 07:22:22 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52591 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbZCSLWV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 07:22:21 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 73D992F4B94;
	Thu, 19 Mar 2009 07:22:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 07:22:19 -0400
X-Sasl-enc: x9r3kq+WnbrWc7VYme2ekiMwXdaZ7GCTyMK7GAJpOWyi 1237461739
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4929D2E37C;
	Thu, 19 Mar 2009 07:22:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903191159110.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113762>

Johannes Schindelin venit, vidit, dixit 19.03.2009 12:00:
> Hi,
> 
> On Thu, 19 Mar 2009, Michael J Gruber wrote:
> 
>> cvsps development should procede wherever all cvsps developers can 
>> participate. It's not a central component of git.
> 
> You are forgetting a central fact to this discussion: cvsps is not 
> actively developed anymore.
> 
> Virtually all the "recent" patches going into cvsps (IIRC all patches 
> between the last two releases) were coming directly from the Git 
> community.

Well, then I guess "wherever all cvsps developers can participate" is de
facto here...

Still it's not in the git codebase. git cvsimport may expose cvsps short
comings, but testing cvsps in git's test suite does not seem right.

Michael
