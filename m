From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v3] import-tars: Allow per-tar author and commit message.
Date: Thu, 27 Aug 2009 07:42:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908270741170.6459@perkele.intern.softwolves.pp.se>
References: <20090826193015.962A7189B12@perkele>
 <7viqg96ehf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 08:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgYiD-0000n5-9k
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 08:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZH0Gnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 02:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbZH0Gnr
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 02:43:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38781 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751122AbZH0Gnq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 02:43:46 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000B1FW0YAR10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 08:43:46 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP0009AYVZLXH90@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 08:43:46 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.63324
Received: by perkele (Postfix, from userid 501)	id 822F0189B7B; Thu,
 27 Aug 2009 08:42:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 7F5AB1A97EE; Thu, 27 Aug 2009 07:42:57 +0100 (CET)
In-reply-to: <7viqg96ehf.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127143>

Junio C Hamano:

> Do you really want to slurp Committer:/Author: lines from _anywhere_ in 
> the file?  Wouldn't it make more sense to vaguely emulate e-mail message 
> format with headers, empty-line and then body that is free form?

I just tried not to overdo it, and keep the parsing code as simple as 
possible. I wasn't trying to implement an RFC 5322 compliant parser...

-- 
\\// Peter - http://www.softwolves.pp.se/
