From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff between /dev/null and blob
Date: Sun, 30 Jul 2006 23:50:31 -0700
Message-ID: <7vmzaq9sjs.fsf@assigned-by-dhcp.cox.net>
References: <eajl4r$b7o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 31 08:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Rbo-0004Zj-F9
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 08:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGaGud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 02:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGaGud
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 02:50:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58325 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932436AbWGaGud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 02:50:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731065032.IMUO6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 02:50:32 -0400
To: git@vger.kernel.org
In-Reply-To: <eajl4r$b7o$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	31 Jul 2006 03:07:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24494>

Jakub Narebski <jnareb@gmail.com> writes:

> Currently, due to artifact of git-diff argument parsing you can get diff 
> of two arbitrary blobs given by their sha1 id, e.g.
>   git diff ab8050ceb4e43522e858768cc2c02fcb91839370 fd05278808d458602587bb024a48726018d30926

Just FYI, it is pretty much by design not artifact to allow
something like this:

	git diff master:Makefile next:Makefile
