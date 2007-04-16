From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/7] Documentation: clarify git-checkout -f, minor editing
Date: Sun, 15 Apr 2007 22:13:08 -0700
Message-ID: <7v4pngyk9n.fsf@assigned-by-dhcp.cox.net>
References: <11766982362087-git-send-email-> <11766982361830-git-send-email->
	<9733.45415336571$1176698256@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdJWd-0003JB-Fp
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 07:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbXDPFNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 01:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbXDPFNK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 01:13:10 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63051 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbXDPFNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 01:13:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416051310.RNEH1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 01:13:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nhD81W00a1kojtg0000000; Mon, 16 Apr 2007 01:13:09 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44579>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> "Force a re-read of everything" doesn't mean much to me.
>
> @@ -38,7 +38,8 @@ OPTIONS
>  	Quiet, supress feedback messages.
>  
>  -f::
> -	Force a re-read of everything.
> +	Proceed even if the index or the working tree differs
> +	from HEAD.
>  

While this is definitely better, I think it still is not clear
why the command needs an option to proceed.

Not proceeding is about preventing local changes from getting
lost, and the option is a way to allow it to overwrite and lose
any local change.

Other than that, and your "From: " line (did you change your
config or switch machines?) on the first three commits, I find
all the changes very sensible.
