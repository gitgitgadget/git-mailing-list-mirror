From: Josh England <jjengla@comcast.net>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 19:02:41 -0600
Message-ID: <1189213361.15140.13.camel@beauty>
References: <1189120800.6203.23.camel@beauty>
	 <7v642m436q.fsf@gitster.siamese.dyndns.org>
	 <1189200421.12525.8.camel@beauty>
	 <7vhcm62lru.fsf@gitster.siamese.dyndns.org>
	 <1189203064.15140.2.camel@beauty>
	 <7vveam15w9.fsf@gitster.siamese.dyndns.org>
	 <1189204498.15140.4.camel@beauty>
	 <7vr6la11q9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 03:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITopz-0002KA-O0
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 03:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbXIHBKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 21:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXIHBKJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 21:10:09 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:63636 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXIHBKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 21:10:07 -0400
Received: from [192.168.0.133] (c-68-54-9-220.hsd1.nm.comcast.net[68.54.9.220])
          by comcast.net (sccrmhc11) with SMTP
          id <2007090801050501100kgn1ne>; Sat, 8 Sep 2007 01:05:05 +0000
In-Reply-To: <7vr6la11q9.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58097>

On Fri, 2007-09-07 at 16:42 -0700, Junio C Hamano wrote:
> Josh England <jjengla@comcast.net> writes:
> 
> > On Fri, 2007-09-07 at 15:12 -0700, Junio C Hamano wrote:
> >> Josh England <jjengla@comcast.net> writes:
> >> 
> >> > OK. Fair enough.  Maybe it would be good to note in git-sh-setup.sh that
> >> > many of the supplied functions will not work when called from within
> >> > $GIT_DIR.
> >> 
> >> Sorry, "supplied functions"?  Care to clarify with a patch?
> >
> > I guess really just the cd_to_topdir() function.  It will silently fail
> > when run from within $GIT_DIR.
> 
> Ah, I see what you meant.
> 
> I think you probably are supposed to check with is_bare_repository
> or something before calling that, as asking to cd to toplevel
> implies you know there is such a thing as toplevel ;-)

That's fine.  I guess using `$GIT_DIR/../` as you mentioned before will
just have to work.

-JE
