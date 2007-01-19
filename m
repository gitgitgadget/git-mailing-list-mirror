From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shell syntax fix in git-reset
Date: Fri, 19 Jan 2007 08:58:11 -0800
Message-ID: <7vr6trhs2k.fsf@assigned-by-dhcp.cox.net>
References: <87ac0gfuwu.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 17:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7x4c-0000gO-A3
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 17:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbXASQ6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 11:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXASQ6O
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 11:58:14 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57852 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXASQ6N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 11:58:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119165813.LEIL26900.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 11:58:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D4yV1W00b1kojtg0000000; Fri, 19 Jan 2007 11:58:30 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37188>

Thanks for catching this.  With your fix,

    $ git grep -e 'test .*==' -e '\[ .*==' -- '*.sh'

does not seem to hit anything else.
