From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix crash when GIT_DIR is invalid
Date: Fri, 04 Aug 2006 11:56:19 -0700
Message-ID: <7virl8jpnw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608041745500.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 20:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94qV-0003Hp-4g
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWHDS4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWHDS4V
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:56:21 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37071 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161243AbWHDS4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 14:56:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804185620.EVZU2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 14:56:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24819>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>  	bad_dir_environ:
> -		if (!nongit_ok) {
> +		if (nongit_ok) {
>  			*nongit_ok = 1;

*BLUSH*  How could I have missed something like this...

Thanks.
