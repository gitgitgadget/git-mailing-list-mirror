From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Wed, 13 Sep 2006 18:12:02 -0700
Message-ID: <7vu03b5k0t.fsf@assigned-by-dhcp.cox.net>
References: <20060914010409.GB20593@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 03:12:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNfly-00073E-MR
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 03:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWINBMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 21:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWINBMH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 21:12:07 -0400
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:18669 "EHLO
	fed1rmmtai19.cox.net") by vger.kernel.org with ESMTP
	id S1751303AbWINBME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 21:12:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914011203.KSDG12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 21:12:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N1Br1V00a1kojtg0000000
	Wed, 13 Sep 2006 21:11:52 -0400
To: "Dmitry V. Levin" <ldv@altlinux.org>
In-Reply-To: <20060914010409.GB20593@nomad.office.altlinux.org> (Dmitry
	V. Levin's message of "Thu, 14 Sep 2006 05:04:09 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26971>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> describe, git: Handle argc==0 case the same way as argc==1.

When does one get (ac == 0)?
