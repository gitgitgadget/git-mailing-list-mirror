From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or failure message
Date: Tue, 13 Jul 2010 23:16:48 +0200
Message-ID: <201007132316.48645.chriscool@tuxfamily.org>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org> <20100712182733.GD17630@debian>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:17:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmqV-00038G-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab0GMVQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:16:51 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:35718 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab0GMVQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:16:50 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 98890800062F;
	Tue, 13 Jul 2010 23:16:49 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 8A5D380008F5;
	Tue, 13 Jul 2010 23:16:49 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 6456D800062F;
	Tue, 13 Jul 2010 23:16:49 +0200 (CEST)
X-ME-UUID: 20100713211649411.6456D800062F@mwinf2f14.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100712182733.GD17630@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150916>

Hi Ram,

On Monday 12 July 2010 20:27:33 Ramkumar Ramachandra wrote:
> Hi Christian,
> 
> Christian Couder writes:
> > This patch refactors the code that prints a message like
> > "Automatic cherry-pick failed. <help message>". This code was
> 
> [...]
> 
> This is good stuff. Can we expect the git-rebase--interactive.sh to be
> refactored to use the "cherry pick a range" feature in future?

I am trying to improve cherry-pick step by step so that hopefully in the end 
we have some sequencer like functionalities. So yes, I hope that it will be 
possible to refactor git-rebase--interactive.sh and perhaps other such shell 
scripts.

Thanks,
Christian.
