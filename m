From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch --subject-prefix support.
Date: Wed, 11 Apr 2007 17:35:39 -0700
Message-ID: <7vodlumntw.fsf@assigned-by-dhcp.cox.net>
References: <11763358884124-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: "Robin H\. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnHs-0008VB-5H
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbXDLAfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbXDLAfl
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:35:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48059 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbXDLAfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:35:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412003540.MJRV1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 20:35:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m0bf1W00k1kojtg0000000; Wed, 11 Apr 2007 20:35:40 -0400
In-Reply-To: <11763358884124-git-send-email-robbat2@gentoo.org> (Robin
	H. Johnson's message of "Wed, 11 Apr 2007 16:58:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44293>

"Robin H\. Johnson" <robbat2@gentoo.org> writes:

> Add a new option to git-format-patch, entitled --subject-prefix that allows
> control of the subject prefix '[PATCH]'. Using this option, the text 'PATCH' is
> replaced with whatever input is provided to the option. This allows easily
> generating patches like '[PATCH 2.6.21-rc3]' or properly numbered series like
> '[-mm3 PATCH N/M]'.
>
> 1/2 - Implementation and documentation
> 2/2 - Test case

I suspect this is a job for send-email, not format-patch.  List?
