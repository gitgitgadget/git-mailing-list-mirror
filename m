From: Pavel Roskin <proski@gnu.org>
Subject: Re: Problem upgrading to 1.4.0
Date: Mon, 12 Jun 2006 22:33:02 -0400
Message-ID: <1150165982.4297.88.camel@dv>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	 <7v1wtwh246.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 13 04:33:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpyiL-0007xQ-Pk
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 04:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbWFMCdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 22:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWFMCdG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 22:33:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:173 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S932788AbWFMCdF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 22:33:05 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FpyiG-0008Nb-98
	for git@vger.kernel.org; Mon, 12 Jun 2006 22:33:04 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FpyiF-0003ug-3k; Mon, 12 Jun 2006 22:33:03 -0400
To: git@vger.kernel.org
In-Reply-To: <7v1wtwh246.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21755>

On Sat, 2006-06-10 at 19:12 -0700, Junio C Hamano wrote:

> This is the second time this same gotcha caused trouble here.  I
> agree it would be sensible to make git-fetch (which is called by
> git-pull) to detect stale entries in the remotes/origin file and
> remote.origin.fetch configuration items.

And while at that, it would be great to download and keep the list of
the remote branches, perhaps when requested with a special switch.  It
doesn't mean that all of the branches should be fetched, but it would be
nice to have a list of the available remove branches somewhere.

As it stands now, this functionality is implemented in git-clone, which
it probably not the best place.  Users should not be forced to clone the
directory again to find out which branches are available.

-- 
Regards,
Pavel Roskin
