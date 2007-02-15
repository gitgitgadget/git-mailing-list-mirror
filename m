From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT 1.5.0 binary installer available.
Date: Thu, 15 Feb 2007 20:52:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702152034300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D44FD5.72299A3A@eudaptics.com> <45D48FF5.2060800@xs4all.nl>
 <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Feb 15 20:52:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHmen-0000B2-Co
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 20:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbXBOTwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbXBOTwh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 14:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:45948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161098AbXBOTwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 14:52:36 -0500
Received: (qmail invoked by alias); 15 Feb 2007 19:52:35 -0000
X-Provags-ID: V01U2FsdGVkX198oi9Z/t98kqiK68f7PzLXwFJ//kBse2HSCKiy5P
	Dr+Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39846>

Hi,

On Thu, 15 Feb 2007, Johannes Schindelin wrote:

> Yes, indeed. And not only the bash scripts: AFAICT the command line option 
> parsing is borked: whatever I do, a
> 
> 	sh -c "git-config -l"
> 
> from cmd does not pick up the option "-l".

I know now why it does not work. Somehow the PATH gets reset all the time. 
Will investigate further.

Ciao,
Dscho
