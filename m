From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 02:40:51 -0400
Message-ID: <464AA773.3090808@garzik.org>
References: <464A940C.3080906@garzik.org> <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com> <464A9C9B.70904@garzik.org> <20070516061449.GA25273@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 08:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDC7-0002HQ-1R
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388AbXEPGlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759473AbXEPGlA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:41:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:54019 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759388AbXEPGk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:40:59 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HoDBs-0006T1-G3; Wed, 16 May 2007 06:40:52 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <20070516061449.GA25273@artax.karlin.mff.cuni.cz>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47420>

Jan Hudec wrote:
> And does the .git/logs/refs/heads/upstream-fixes still exist?

Nope.


> If it does not, as last resort you'd have to git fsck --unreachable
> (this gives you all things that are not reachable from any ref), filter
> out only commit objects and than remember which one should have been on
> that branch after reading it's log, date and changes.

Yeah, that will probably recover it.  I wound up digging the emails out 
of the trash bin, and applying them again.

	Jeff
