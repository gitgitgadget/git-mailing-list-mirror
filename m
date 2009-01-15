From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 12:57:04 +0000
Message-ID: <8B5B7148-B900-4E01-9B2C-16C251966F7F@frim.nl>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>  <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>  <496EE74F.6000205@viscovery.net>  <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com> <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNS99-00046E-49
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbZAONTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbZAONTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:19:09 -0500
Received: from frim.nl ([87.230.85.232]:37467 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755823AbZAONTI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 08:19:08 -0500
X-Greylist: delayed 1555 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jan 2009 08:19:08 EST
Received: from cnat068.wlan.net.ed.ac.uk ([129.215.5.68] helo=c196001.wlan.net.ed.ac.uk)
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LNRma-0008GQ-I3; Thu, 15 Jan 2009 13:57:12 +0100
In-Reply-To: <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105795>


On Jan 15, 2009, at 12:36 PM, Johannes Schindelin wrote:

> BTW I was not fully happy with 'edit' back then, either, which is the
> reason why I showed the usage in the comment _above_ the commit  
> list.  But
> nobody could suggest a name that I found convincingly better.

(BTW, I reply to this thread because I'm also often confused with the
rebase. The thing that hits me most is that with resolving conflicts,
you have to do a 'git commit' and with 'edit', you have to do a 'git
commit --amend'. This can get confusing if you set up an interactive
rebase where you have some new picks or squashes, and also an edit.
If the rebase stops, you first have to carefully read whether you're
supposed to do a 'git commit' or a 'git commit --amend', and remember
that until you're finished with the changes).

- Pieter
