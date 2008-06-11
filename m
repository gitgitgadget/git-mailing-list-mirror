From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 04:01:36 +0200
Message-ID: <484F3200.2090800@keyaccess.nl>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com> <484F26C9.9080608@keyaccess.nl> <20080611015608.GD29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:02:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FfO-0006yF-7A
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbYFKCBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbYFKCBc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:01:32 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:58805 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYFKCBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 22:01:31 -0400
Received: from [213.51.130.188] (port=44335 helo=smtp3.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6FeU-0004xF-Oj; Wed, 11 Jun 2008 04:01:30 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:46512 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6FeU-0001Le-Da; Wed, 11 Jun 2008 04:01:30 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080611015608.GD29404@genesis.frugalware.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84577>

On 11-06-08 03:56, Miklos Vajna wrote:

> On Wed, Jun 11, 2008 at 03:13:45AM +0200, Rene Herman
> <rene.herman@keyaccess.nl> wrote:

>> So in the case of merging a branch from the local repository into
>> the current branch, there is no difference between the two?
> 
> There is no difference, but you really want to use git merge and not
> git pull in such a case, I guess the git pull form is supported
> mainly to keep backwards compatibility.

Thanks much, nice and clear! It might be good to adjust the git-pull 
manpage a bit if the merge is preferred? It sorts of sounds like its 
advertising the pull method now.

Regards,
Rene
