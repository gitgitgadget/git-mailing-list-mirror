From: Pete Wyckoff <pw@padd.com>
Subject: Re: Suggestion: add option in git-p4 to preserve user in Git
 repository
Date: Sat, 12 Jan 2013 11:38:38 -0500
Message-ID: <20130112163838.GA28722@padd.com>
References: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Olivier Delalleau <shish@keba.be>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu46p-0004d2-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 17:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab3ALQin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 11:38:43 -0500
Received: from honk.padd.com ([74.3.171.149]:40926 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab3ALQin (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 11:38:43 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id 6169E2F3F;
	Sat, 12 Jan 2013 08:38:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9767627CDB; Sat, 12 Jan 2013 11:38:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213296>

shish@keba.be wrote on Thu, 10 Jan 2013 22:38 -0500:
> I'm in a situation where I don't have P4 admin rights to use the
> --preserve-user option of git-p4. However, I would like to keep user
> information in the associated Git branch.
> 
> Would it be possible to add an option for this?

The --preserve-user option is used to submit somebody else's work
from git to p4.  It does "p4 change -f" to edit the author of the
change after it has been submitted to p4.  P4 requires admin
privileges to do that.

Changes that are imported _from_ p4 to git do have the correct
author information.

Can you explain a bit more what you're looking for?

		-- Pete
