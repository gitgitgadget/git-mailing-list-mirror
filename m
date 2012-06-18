From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: unable to index file UsrClass.dat
Date: Mon, 18 Jun 2012 09:11:58 -0400
Message-ID: <1340025010-sup-6406@pinkfloyd.chass.utoronto.ca>
References: <CACUgyLmvWk0WeMqx-7Qkw0py8=1ND+4pZNJDp5JOYxEcjU-UXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Grant Zhao <zhao.grant@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 16:17:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgclZ-0001x6-NR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 16:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab2FRORN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 10:17:13 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:48269 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2FRORM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 10:17:12 -0400
X-Greylist: delayed 3913 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2012 10:17:12 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60385 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SgbkM-0007uh-8q; Mon, 18 Jun 2012 09:11:58 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SgbkM-0008Lx-2u; Mon, 18 Jun 2012 09:11:58 -0400
In-reply-to: <CACUgyLmvWk0WeMqx-7Qkw0py8=1ND+4pZNJDp5JOYxEcjU-UXQ@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200142>

Excerpts from Grant Zhao's message of Mon Jun 18 06:09:08 -0400 2012:

Hi Grant,

> I cannot open the file "UsrClass.dat",I use Windows XP Profesional
> Sp3, please tell me why!

Because windows has this file open and locked.  The locking model
prevents concurrent access.  The only time you could add that file to
git would be when you're logged out and doing it as another user[1].

Thanks
-Ben

[1] Or have tricks that can read inside a shadow copy but that's a
    whole can of worms I won't get in to.
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
