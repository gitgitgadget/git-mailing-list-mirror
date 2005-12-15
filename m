From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/11] git-applypatch: Usage string clean-up, emit usage string at incorrect invocation
Date: Thu, 15 Dec 2005 12:42:42 -0800
Message-ID: <7v64pqozwd.fsf@assigned-by-dhcp.cox.net>
References: <11345130302438-git-send-email-freku045@student.liu.se>
	<11345130311492-git-send-email-freku045@student.liu.se>
	<7vfyow45l2.fsf@assigned-by-dhcp.cox.net>
	<20051214144542.0a509e3e.tihirvon@gmail.com>
	<20051215195528.GA14388@c165.ib.student.liu.se>
	<43A1D24B.5070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 21:43:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emzw7-0003Vw-Bi
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 21:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVLOUmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 15:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVLOUmo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 15:42:44 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39347 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751062AbVLOUmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 15:42:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215204157.UGQE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 15:41:57 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <43A1D24B.5070603@gmail.com> (Marco Costalba's message of "Thu,
	15 Dec 2005 21:30:03 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13711>

Marco Costalba <mcostalba@gmail.com> writes:

> This patch seems not working for me:
>
> -[[ "$#" = "3" || "$#" = "4" ]] || usage
> +case "$#" in 3|4) usage ;; esac

I am an idiot.  Thanks.  That should have read "3|4) ;; *)
usage", obviously.
