From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Using url.insteadOf in git-clone
Date: Sun, 29 Jun 2008 20:59:11 +0200
Message-ID: <70C8B09D-0320-48E8-BEC8-5A75BBBA6364@ai.rug.nl>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <7vbq1msszw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 21:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD28Q-0004S3-9X
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 21:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbYF2S7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755642AbYF2S7O
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 14:59:14 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:37843 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbYF2S7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 14:59:14 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6106.online.nl (SMTP Server) with ESMTP id 6273770000A0;
	Sun, 29 Jun 2008 20:59:12 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6106.online.nl (SMTP Server) with ESMTP id F304B700009F;
	Sun, 29 Jun 2008 20:59:11 +0200 (CEST)
X-ME-UUID: 20080629185911995.F304B700009F@mwinf6106.online.nl
In-Reply-To: <7vbq1msszw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86818>


On 27 jun 2008, at 19:11, Junio C Hamano wrote:

> Pieter de Bie <pdebie@ai.rug.nl> writes:
>
>> [1] This is not really true. If I try that, I get an error:
>> Vienna:git pieter$ git fetch -v repo:dscho.git
>> fatal: I don't handle protocol 'it'
>>
>> If I change the url to "ggit://.." it does work. It seems there is an
>> off-by-one
>> error somewhere? It does work for another url.insteadOf I have in my
>> global
>> config though..
>
> What version of git is this?
>
> v1.5.5.1 and later contains 60e3aba (Fix config key miscount in
> url.*.insteadOf, 2008-04-12).
>

I think I tried this while testing the 1.5.5 clone.sh, so that's  
probably it.
Thanks.


- Pieter
