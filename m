From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: maildir / read-tree trivial merging getting in the way?
Date: Tue, 14 Feb 2006 02:35:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.60.0602140231340.19093@mundungus.clifford.ac>
References: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
 <7vy80ewu6n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:39:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8q6D-00030R-Pl
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWBNCj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWBNCj0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:39:26 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:51589 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750962AbWBNCjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 21:39:25 -0500
Received: from mundungus.clifford.ac (mundungus.clifford.ac [81.187.211.39])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k1E2dJvi010795
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 02:39:25 GMT
Received: from mundungus.clifford.ac (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k1E2ZrF3002255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Feb 2006 02:35:53 GMT
Received: from localhost (benc@localhost)
	by mundungus.clifford.ac (8.13.3/8.13.3/Submit) with ESMTP id k1E2Zq9Q002252;
	Tue, 14 Feb 2006 02:35:52 GMT
X-Authentication-Warning: mundungus.clifford.ac: benc owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80ewu6n.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16106>

On Mon, 13 Feb 2006, Junio C Hamano wrote:

>
> That would be more naturally done by writing that thing in a
> more reasonable scripting language (not shell, but Perl or
> Python), call ls-tree three times, do whatever merge to come up
> with the final shape of the tree, and then construct the tree
> with a single invocation of "update-index --index-info", maybe
> even starting from an empty index file.

yeah, looks like ls-tree x 3 is what I want and quite possibly I'll end up 
constructing a new index from scratch.

-- 
Ben
http://www.hawaga.org.uk/ben/
