From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Mon, 16 Jan 2006 01:15:54 -0800
Message-ID: <7vwth0wn1x.fsf@assigned-by-dhcp.cox.net>
References: <dp3qpb$7uk$1@sea.gmane.org>
	<7voe2prniw.fsf@assigned-by-dhcp.cox.net>
	<43C91B25.9030707@research.att.com>
	<7v1wzaliv0.fsf@assigned-by-dhcp.cox.net>
	<43C95E25.3070006@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyQT2-0001J6-IJ
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 10:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAPJP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 04:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWAPJP5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 04:15:57 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48894 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932255AbWAPJP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 04:15:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116091452.CJRZ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 04:14:52 -0500
To: John Ellson <ellson@research.att.com>
In-Reply-To: <43C95E25.3070006@research.att.com> (John Ellson's message of
	"Sat, 14 Jan 2006 15:25:09 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14732>

John Ellson <ellson@research.att.com> writes:

>> Of course you can keep a patch with the sed -e 's/-/_/' in
>> GIT-VERSION-GEN as Linus suggested in your development branch.
>>
> Thats basically all I'm looking for.   I agree that is only necessary
> to fix the "make rpm" target.
> Further changes are not strictly necessary.   I don't understand why
> it would only be useful to me?

OK, if somebody is RPM savvy enough to do his own binary RPM and
install it, he would know how to override the downgrade guard
the binary package manager would give him, so it probably is not
such a big deal.  A patch to do "sed -e 's/-/./g'" will be
pushed out in the "master" branch shortly.

I hope if we later see complains on the list that some RPM cut
from an interim snapshot would not install, somebody would take
time to answer such complaints, pretty please?
