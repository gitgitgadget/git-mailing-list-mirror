From: "Yann Dirson" <ydirson@linagora.com>
Subject: Re: "git svn reset" only resets current branch ?
Date: Tue, 7 Jul 2009 10:01:08 +0200 (CEST)
Message-ID: <46974.10.0.0.1.1246953668.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ben Jackson" <ben@ben.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO5bx-0001yI-OD
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 10:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbZGGIA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZGGIA7
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 04:00:59 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:50429 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbZGGIA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 04:00:59 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id ADA54429F03;
	Tue,  7 Jul 2009 10:01:01 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Tue, 7 Jul 2009 10:01:08 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122828>

> I think the current behavior is a reasonable default; it's least
> surprising to me and the user could more easily rerun with "--all" if
> needed.  If --all were the default, the user could potentially
> have to refetch a lot of data they didn't want to.

As an alternative, we could also allow "git svn reset" to take us back
into the future to undo any such mistake without refetching.

I'm not sure it would be the best to keep reset act on a single branch,
where eg. fetch acts on all branches, and already has a --all flag, which
is not yet documented, and seems to have a different meaning (if that
wasn't obvious, I have still not had a look at what it really does ;)
