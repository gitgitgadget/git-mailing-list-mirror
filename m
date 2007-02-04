From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Let git-checkout always drop any detached head
Date: Sat, 03 Feb 2007 21:58:03 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702032155560.3021@xanadu.home>
References: <Pine.LNX.4.64.0702032149200.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 03:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDXa1-0003As-FA
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 03:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXBDC6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 21:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXBDC6G
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 21:58:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45871 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbXBDC6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 21:58:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCX004BL48RMJ50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 21:58:03 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702032149200.3021@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38640>


OK obviously I can't send proper patches today.


On Sat, 3 Feb 2007, Nicolas Pitre wrote:

> diff --git a/git-checkout.sh b/git-checkout.sh
> index 99b8779..e4cce06 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -164,22 +164,9 @@ If you want to create a new branch from this checkout, you may do so
>  (now or later) by using -b with the checkout command again. Example:
>    git checkout -b <new_branch_name>"
>  	fi
> -elif test -z "$oldbranch" && test -n "$branch"
> +elif test -z "$oldbranch" && && test -z "$quiet"

Of course there is one "&&" too many.


Nicolas
