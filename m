From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -q option to "git rm" to suppress output when there aren't errors.
Date: Sun, 15 Apr 2007 17:13:52 -0700
Message-ID: <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
References: <20070416000408.GA19107@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 02:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEqy-0000Qo-F6
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 02:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbXDPANx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 20:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbXDPANx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 20:13:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34565 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXDPANx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 20:13:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416001352.JLAB1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 20:13:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ncDs1W00R1kojtg0000000; Sun, 15 Apr 2007 20:13:52 -0400
In-Reply-To: <20070416000408.GA19107@midwinter.com> (Steven Grimm's message of
	"Sun, 15 Apr 2007 17:04:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44557>

Steven Grimm <koreth@midwinter.com> writes:

> +-q::
> +	Don't output the names of the files being removed, and exit
> +	with a zero status even if no files matched.
> +

Suppressing output is understandable and probably is a useful
thing to do, but I do not see a justification to tie that
quietness to making the status unuable...
