From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH guilt] Handles slashes in branch names
Date: Thu, 19 Jul 2007 15:35:46 -0400
Message-ID: <20070719193546.GA27388@filer.fsl.cs.sunysb.edu>
References: <87y7hctf6o.fsf@hubert.paunchy.net> <20070719184418.GA22463@filer.fsl.cs.sunysb.edu> <87r6n4td8y.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbnY-0001iA-Bz
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940886AbXGSTf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940830AbXGSTfz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:35:55 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37615 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbXGSTfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:35:54 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6JJZkAw027659;
	Thu, 19 Jul 2007 15:35:46 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6JJZkbC027657;
	Thu, 19 Jul 2007 15:35:46 -0400
Content-Disposition: inline
In-Reply-To: <87r6n4td8y.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53028>

On Thu, Jul 19, 2007 at 12:17:01PM -0700, Eric Lesh wrote:
> When a branch name has a slash and autotagging is enabled, guilt barfs
> when updating the stack tags.  Make these branch names work.
> 
> Also allow guilt to create the patches directory for these branches.
> 
> Signed-off-by: Eric Lesh <eclesh@ucla.edu>

Applied. I just added quotes around the mkdir -p in guilt in case someone
likes to have whitespace in their branch names.

Thanks,

Josef 'Jeff' Sipek.

-- 
Real Programmers consider "what you see is what you get" to be just as bad a
concept in Text Editors as it is in women. No, the Real Programmer wants a
"you asked for it, you got it" text editor -- complicated, cryptic,
powerful, unforgiving, dangerous.
