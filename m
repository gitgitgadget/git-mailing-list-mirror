From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: Re: [PATCH rfc v2] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Fri, 2 Jan 2009 23:53:59 +0100
Message-ID: <AC726FD4-AE7F-4EC0-82E5-62C6D03C4E5A@marzelpan.de>
References: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com> <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsvR-00074K-Pj
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbZABWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbZABWyF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:54:05 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:57337 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZABWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:54:04 -0500
Received: from [87.161.238.13] (helo=[192.168.1.21])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1LIsu0-00047y-L7; Fri, 02 Jan 2009 23:54:00 +0100
In-Reply-To: <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org>
X-Mailer: Apple Mail (2.930.3)
X-Df-Sender: 012269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104440>

Hi,

Am 30.12.2008 um 16:10 schrieb Marcel M. Cary:

> I sent the first rev of this patch to just Brian.  It didn't have
> either of the unit test changes.  He said it fixed all but t2300.3,
> where cd_to_toplevel doesn't actually "cd", so I made the same change
> to the unit test itself.  Can someone with OS X try running the test
> suite with v2 of this patch?  I don't have OS X readily available.

the patch fixes t2300-cd-to-toplevel and t5521-pull-symlink for me.

	Marcel

[I don't know why my replies get lost, so I dropped all individual  
recipients on this third try...]
