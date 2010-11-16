From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] [WIP] Allow running git init on a remote repository
 specification.
Date: Tue, 16 Nov 2010 21:12:46 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1011162110300.13543@perkele.intern.softwolves.pp.se>
References: <cover.1289561504.git.peter@softwolves.pp.se>
 <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se>
 <AANLkTimqLeyDW9sJVR8NPOXQ1Xdz+kRmu9-8fPn1yj_j@mail.gmail.com>
 <alpine.DEB.2.00.1011160632280.20293@ds9.cixit.se>
 <7vbp5pi20z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 21:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIRtq-0004QA-MK
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 21:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335Ab0KPUM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 15:12:58 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52179 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755631Ab0KPUM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 15:12:57 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBZ006LGUTKZ080@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Nov 2010 21:12:56 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3CCDC1EA55FB_CE2E5C8B	for <git@vger.kernel.org>; Tue,
 16 Nov 2010 20:12:56 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0A90D1EA2B2C_CE2E5C8F	for <git@vger.kernel.org>; Tue,
 16 Nov 2010 20:12:56 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBZ00D12UTJWF10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Nov 2010 21:12:56 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id D67A42FC06; Tue,
 16 Nov 2010 21:12:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id D4EAF2FC04; Tue, 16 Nov 2010 21:12:46 +0100 (CET)
In-reply-to: <7vbp5pi20z.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161585>

Junio C Hamano:

> Didn't we discuss this long time ago and decided, if anything is to be 
> done, it would be something like "the first push creates"?

I have probably missed that reference. But you mean to instead set up an 
empty repository, with a configured remote? That is an interesting 
alternative, but would still fail as there still is no way to initialize a 
new repository on the remote.

But I am definitely open to fix it properly, I just haven't been able to 
figure out how to do that yet.

-- 
\\// Peter - http://www.softwolves.pp.se/
