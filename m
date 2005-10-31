From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Add support for renaming multiple items at once, and for the destination to be a directory.
Date: Mon, 31 Oct 2005 08:53:39 +0100
Message-ID: <20051031075338.GA9006@ebar091.ebar.dtu.dk>
References: <7vzmp04uot.fsf@assigned-by-dhcp.cox.net> <11307435312942-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 31 09:03:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWUca-0003KJ-Vq
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 09:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVJaICF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 03:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVJaICF
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 03:02:05 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:12243 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751202AbVJaICE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 03:02:04 -0500
Received: (qmail 9017 invoked by uid 5842); 31 Oct 2005 07:53:39 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11307435312942-git-send-email-ryan@michonline.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10855>

On Mon, Oct 31, 2005 at 02:25:31AM -0500, Ryan Anderson wrote:
> Signed-off-by: Ryan Anderson <ryan@michonline.com>
> 
> ---
> 
> > *1* It strikes me that git rename *could* be friendlier by emulating
> > how "mv" treats the paths parameters (current implementation insists
> > two parameters $src and $dst).  What do you think, Ryan?
> 
> How does this look?

See commit 1114b26e8f2d06912d855c631e51a4ee8a06c4e2 which adds git-mv.

"It supersedes git-rename by adding functionality to move multiple
files, directories or symlinks into another directory.  It also
provides according documentation."

Perhaps you didn't see this commit?

Regards,

Peter 
