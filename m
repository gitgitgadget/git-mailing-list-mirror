From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 16:06:52 +0100
Message-ID: <200802091606.53001.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <20080208184902.GA19404@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 16:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNrIt-0007Ii-L9
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 16:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbYBIPGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 10:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYBIPGz
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 10:06:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:37991 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750861AbYBIPGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 10:06:54 -0500
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id 90C2A6280B2;
	Sat,  9 Feb 2008 16:06:53 +0100 (CET)
User-Agent: KMail/1.9.1
In-Reply-To: <20080208184902.GA19404@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73234>

Hi Mike,

On Friday 08 February 2008 19:49, Mike Hommey wrote:

> There are 2 things, here:
> - Probably, you can make your pack smaller with proper window sizing.
> Try taking a look at the "Git and GCC" that crossed borders between
> the gcc and the git mailing lists.

Just trying this :-)

> - There are tricks to do roughly what you want without modifying git.
> For example, you can prepare several "shared" clones of your repo (git
> clone -s) and leave in each only a few branches. Cloning from these will
> only pull the needed data.

Good to know about this, thank you!  The problem currently is that we are 
trying to produce SVN and git trees containing the same data, the same number 
of branches, etc. for the sake of comparison.  If git wins, and it will be 
chosen for OOo, we'll be hopefully able to do more tuning - and I'm sure I'll 
ask here for help ;-)

Regards,
Jan
