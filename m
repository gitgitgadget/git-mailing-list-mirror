From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 12:52:54 +0000
Message-ID: <19A8FAC6-A27A-4D6B-A276-02EE17F0E5F5@frim.nl>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>  <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>  <496EE74F.6000205@viscovery.net>  <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com> <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:21:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNS9O-0004FP-Je
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbZAONTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbZAONTM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:19:12 -0500
Received: from frim.nl ([87.230.85.232]:37470 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756037AbZAONTK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 08:19:10 -0500
Received: from cnat068.wlan.net.ed.ac.uk ([129.215.5.68] helo=c196001.wlan.net.ed.ac.uk)
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LNRiY-0007nq-3t; Thu, 15 Jan 2009 13:53:02 +0100
In-Reply-To: <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105796>


On Jan 15, 2009, at 12:36 PM, Johannes Schindelin wrote:

> If at all, I'd introduce 'examine' as a synonym to 'edit' (might be  
> more
> intuitive).
>
> However, for the same reason (is it intuitive?) I am not fully  
> convinced
> of 'amend' either.  Because --amend _can_ mean that you change the
> diff of the commit.  Maybe 'correct', 'redact' or 'rephrase'?

I think this demonstrates that you can do a lot more with 'edit' than  
just edit.
'redact' etc also don't cover it. Perhaps just a general 'pause' or  
something?

You can then put something like 'pause  --  pause, for example to  
amend commit'
in the description part.
