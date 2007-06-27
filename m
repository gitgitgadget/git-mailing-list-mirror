From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: t9400-git-cvsserver-server failures
Date: Wed, 27 Jun 2007 17:07:00 +0200
Message-ID: <20070627150700.GE12721@planck.djpig.de>
References: <3E98C380-541B-479F-9E8F-6BBE82EE2930@silverinsanity.com> <DA4A2395-33EA-4209-A1DE-E6CAB55C94AD@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 17:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Z6v-00016l-5H
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 17:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197AbXF0PHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbXF0PHK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 11:07:10 -0400
Received: from planck.djpig.de ([85.10.192.180]:2668 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225AbXF0PHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 11:07:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 49F4B88102;
	Wed, 27 Jun 2007 17:07:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-17gnvJ99Vz; Wed, 27 Jun 2007 17:07:00 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 99BC388105; Wed, 27 Jun 2007 17:07:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <DA4A2395-33EA-4209-A1DE-E6CAB55C94AD@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51049>

On Wed, Jun 27, 2007 at 09:08:16AM -0400, Brian Gernhardt wrote:
> Running the tests again this morning after a fresh pull results in  
> only the above failures occurring.  I looked through git- 
> cvsserver.perl and couldn't find any exit(-1) or similar.  Anyone  
> have any idea where to start to fix these?

Look for "die", it exits with such an error code by default.
Will try to look into the issues later.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
