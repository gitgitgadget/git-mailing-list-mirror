From: Josh England <jjengla@comcast.net>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 16:34:58 -0600
Message-ID: <1189204498.15140.4.camel@beauty>
References: <1189120800.6203.23.camel@beauty>
	 <7v642m436q.fsf@gitster.siamese.dyndns.org>
	 <1189200421.12525.8.camel@beauty>
	 <7vhcm62lru.fsf@gitster.siamese.dyndns.org>
	 <1189203064.15140.2.camel@beauty>
	 <7vveam15w9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITmOj-0002bQ-Ep
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbXIGWdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758627AbXIGWdj
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:33:39 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:47007 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbXIGWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:33:38 -0400
Received: from [192.168.0.133] (c-68-54-9-220.hsd1.nm.comcast.net[68.54.9.220])
          by comcast.net (sccrmhc14) with SMTP
          id <2007090722333701400493fie>; Fri, 7 Sep 2007 22:33:37 +0000
In-Reply-To: <7vveam15w9.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58088>

On Fri, 2007-09-07 at 15:12 -0700, Junio C Hamano wrote:
> Josh England <jjengla@comcast.net> writes:
> 
> > OK. Fair enough.  Maybe it would be good to note in git-sh-setup.sh that
> > many of the supplied functions will not work when called from within
> > $GIT_DIR.
> 
> Sorry, "supplied functions"?  Care to clarify with a patch?

I guess really just the cd_to_topdir() function.  It will silently fail
when run from within $GIT_DIR.

-JE
