From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git bash does not access drive f:
Date: Fri, 23 Nov 2012 16:31:06 +0100
Message-ID: <20121123153106.GA14509@book.hvoigt.net>
References: <CAB9Jk9Ae46PNRex9QrEy9gTgqAbn8KUFifmxQU4s5K5mDDmDZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbvDy-0004z7-5l
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 16:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab2KWPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 10:31:11 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:51533 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab2KWPbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 10:31:09 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TbvDf-00018i-6H; Fri, 23 Nov 2012 16:31:07 +0100
Content-Disposition: inline
In-Reply-To: <CAB9Jk9Ae46PNRex9QrEy9gTgqAbn8KUFifmxQU4s5K5mDDmDZQ@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210258>

Hi,

On Thu, Nov 22, 2012 at 08:07:55AM +0100, Angelo Borsotti wrote:
> I have attached an external disc, which appears on Windows as drive f:
> in Windows Explorer.
> Right-clicking on it displays a context menu showing (among other
> items) Git Init Here, Git Gui and
> Git Bash. The first two work properly on that drive.
> However, the git bash does not. Not even the one that is run from the icon:
> 
> $ cd f:
> sh.exe": cd: f:: No such file or directory
> 
> 
> Is there any way to make it access drive f?

Try using the environment variable MSYS_WATCH_FSTAB=YesPlease.

We have an optimization in msys that does not update the virtually
mounted folders and makes msys executable startups faster. I had similar
issues with mounted disk images.

The other alternative: After having the external disc mounted logout and
login again that AFAIR that should also help.

Cheers Heiko
