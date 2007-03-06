From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Mon, 05 Mar 2007 22:55:11 -0800
Message-ID: <7v649euai8.fsf@assigned-by-dhcp.cox.net>
References: <45ECE700.8090205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Li Yang <leoli@freescale.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:55:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOTZt-0000cM-AG
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 07:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965814AbXCFGzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 01:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965815AbXCFGzO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 01:55:14 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39923 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965814AbXCFGzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 01:55:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306065511.VXSB1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 01:55:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XJvB1W00N1kojtg0000000; Tue, 06 Mar 2007 01:55:12 -0500
In-Reply-To: <45ECE700.8090205@freescale.com> (Li Yang's message of "Tue, 06
	Mar 2007 11:58:56 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41544>

Li Yang <leoli@freescale.com> writes:

> Change to use explicitly function call cgi->escapHTML().
> This fix the problem on some systems that escapeHTML() is not
> functioning, as default CGI is not setting 'escape' parameter.
>
> Signed-off-by: Li Yang <leoli@freescale.com>

Regardless of the recent xhtml+html vs html discussion, I think
this is probably a sane change.  Comments?
