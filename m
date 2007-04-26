From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/9] Perform correct quoting of recipient names.
Date: Wed, 25 Apr 2007 21:15:02 -0700
Message-ID: <7vhcr3vkjd.fsf@assigned-by-dhcp.cox.net>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
	<11775550432104-git-send-email-robbat2@gentoo.org>
	<1177555043272-git-send-email-robbat2@gentoo.org>
	<11775550432268-git-send-email-robbat2@gentoo.org>
	<11775550433288-git-send-email-robbat2@gentoo.org>
	<11775550432746-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H\. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 06:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgvOA-0007xx-Bi
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 06:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbXDZEPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 00:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbXDZEPG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 00:15:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49956 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbXDZEPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 00:15:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426041503.OAON1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 00:15:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rgF21W0121kojtg0000000; Thu, 26 Apr 2007 00:15:03 -0400
In-Reply-To: <11775550432746-git-send-email-robbat2@gentoo.org> (Robin
	H. Johnson's message of "Wed, 25 Apr 2007 19:37:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45607>

While this one is definitely an improvement, I am a bit unhappy
about the way @to, @cc and @bcclist are not sanitized the same
way.
