From: Geert Bosch <bosch@adacore.com>
Subject: Re: git-log fatal error in empty repo
Date: Fri, 8 Jun 2007 22:31:21 -0400
Message-ID: <9EDDBC9D-EE20-4158-AF77-E46B1DD0BC74@adacore.com>
References: <588192970706070634s4c25ae45g68be32c06a30d043@mail.gmail.com> <7vps47o6eh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Steve Hoelzer" <shoelzer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 04:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwqje-0004Ka-CX
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 04:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbXFICbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 22:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbXFICbZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 22:31:25 -0400
Received: from nile.gnat.com ([205.232.38.5]:49546 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbXFICbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:31:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 96C2A48CE24;
	Fri,  8 Jun 2007 22:31:23 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 02875-01-4; Fri,  8 Jun 2007 22:31:23 -0400 (EDT)
Received: from [172.16.1.98] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 35A0D48CBFC;
	Fri,  8 Jun 2007 22:31:23 -0400 (EDT)
In-Reply-To: <7vps47o6eh.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49551>


On Jun 7, 2007, at 16:29, Junio C Hamano wrote:
> Maybe, but I highly doubt if it is worth to bother about it.

My first confusion with git was exactly this issue.
It's very normal for a new user to do a git init
and than try to verify that the current state is a sane
empty repository.

So, git log, git status and git fsck should all properly
handle this situation and give reasonable output in this case.

   -Geert
