From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 03:13:45 +0200
Message-ID: <484F26C9.9080608@keyaccess.nl>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Evs-0002SD-6H
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbYFKBOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbYFKBOG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:14:06 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:58793 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbYFKBNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 21:13:40 -0400
Received: from [213.51.130.189] (port=50953 helo=smtp2.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6EuB-0002j3-QL; Wed, 11 Jun 2008 03:13:39 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:39134 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6EuB-000562-L8; Wed, 11 Jun 2008 03:13:39 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84570>

On 11-06-08 03:06, David Symonds wrote:
> On Wed, Jun 11, 2008 at 10:51 AM, Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> The manpages seem to be making somewhat of a point of mentioning "git pull .
>> <branch>" as the way to merge a local branch into the current one but a
>> simple "git merge <branch>" seems to work well. Is there a difference?
> 
> git pull also does a fetch in it's usual mode of operation, and runs
> git merge to do merge changes in the remote-tracking branches.

So in the case of merging a branch from the local repository into the 
current branch, there is no difference between the two?

Rene.
