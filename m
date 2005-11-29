From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone --shared should imply --local
Date: Mon, 28 Nov 2005 23:08:31 -0800
Message-ID: <7viruclymo.fsf@assigned-by-dhcp.cox.net>
References: <1133245249.27750.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 09:11:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgzbR-0007eg-GW
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 08:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVK2HIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 02:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVK2HIf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 02:08:35 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27357 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbVK2HIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 02:08:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129070712.ZNGT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 02:07:12 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1133245249.27750.77.camel@dv> (Pavel Roskin's message of "Tue,
	29 Nov 2005 01:20:49 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12928>

Pavel Roskin <proski@gnu.org> writes:

> The "--shared" option to git-clone is silently ignored if "--local" is
> not specified.  The manual doesn't mention such dependency.  Make
> "--shared" imply "--local".
>
> Signed-off-by: Pavel Roskin <proski@gnu.org>

Hmph, then probably the manual should say it implies it...
