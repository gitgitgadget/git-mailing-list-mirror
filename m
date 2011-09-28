From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 11:03:45 -0700 (PDT)
Message-ID: <1317233025014-6841234.post@n2.nabble.com>
References: <1317227849979-6840904.post@n2.nabble.com> <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 20:03:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yU6-0006T9-DW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 20:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab1I1SDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 14:03:50 -0400
Received: from sam.nabble.com ([216.139.236.26]:33955 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab1I1SDt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 14:03:49 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1R8yTx-00056t-0h
	for git@vger.kernel.org; Wed, 28 Sep 2011 11:03:45 -0700
In-Reply-To: <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182354>

>> 1. Directories can exist even if there's nothing in them (just like
>> any filesystem).
>
>What requires the empty directories to exist?  The build system?

Yes.

>Can you just let them go away in Git and fix it downstream in the user's
working copy?

That won't work retroactively for already-existing revisions. I'd rather not
break the build system for older revisions just for such a goofy reason as
empty dirs being deemed unnecessary.


--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p6841234.html
Sent from the git mailing list archive at Nabble.com.
