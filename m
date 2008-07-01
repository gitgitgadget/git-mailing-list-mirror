From: Paul Gardiner <lists@glidos.net>
Subject: How do I stop git enumerating my working directory
Date: Tue, 01 Jul 2008 16:57:00 +0100
Message-ID: <486A53CC.4020803@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: lists@glidos.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 18:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDiOj-00070I-QR
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYGAQHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbYGAQHJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:07:09 -0400
Received: from mk-outboundfilter-5.mail.uk.tiscali.com ([212.74.114.1]:46962
	"EHLO mk-outboundfilter-5.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754425AbYGAQHI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2008 12:07:08 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2008 12:07:07 EDT
X-Trace: 51953573/mk-outboundfilter-5.mail.uk.tiscali.com/PIPEX/$PIPEX-ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: lists@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoAAAvwaUhRVjni/2dsb2JhbAAIsjmBew
X-IronPort-AV: E=Sophos;i="4.27,732,1204502400"; 
   d="scan'208";a="51953573"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 01 Jul 2008 16:57:02 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87047>

Hi,

I'm a recent convert to git. I've been swapping over my projects
from cvs to git. The latest candidate for conversion is the
config files for my Linux server. I've been using cvs to record
all the config changes, and - mostly-automatically - to setup
new servers. Git will do a far better job, I think, but
I think I'm going to run into a problem: the root directory
of the server will be the working directory. Only relatively
few files will be under version control. How do I stop git
enumerating the whole drive whenever I do things like git-diff?

I don't think I can make .gitignore files do the job, because
it seems that you can set up to ignore a whole directory,
and then partially countermand that by placing a .gitignore
file (containing ! commands) inside the directory. That
makes me think that ignoring doesn't prevent the
enumeration.

Any help most appreciated. I really want to use git for
this.

Cheers,
	Paul.
