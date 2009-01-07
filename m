From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 08 Jan 2009 09:15:17 +1300
Message-ID: <1231359317.6011.12.camel@maia.lan>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
	 <20081104152351.GA21842@artemis.corp>
	 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
	 <20081104004001.GB29458@artemis.corp>
	 <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
	 <20081104083042.GB3788@artemis.corp>
	 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
	 <20081104152351.GA21842@artemis.corp>
	 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
	 <20090106111712.GB30766@artemis.corp>
	 <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKepi-0002Bf-MH
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbZAGUPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbZAGUPb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:15:31 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48810 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbZAGUPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:15:30 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id DCFC321C517; Thu,  8 Jan 2009 09:15:27 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id EF97A21C38D;
	Thu,  8 Jan 2009 09:15:17 +1300 (NZDT)
In-Reply-To: <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104827>

On Tue, 2009-01-06 at 20:40 +0100, Johannes Schindelin wrote:
> Although I would like to see it in once it is fleshed out -- even if it 
> does not meet our usefulness standard -- because people said Git is 
> inferior for not providing a patience diff.  If we have --patience, we can 
> say "but we have it, it's just not useful, check for yourself".

Whatever happens, the current deterministic diff algorithm needs to stay
for generating patch-id's... those really can't be allowed to change.

Sam.
