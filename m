From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/7] Fixed dosctrings (typos) and preferably load cl before vc
Date: Sat, 03 Mar 2007 14:07:34 -0800
Message-ID: <7vvehi7zh5.fsf@assigned-by-dhcp.cox.net>
References: <15295.1172917170@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, julliard@winehq.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNcOA-0000xV-OA
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbXCCWHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbXCCWHg
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:07:36 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36869 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704AbXCCWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:07:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303220735.UPQ1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 17:07:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WN7a1W00S1kojtg0000000; Sat, 03 Mar 2007 17:07:35 -0500
In-Reply-To: <15295.1172917170@localhost> (Xavier Maillard's message of "Sat,
	03 Mar 2007 11:19:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41332>

Xavier Maillard <zedek@gnu.org> writes:

> Signed-off-by: Xavier Maillard <zedek@gnu.org>
> ---
>  contrib/emacs/vc-git.el |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
> index 4cab845..748cb60 100644
> --- a/contrib/emacs/vc-git.el
> +++ b/contrib/emacs/vc-git.el
> @@ -32,8 +32,8 @@
>  ;;  - more customisable variables
>  
>  (eval-when-compile 
> -  (require 'cl)
> -  (require 'vc))
> +  (require 'vc)
> +  (require 'cl))

Could we have a brief description why vc should be required
before cl?  Or is it so common that does not need explanation
for Emacs gurus?
