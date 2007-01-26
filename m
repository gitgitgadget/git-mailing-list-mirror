From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Heavily expanded update hook to send more useful emails than the old hook
Date: Fri, 26 Jan 2007 01:09:40 -0800
Message-ID: <7vejpi17e3.fsf@assigned-by-dhcp.cox.net>
References: <29b04c45a795406bd9b278eb44321fe572dc8adf.1169801884.git.andyparkins@gmail.com>
	<200701260901.04813.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Deepak Barua" <dbbarua@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAN5e-0000OW-56
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030844AbXAZJJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030846AbXAZJJm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:09:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61567 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030844AbXAZJJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:09:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126090941.XLGE19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 04:09:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fl8j1W0021kojtg0000000; Fri, 26 Jan 2007 04:08:43 -0500
In-Reply-To: <200701260901.04813.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 26 Jan 2007 09:01:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37819>

I've been wondering if we would want to have example-hooks/
directory (not necessarily under contrib/).  Different people
seem to want different things from the hooks and I'd like to
avoid "my version is better than yours" arms race to result in
unnecessary bloat of example hooks that are copied to every
repository but yet left disabled.
