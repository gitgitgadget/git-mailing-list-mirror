From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 17/25] git-relink: Print usage message to stderr.
Date: Sat, 10 Dec 2005 20:26:52 -0800
Message-ID: <7vwtictg1f.fsf@assigned-by-dhcp.cox.net>
References: <1134243476675-git-send-email-freku045@student.liu.se>
	<11342434794009-git-send-email-freku045@student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 05:27:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElInc-0004Gm-8H
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 05:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVLKE0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 23:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVLKE0z
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 23:26:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4481 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161012AbVLKE0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 23:26:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211042601.SVNG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 23:26:01 -0500
To: freku045@student.liu.se
In-Reply-To: <11342434794009-git-send-email-freku045@student.liu.se>
	(freku045@student.liu.se's message of "Sat, 10 Dec 2005 20:37:59
	+0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13483>

freku045@student.liu.se writes:

> +	print STDERR "usage: $0 [--safe] <dir> [<dir>...] <master_dir>\n";
> +	print STDERR "All directories should contain a .git/objects/ subdirectory.\n";
> +	print STDERR "Options\n";
> +	print STDERR "\t--safe\t" .
>  		"Stops if two objects with the same hash exist but " .
> -		"have different sizes.  Default is to warn and continue.\n");
> +		"have different sizes.  Default is to warn and continue.\n";

Might be cleaner to use <<HERE document here.
