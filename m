From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: Finding all commits which modify a file
Date: Mon, 23 Jan 2012 11:14:43 -0500 (EST)
Message-ID: <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
    <4F1B4764.3010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 17:14:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpMXg-0007vE-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 17:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab2AWQOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 11:14:43 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:38502 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab2AWQOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 11:14:43 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id 48FD612BA9C;
	Mon, 23 Jan 2012 10:14:42 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Mon, 23 Jan 2012 11:14:43 -0500 (EST)
In-Reply-To: <4F1B4764.3010501@gmail.com>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188998>

> On 1/20/2012 3:35 PM, Neal Groothuis wrote:
>> I'm trying to find /all/ commits that change a file in the
>> repository...and its proving to be trickier than I thought. :-)

On 1/21/2012 6:16 PM, Neal Kreitzinger wrote:
> Does git-log --all help?

I don't see how it would.  The commits are all reachable from HEAD, which
would seem to be the problem that --all would correct.

What I'm trying to do is find the commits in which a file differs from
that same file in any of its parents.

If I'm missing something, could you provide an example of using git-log
--all to accomplish this?
