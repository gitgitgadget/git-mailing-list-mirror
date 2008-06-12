From: Yves Orton <yves.orton@booking.com>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order
	causing parent data to be lost from commits turning essentially linear repo
	into "islands"
Date: Thu, 12 Jun 2008 14:04:45 +0200
Message-ID: <1213272285.6940.222.camel@gemini>
References: <1213266100.6940.207.camel@gemini>
	 <48510E2E.6090508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 14:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lYo-00087l-0O
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYFLMEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbYFLMEx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:04:53 -0400
Received: from msx1.activehotels.net ([62.190.24.9]:46876 "EHLO
	mx1.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753358AbYFLMEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:04:52 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx1.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1K6lXr-0004Cc-L5; Thu, 12 Jun 2008 13:04:48 +0100
In-Reply-To: <48510E2E.6090508@viscovery.net>
X-Mailer: Evolution 2.22.2 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84748>

On Thu, 2008-06-12 at 13:53 +0200, Johannes Sixt wrote:
> Yves Orton schrieb:
> > Hi,
> > 
> > Ive been working with git-fast-export a bit recently and Ive hit a bug
> > that is causing some trouble. 
> > 
> > Essentially it seems that one of our repos git-fast-export fails to emit
> > the proper 'from' information for several commits in the repo. These
> > commits are emitted first without parent data even though their parents
> > ARE emitted later.
> 
> Does it make a difference if you pass --topo-order to git fast-export?
> (But I don't know for certain that this is even legal.)

Yes it does make a difference. A big difference. That would be the
workaround I really needed.  At least currently thats the way it looks,
i havent thoroughly tested the result yet but it certainly looks right.

Perhaps this should be enabled by default to avoid the problem i
encountered? At least until whatever the cause of the root problem is
identified and fixed.

Thanks a lot. ++ to you.

Cheers,
yves
