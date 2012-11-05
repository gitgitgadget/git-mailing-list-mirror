From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: why '--init' in git-submodule update
Date: Mon, 5 Nov 2012 22:30:09 +0100
Message-ID: <20121105213004.GA2797@book.hvoigt.net>
References: <CAC9WiBgpHWFGW-z5fnQR_EWnfGJUw+G3b7C6tYMGuVu1S-kP9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:36:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVULd-0002qB-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 22:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258Ab2KEVgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 16:36:32 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:59808 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab2KEVgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 16:36:31 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2012 16:36:31 EST
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TVUFF-0005rz-GB; Mon, 05 Nov 2012 22:30:09 +0100
Content-Disposition: inline
In-Reply-To: <CAC9WiBgpHWFGW-z5fnQR_EWnfGJUw+G3b7C6tYMGuVu1S-kP9A@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209084>

Hi,

On Mon, Nov 05, 2012 at 05:30:51PM +0100, Francis Moreau wrote:
> I'm wondering why the --init option from git-submodule-update is not
> at least the defaut. Or even wilder, why this option exists at all and
> git-submodule-update always behave like --init was always passed.

That was a design decision. People may not be interested in all
submodules but just a subset they are working with. E.g. think of a
large media directory as a submodule the developers might not be
interested in having it around all the time because only the designers
are heavily working with it.

So the rationale is that you should ask for a certain submodule to be
initialized to get it. If there is demand for it we could of course think
about offering a config option in .gitmodules to allow enabling it by
default for some submodules.

Cheers Heiko
