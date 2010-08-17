From: Stephen Bash <bash@genarts.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 11:48:14 -0400 (EDT)
Message-ID: <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
References: <20100817144215.GC24886@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 17:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOV9-0002yR-S4
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab0HQPyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 11:54:54 -0400
Received: from hq.genarts.com ([173.9.65.1]:28869 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752199Ab0HQPyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 11:54:54 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2010 11:54:54 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C21781E2635B;
	Tue, 17 Aug 2010 11:48:20 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqA12vtjWP7R; Tue, 17 Aug 2010 11:48:14 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4DB0C1E2624F;
	Tue, 17 Aug 2010 11:48:14 -0400 (EDT)
In-Reply-To: <20100817144215.GC24886@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153755>

Ram-

First, congratulations on making it through GSoC.  I've been avidly following your progress since our off-list discussion at the beginning of the summer, and I'm excited to watch the work continue.

> 1. Getting the revision history out of Subversion in a sane format
> (dumpfile v3).
>      ...
> 2. Converting the revision history from dumpfile v3 format into a git
> fast-import stream.
>      ...
> 5. Stitching everything together with a remote helper
> application.
>      ...
> 6. A branch/tag mapper.

So being selfish, what I care about is an improved method for converting SVN repos to git repos once and never going back.  It sounds to me like the major hurdles remaining there are getting svn-fe to handle dumpfile v3 and handling branches/tags.  Is that correct?

Thanks, and keep up the good work!

Stephen
