From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Mon, 23 Feb 2015 10:12:46 -0500
Message-ID: <54EB436E.9060106@xiplink.com>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPufq-00014r-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 16:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbbBWPLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 10:11:50 -0500
Received: from smtp98.ord1c.emailsrvr.com ([108.166.43.98]:58456 "EHLO
	smtp98.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178AbbBWPLt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 10:11:49 -0500
Received: from smtp13.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 10AE238022F;
	Mon, 23 Feb 2015 10:11:49 -0500 (EST)
Received: by smtp13.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 52E313802EC;
	Mon, 23 Feb 2015 10:11:48 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Mon, 23 Feb 2015 15:15:10 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264263>

On 15-02-22 12:38 PM, Michael J Gruber wrote:
> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
> ref depending on whether the detached HEAD has moved since. "git branch"
> always uses "from", which can be confusing, because a status-aware user
> would interpret this as moved detached HEAD.
> 
> Make "git branch" use the same logic and wording.

Except that the wording in "git branch" is more correct, especially if the
detached HEAD contains new commits.

In other words, "at" is only correct if the detached HEAD matches the ref.
If the HEAD has other commits, it is no longer "at" that ref but instead it
has grown "from" it.

But even if the detached HEAD matches the ref, saying it came "from" that ref
(with 0 extra commits) is still better than saying
detached-HEAD-with-extra-commits is "at" the ref.

		M.
