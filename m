From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH] gitweb: New feature last_modified_ref.
Date: Sat, 30 Dec 2006 00:12:18 +0000
Message-ID: <20061230001218.GH6558@localhost>
References: <20061229185805.GF6558@localhost> <7vlkkqms8n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 01:12:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0Rpj-0008Sj-ME
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 01:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbWL3AMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 19:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbWL3AMO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 19:12:14 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:51596 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078AbWL3AMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 19:12:13 -0500
Received: from 213-202-190-9.bas504.dsl.esat.net ([213.202.190.9] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H0RpO-0005MX-Qk; Sat, 30 Dec 2006 00:11:58 +0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkkqms8n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35611>

> I somehow suspect this is solving the problem with a wrong
> tradeoff.

I think the main problem is that we are trying to fix possible
performance problems with the latest version, just because they might
cause a major problem on kernel.org.

At this point I think we should get the latest version loaded and see
what the real problems are.

Robert
