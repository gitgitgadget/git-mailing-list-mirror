From: "Yann Dirson" <ydirson@altern.org>
Subject: gitk: showing onging merge as such ?
Date: Thu, 7 May 2009 13:46:52 +0200 (CEST)
Message-ID: <53018.10.0.0.1.1241696812.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 13:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22E7-0003LH-3c
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 13:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbZEGL5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 07:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbZEGL5P
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 07:57:15 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:47982 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZEGL5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 07:57:14 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 07:57:14 EDT
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 50B57429F28
	for <git@vger.kernel.org>; Thu,  7 May 2009 13:46:46 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 10.75.161.7)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Thu, 7 May 2009 13:46:52 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118464>

While resolving a conflicted merge, I wondered if there was any reason why
gitk does not show that we are indeed doing a merge, by showing the staged
contents as a merge commit if MERGE_HEAD is found.

Is there any reason why we would not do this ?

I had a quick try at how this could be done, here it is.  The diff is not
yet displayed as combined.
