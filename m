From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 23:50:04 +0100
Message-ID: <B27EC8CF-482D-499B-B4E0-019049926C93@ai.rug.nl>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site> <alpine.LFD.1.00.0803121143170.2947@xanadu.home> <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl> <alpine.LSU.1.00.0803121705330.1656@racer.site> <20080312170155.GB11236@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZmg-000356-JN
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYCLWuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbYCLWuI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:50:08 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:56330 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbYCLWuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:50:07 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6006.orange.nl (SMTP Server) with ESMTP id 358C9700008A
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 23:50:05 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6006.orange.nl (SMTP Server) with ESMTP id CF8A87000081;
	Wed, 12 Mar 2008 23:50:04 +0100 (CET)
X-ME-UUID: 20080312225004850.CF8A87000081@mwinf6006.orange.nl
In-Reply-To: <20080312170155.GB11236@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77018>


On Mar 12, 2008, at 6:01 PM, Jeff King wrote:

> On Wed, Mar 12, 2008 at 05:05:51PM +0100, Johannes Schindelin wrote:
>
>>> I'd really like it to be at least 2 weeks
>>
>> Could you back that up with an explanation, as to why?
>
> I assume it's "because I wouldn't want to lose work I had done within
> the last two weeks." Yes, I know that this expiration is actually  
> after
> the reflog has already expired

Ah, I hadn't realised that. Then I don't really care, one week sounds  
fine too. 2 weeks just seemed a bit short, as the default reflog is 30  
days. But if it's 2 weeks after the 30 days, that should be more than  
enough

- Pieter
