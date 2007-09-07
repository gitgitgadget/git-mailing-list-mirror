From: Josh England <jjengla@comcast.net>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 16:11:04 -0600
Message-ID: <1189203064.15140.2.camel@beauty>
References: <1189120800.6203.23.camel@beauty>
	 <7v642m436q.fsf@gitster.siamese.dyndns.org>
	 <1189200421.12525.8.camel@beauty>
	 <7vhcm62lru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITm1p-0006Td-4d
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597AbXIGWKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbXIGWKM
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:10:12 -0400
Received: from alnrmhc14.comcast.net ([204.127.225.94]:54922 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbXIGWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:10:10 -0400
Received: from [192.168.0.133] (c-68-54-9-220.hsd1.nm.comcast.net[68.54.9.220])
          by comcast.net (alnrmhc14) with SMTP
          id <20070907220943b1400oodfte>; Fri, 7 Sep 2007 22:09:43 +0000
In-Reply-To: <7vhcm62lru.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58084>

On Fri, 2007-09-07 at 14:44 -0700, Junio C Hamano wrote:
> Josh England <jjengla@comcast.net> writes:
> 
> > ... there doesn't seem to be a
> > good way to access the top of the working tree from within the GIT_DIR.
> > Since I now know that post-receive has a CWD in .git, I could just use
> > `pwd`/../ , but I was hoping for a better (read: consistent between
> > hooks) solution.
> 
> I do not think it is a bad thing for _your_ script to have the
> knowledge that in _your_ repositories everywhere, the top of the
> work tree is $GIT_DIR/.. and there is no repository that lacks a
> work tree.  Obviously that would not work for people with bare
> repositories, but they would not be using _your_ script in their
> bare repositories, so that is Ok.

OK. Fair enough.  Maybe it would be good to note in git-sh-setup.sh that
many of the supplied functions will not work when called from within
$GIT_DIR.

-JE
