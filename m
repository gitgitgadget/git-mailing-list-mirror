From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 19:38:19 +0200
Message-ID: <g3tvqd$2jj$1@ger.gmane.org>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 19:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBYxx-0004Zt-LP
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYFYRii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYFYRii
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:38:38 -0400
Received: from main.gmane.org ([80.91.229.2]:34066 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbYFYRih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:38:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBYwx-00081s-NZ
	for git@vger.kernel.org; Wed, 25 Jun 2008 17:38:32 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 17:38:31 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 17:38:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86307>

Avery Pennarun venit, vidit, dixit 25.06.2008 18:44:
...
> 4) My idea is to eventually --assume-unchanged my whole repository,
> then write a cheesy daemon that uses the Win32 dnotify-equivalent to
> watch for files that get updated and then selectively
> --no-assume-unchanged files that it gets notified about.  That would
> avoid the need to ever synchronously scan the whole repo for changes,
> thus making my git-Win32 experience much faster and more enjoyable.
> (This daemon ought to be possible to run on Linux as well, for similar
> improvements on gigantic repositories.  Also note that TortoiseSVN for
> Windows does something similar to track file status updates, so this
> isn't *just* me being crazy.)

Looks like users on slow NFS would profit, too. Hate to say it, but hg 
feels faster on (slow) NFS than git. Yet I use git, for other reasons ;)

Michael
