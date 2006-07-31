From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: config variable pager.program
Date: Sun, 30 Jul 2006 17:43:56 -0700
Message-ID: <7v8xmabo37.fsf@assigned-by-dhcp.cox.net>
References: <E1G6wM1-00040z-Bu@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 02:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7LuW-0002pP-Hw
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWGaAoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWGaAoI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:44:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62163 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964796AbWGaAn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 20:43:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731004356.JTVG27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 20:43:56 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G6wM1-00040z-Bu@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sat, 29 Jul 2006 23:28:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24482>

I am not enthused about any configuration stored in .git/config
to override the environment variables.  Files are to store
reasonable default, and command line flags and environments are
to override them, but this patch does it the other way around.
