From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Having Git follow symlinks
Date: Thu, 30 Jan 2014 10:01:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se> <CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 30 10:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8nis-0003tU-3F
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 10:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaA3JPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 04:15:36 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:58740 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750982AbaA3JPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 04:15:34 -0500
X-Greylist: delayed 849 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 04:15:33 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s0U91L8h030636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Jan 2014 10:01:21 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s0U91Ksa030633;
	Thu, 30 Jan 2014 10:01:20 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 30 Jan 2014 10:01:21 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241262>

Johan Herland:

> I believe a preferable way to manage dotfiles in Git, is to have a 
> script that does the necessary setup/installation from the repo 
> (that lives in some subdirectory of ~) and into ~.

Yeah, but then I have copies of the files, instead of having the files 
themselves under version control, meaning I need to copy them back to 
push changes back, or to merge them. That is undesirable :-/

I do have a setup script for the CVS repo, but it just sets the 
symlinks up.


The only solution I can see is to split the repo up into several 
parts, one for each sub-directory that I previously had symlinked. Not 
perfect, but I guess I can live with that.

-- 
\\// Peter - http://www.softwolves.pp.se/
