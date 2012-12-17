From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Submodule not updated automatically on merge conflict
Date: Mon, 17 Dec 2012 21:41:49 +0100
Message-ID: <20121217204148.GA23267@book.hvoigt.net>
References: <CAHtLG6S28bhkAuypy-YgYY9wOWTH+Mp9g-CWmM_aDf7=dpKXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: ?A???Y <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkhVq-0002hp-Ld
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2LQUlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:41:53 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:60201 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2LQUlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 15:41:52 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TkhVV-0005Df-U2; Mon, 17 Dec 2012 21:41:50 +0100
Content-Disposition: inline
In-Reply-To: <CAHtLG6S28bhkAuypy-YgYY9wOWTH+Mp9g-CWmM_aDf7=dpKXZw@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211701>

Hi,

On Thu, Dec 13, 2012 at 01:46:43PM +0800, ?A???Y wrote:
> If there are merge conflict files, then changed submodules are not
> updated automatically.
> Why not submodules?
> Files do try to merge / update.

This is work in progress, currently you still have to use submodule
update to get them in sync with the tracked sha1. BTW, I would not expect
merge to update any submodules but let them stay at the tip of the
branch you are merging in. Or which side would you expect to get checked
out?

Cheers Heiko
