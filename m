From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 8/8] Fix tests breaking when checkout path contains
	shell metacharacters
Date: Thu, 10 Apr 2008 03:02:46 -0400
Message-ID: <20080410070246.GA27790@shion.is.fushizen.net>
References: <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <1207704604-30393-4-git-send-email-bdonlan@fushizen.net> <1207704604-30393-5-git-send-email-bdonlan@fushizen.net> <1207704604-30393-6-git-send-email-bdonlan@fushizen.net> <1207704604-30393-7-git-send-email-bdonlan@fushizen.net> <1207704604-30393-8-git-send-email-bdonlan@fushizen.net> <47FC69B8.40809@viscovery.net> <20080410063028.GA12562@shion.is.fushizen.net> <47FDB85F.9070503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqot-0006oy-0n
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYDJHCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYDJHCz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:02:55 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:44462 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbYDJHCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:02:54 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjqo5-00042L-DQ; Thu, 10 Apr 2008 07:02:49 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjqo2-0007Nw-KL; Thu, 10 Apr 2008 03:02:46 -0400
Content-Disposition: inline
In-Reply-To: <47FDB85F.9070503@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79184>

On Thu, Apr 10, 2008 at 08:49:03AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > To be honest, I fixed all the git-svn tests with a suitably clever vim s///
> > expression, so at the time this way was actually easier :)
> 
> Fair enough. If you still have the statement in you vim history, it's
> worth quoting in the commit message. It's another piece of information
> that helps reviewing.

It's fallen off by now, but as I recall it was something along the lines
of:
:%s/\$\({a number of questionable variable names}\)/\\"\\$\1\\"/gc

After which point I stepped through the matches to confirm that it was
actually within the test eval strings at the time.

Thanks,

Bryan
