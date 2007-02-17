From: Junio C Hamano <junkio@cox.net>
Subject: Re: test suite failures because cmp behaves oddly
Date: Sat, 17 Feb 2007 15:03:32 -0800
Message-ID: <7v3b54s7y3.fsf@assigned-by-dhcp.cox.net>
References: <200702172225.12758.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIYag-000490-Gb
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXBQXDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbXBQXDe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:03:34 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47461 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXBQXDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:03:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217230333.DEYZ21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 18:03:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qn3Z1W0061kojtg0000000; Sat, 17 Feb 2007 18:03:33 -0500
In-Reply-To: <200702172225.12758.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 17 Feb 2007 22:25:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40018>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Does anyone know how 'cmp' can signal success when its output is redirected 
> to /dev/null, even if the compared files are different?
>
> $ cmp M.sum actual7.sum; echo $?
> M.sum actual7.sum differ: char 20, line 2
> 1
> $ cmp M.sum actual7.sum > /dev/null; echo $?
> 0
> ...
> Has anyone seen something like this?

I vaguely recall this reported long time ago from one of the
regulars on the list, but googling or gmane search came up
empty.
