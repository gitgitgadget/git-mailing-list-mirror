From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 11:17:22 +0100
Message-ID: <20060116101722.GB5196@fiberbit.xs4all.nl>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de> <20060116085238.GA3768@fiberbit.xs4all.nl> <7vr778wmj3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 11:17:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRQY-0005mh-3F
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAPKR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWAPKR1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:17:27 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:10711 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932318AbWAPKR0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 05:17:26 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EyRQQ-0001Nu-KA; Mon, 16 Jan 2006 11:17:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr778wmj3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14737>

On Monday January 16th Junio C Hamano wrote:

> Even when you use git native protocol, the objects the initial
> clone gives you are kept packed, so when I rewind and rebuild
> "pu" to make some of these objects orphaned, they will stay in
> the pack the initial clone gave you.  Unpack+repack is needed to
> get rid of them.

Thanks very much for explaining. It makes sense now.

Does it bring many advantages for you to keep rebasing "pu"? I started
out following that branch long ago (well in git reckoning anyway) but
got very scared each time I got a bunch of "errors" on that one. I even
recloned a couple of times to get it "clean" again, until I understood
from the mailing-list that the rebasing was the cause, not something I
did. I since removed it from the "Pull" list, but understand that "+pu"
should do the trick. I'll retry using it one of these days.
-- 
Marco Roeland
