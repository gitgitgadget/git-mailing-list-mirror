From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 14:52:16 +0000
Message-ID: <45B772A0.3040806@shadowen.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>	<Pine.LNX.4.64.0701240019250.20138@iabervon.org> <17846.63082.935311.947093@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 15:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9jUM-0005AN-QQ
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbXAXOw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXAXOw2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:52:28 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3831 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbXAXOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:52:28 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H9jU0-0004jY-RQ; Wed, 24 Jan 2007 14:52:16 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <17846.63082.935311.947093@lisa.zopyra.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37644>

Bill Lear wrote:
> On Wednesday, January 24, 2007 at 00:29:00 (-0500) Daniel Barkalow writes:
>> On Tue, 23 Jan 2007, Bill Lear wrote:
>>
>>> I have a long-running topic branch.  I have fixed a few nits on
>>> the master branch that I would like on the topic branch.  How do I
>>> pull in only a few files from the head of the master branch?
>> You don't pull in a few files, you apply the changes made in a few 
>> commits:
>>
>>  git diff HEX_OF_NIT_FIX^ HEX_OF_NIT_FIX | git apply
>> ...
> 
> Good technique.  Thank you for sharing.
> 
> I had been thinking about trying something along the lines of Junio's
> "Separating topic branches" posted on the "GIT Howto Index" page.  I
> may have tried that had I been braver.
> 
> I probably should have thought ahead and made this fix on a branch,
> merged it into my master branch and then into my topic branch ... I
> think.

Perhaps you can just rebase that one fix 'back' onto the base.  Then
merge it into both.

-apw
