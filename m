From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Sat, 29 Dec 2012 00:01:49 +0100
Message-ID: <20121228230149.GA3575@book-mint>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 00:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToiwO-0003XR-4E
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 00:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab2L1XBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 18:01:54 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:47943 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab2L1XBx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 18:01:53 -0500
Received: from [77.23.67.69] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Toiw2-00071Z-Gd; Sat, 29 Dec 2012 00:01:50 +0100
Content-Disposition: inline
In-Reply-To: <20121228162025.8565E4413A@snark.thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212274>

Hi,

On Fri, Dec 28, 2012 at 11:20:25AM -0500, Eric S. Raymond wrote:
> The parsecvs code has been neglected for a long time, and the only
> public version does not even build correctly.  I have been handed
> control of the project and intend to fix this, but until I do it
> cannot be recommended.

You mean: It does not build correctly with a current version of git?
Since it links with the git source code it probably needs a version of
gits source code around the time of the last commits.

Maybe you could add that information to the parsecvs compile
instructions? I think just because it takes some effort to compile does
not justify to remove this useful pointer here. When I was converting a
legacy cvs repository this pointer would have helped me a lot.

It is the tool we were/are actively using to convert old repositories at
$dayjob.

Cheers Heiko
