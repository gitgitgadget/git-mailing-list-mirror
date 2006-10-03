From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 03 Oct 2006 02:34:47 -0700
Message-ID: <7vzmcdpwso.fsf@assigned-by-dhcp.cox.net>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
	<200610022203.44733.jnareb@gmail.com>
	<7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
	<200610031018.40273.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 11:36:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUggV-0003bB-V5
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWJCJet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWJCJet
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:34:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43216 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932311AbWJCJes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 05:34:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003093448.DEHD6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 05:34:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vlaq1V0081kojtg0000000
	Tue, 03 Oct 2006 05:34:50 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28262>

BTW,

 - why do we have shortlog and log twice in the top navigation
   bar in commit view (a=commit)?

 - sometimes I'd like to view my tags sorted by name not by
   age.  Maybe we could add <sort-by> control on the age and
   name columns for git_tags_body()?
