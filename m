From: Rick Moynihan <rick@calicojack.co.uk>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 15:48:11 +0100
Message-ID: <48F7542B.1050909@calicojack.co.uk>
References: <48F730D0.9040008@calicojack.co.uk> <20081016135908.GI536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 16:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUAb-0000Da-4H
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYJPOsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbYJPOsc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 10:48:32 -0400
Received: from storm.bpweb.net ([83.223.106.8]:33481 "EHLO storm.bpweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYJPOsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 10:48:32 -0400
Received: from lechuck.local (host-77-100-223-163.static.telewest.net [77.100.223.163])
	(authenticated bits=0)
	by storm.bpweb.net (8.13.1/8.13.1) with ESMTP id m9GEmH43020935;
	Thu, 16 Oct 2008 15:48:22 +0100
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <20081016135908.GI536@genesis.frugalware.org>
X-BpTo: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98385>

Miklos Vajna wrote:
> On Thu, Oct 16, 2008 at 01:17:20PM +0100, Rick Moynihan <rick@calicojack.co.uk> wrote:
>> I have a master branch, a dev branch and a number of feature branches from 
>> dev.  And I was wondering if there was an easy way to rebase dev and all of 
>> it's sub-branches onto master.
> 
> In general this is considered harmful. Why do you rebase your branch
> from time to time? For example in git.git, topic branches are based on
> master, then merged to master when they are ready, but they are never
> rebased.

Yes, but my understanding is that it's only harmful if you publish the 
branch (or dependent branches) which are being rebased.

So rebasing is very bad in these circumstances, but I fail to see why 
it's bad if these branches are kept private.


R.
