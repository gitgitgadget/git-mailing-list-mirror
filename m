From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Mon, 23 Feb 2015 12:23:11 -0500
Message-ID: <54EB61FF.1080901@xiplink.com>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net> <54EB436E.9060106@xiplink.com> <54EB545A.2040309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 18:22:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPwi3-0004qS-7R
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 18:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbBWRWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 12:22:14 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:55842 "EHLO
	smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072AbbBWRWN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 12:22:13 -0500
Received: from smtp2.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp2.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id EEC5B180914;
	Mon, 23 Feb 2015 12:22:12 -0500 (EST)
Received: by smtp2.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8993318028C;
	Mon, 23 Feb 2015 12:22:12 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Mon, 23 Feb 2015 17:22:12 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54EB545A.2040309@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264275>

On 15-02-23 11:24 AM, Michael J Gruber wrote:
> Marc Branchaud venit, vidit, dixit 23.02.2015 16:12:
>> On 15-02-22 12:38 PM, Michael J Gruber wrote:
>>> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
>>> ref depending on whether the detached HEAD has moved since. "git branch"
>>> always uses "from", which can be confusing, because a status-aware user
>>> would interpret this as moved detached HEAD.
>>>
>>> Make "git branch" use the same logic and wording.
>>
>> Except that the wording in "git branch" is more correct, especially if the
>> detached HEAD contains new commits.
>>
>> In other words, "at" is only correct if the detached HEAD matches the ref.
>> If the HEAD has other commits, it is no longer "at" that ref but instead it
>> has grown "from" it.
> 
> Sure, but that's exactly what git status does. Haven't you tried out?
> 
> And it's exactly what I suggest for git branch. It conveys more information.

Oops, right.  Sorry, I got blinded by the various "detached at" examples in
your patch's notes.

		M.
