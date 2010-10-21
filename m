From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [completion] Request: Include remote heads as push targets
Date: Thu, 21 Oct 2010 11:37:47 -0400
Message-ID: <4CC05E4B.1010106@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 17:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8xDe-0004x8-9C
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 17:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533Ab0JUPiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 11:38:08 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:32777 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab0JUPiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 11:38:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 32010128270;
	Thu, 21 Oct 2010 11:38:07 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C15EF128378;
	Thu, 21 Oct 2010 11:38:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100922 Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159516>

Hi Shawn,

I find myself wishing that completion would support the following:

	git push origin HEAD:<tab>

The options presented at this point should include all the origin/* heads,
without the "origin/" prefix.  Right now (git 1.7.3.1) completion only lets
me choose from local refs.

I tried looking at the completion script myself, but my completion-fu is weak
and I'm really not sure how to go about implementing this.

So I'm just throwing this request out to see what happens.

Thanks!

		M.
