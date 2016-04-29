From: Monsignor <3pzqma+9rz4ms8xqpvbw@sharklasers.com>
Subject: Re: Use "git pull --ff-only" by default?
Date: Thu, 28 Apr 2016 23:38:50 -0700 (MST)
Message-ID: <1461911930694-7654696.post@n2.nabble.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 08:46:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw2CB-00083f-2C
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 08:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbcD2Gqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 02:46:31 -0400
Received: from mwork.nabble.com ([162.253.133.43]:60673 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbcD2Gqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 02:46:30 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Apr 2016 02:46:30 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id E7982260B077A
	for <git@vger.kernel.org>; Thu, 28 Apr 2016 23:38:50 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292971>

For people who still find this thread in Google, there is a way to do that
now:

*git config --add pull.ff only*

>From the documentation:

pull.ff
    By default, Git does not create an extra merge commit when merging a
commit that is a descendant of the current commit. Instead, the tip of the
current branch is fast-forwarded. When set to false, this variable tells Git
to create an extra merge commit in such a case (equivalent to giving the
--no-ff option from the command line). When set to only, only such
fast-forward merges are allowed (equivalent to giving the --ff-only option
from the command line). This setting overrides merge.ff when pulling.




--
View this message in context: http://git.661346.n2.nabble.com/Use-git-pull-ff-only-by-default-tp5084103p7654696.html
Sent from the git mailing list archive at Nabble.com.
