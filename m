From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Fri, 20 Jun 2008 00:58:06 +0200
Message-ID: <12AB50C8-6CBF-4D96-8FAB-90234A9006D0@ai.rug.nl>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0806191459150.6439@racer> <20080619154350.GA21625@atjola.homenet> <7vr6attey8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9T61-0000h0-5u
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYFSW6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYFSW6J
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:58:09 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:60712 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbYFSW6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:58:08 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 70D4B7000091;
	Fri, 20 Jun 2008 00:58:07 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 17BAF7000081;
	Fri, 20 Jun 2008 00:58:06 +0200 (CEST)
X-ME-UUID: 20080619225807972.17BAF7000081@mwinf6007.online.nl
In-Reply-To: <7vr6attey8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85557>


On 19 jun 2008, at 21:14, Junio C Hamano wrote:

>> Hm, --rebasing sounds weird to me as well. Maybe --track=merge and
>> --track=rebase, with --track being equal to --track=merge?
>
> That looks like the best wording so far, although I suspect that the  
> true
> reason why all of the above sounds confusing may be because the  
> concept
> itself is not clear.

That's why I suggested --auto-rebase, which is more verbose in what
it does. Perhaps we should add it as an optional flag for --track, like

   git branch --track --auto-rebase local remote/branch

? That is a bit long though.

I don't think "--track=rebase" makes a lot of sense, since "track" is
still a boolean in my head ;)
