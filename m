From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 16:34:00 -0800
Message-ID: <7vpskc3clj.fsf@assigned-by-dhcp.cox.net>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<20060323210215.GH26071@mythryan2.michonline.com>
	<7vacbg4t48.fsf@assigned-by-dhcp.cox.net>
	<20060324000640.GK26071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 01:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMaFl-0004zt-D6
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 01:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWCXAeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCXAeF
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 19:34:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17914 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751176AbWCXAeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 19:34:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324003401.BKLS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 19:34:01 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060324000640.GK26071@mythryan2.michonline.com> (Ryan
	Anderson's message of "Thu, 23 Mar 2006 19:06:40 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17890>

Ryan Anderson <ryan@michonline.com> writes:

> What I was getting at was that not recording renames means we've traded
> off a little bit of speed and maybe accuracy, when we care about
> renames, for a simpler, better implementation.
>
> It's a tradeoff, but one that was very much the right decision, IMO.

Well, that is like arguing that we do not autocommit every time
the user makes any change in the working tree -- which means git
cannot be used to go back to _any_ time in history -- but we are
making that tradeoff and instead letting the user to decide
explicitly when to make commits.

Recording every keystrokes _is_ a wrong feature and not
supporting a wrong feature _is_ a feature.  It is not a
tradeoff.

When I said "not recording renames _is_ a feature", I really
meant it that way.
