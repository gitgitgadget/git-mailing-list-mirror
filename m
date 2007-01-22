From: Junio C Hamano <junkio@cox.net>
Subject: Re: make rpm
Date: Sun, 21 Jan 2007 16:59:54 -0800
Message-ID: <7v8xfvzxit.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701211325250.3011@xanadu.home>
	<ep0c9d$tph$1@sea.gmane.org>
	<625fc13d0701211548j5f41d4eck49db2726e9c194c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 02:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nXU-0002bE-9u
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbXAVA74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXAVA74
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:59:56 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49591 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbXAVA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:59:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122005955.STZF18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 19:59:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E10D1W00A1kojtg0000000; Sun, 21 Jan 2007 20:00:13 -0500
To: "Josh Boyer" <jwboyer@gmail.com>
In-Reply-To: <625fc13d0701211548j5f41d4eck49db2726e9c194c2@mail.gmail.com>
	(Josh Boyer's message of "Sun, 21 Jan 2007 17:48:48 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37373>

"Josh Boyer" <jwboyer@gmail.com> writes:

>> You don't have Error.pm perl module (in perl-Error package in Fedora Core).
>> Git distributes it's own copy, but I guess rpm target requires to have it
>> installed rather than provide it ourself.
>
> If you really have your own copy, you can use Provides: perl(Error) or
> something similar.

That's true, but I do not think we would want to officially
"Provide" it.  We ship a copy only as a back-up measure for
people building from the source, as Error.pm seems not so widely
deployed.
