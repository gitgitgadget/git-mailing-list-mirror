From: David Soria Parra <sn_@gmx.net>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 2 Dec 2009 07:20:44 +0000 (UTC)
Message-ID: <slrnhhc58g.cpv.sn_@experimentalworks.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <BLU0-SMTP487572F057CC9D30C837D7AE950@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 08:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjWX-0005Q0-HO
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZLBHVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZLBHVE
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:21:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:43840 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZLBHVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:21:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFjWO-0005Mk-0J
	for git@vger.kernel.org; Wed, 02 Dec 2009 08:21:08 +0100
Received: from 217.114.211.68 ([217.114.211.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:21:07 +0100
Received: from sn_ by 217.114.211.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:21:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217.114.211.68
User-Agent: slrn/0.9.9p1 (SunOS)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134310>

On 2009-12-02, Sean Estabrooks <seanlkml@sympatico.ca> wrote:
>> It tries to make the following usecase possible:
>> Imagine you are working on a project that has 1.x and a 2.x branch. The project
>> itself requires a complex setup (webserver, configuration files, etc). Setting up
>> 1.x and 2.x branch requires a lot of work, but a developer needs to maintain both.
>> He'll use the --track option to clone the 2.x branch into a directory and does the same
>> with the 1.x branch, where he setup the project. He can use locally separate repositories
>> while still being able to push to just one remote repository.
>
> This is already straightforward in Git without the limitation of tracking only
> a single remote branch.   What is the necessity of doing this via the clone command?
>
>   $ git init myrepo
>   $ cd myrepo
>   $ git remote add -t branch1.x -f origin <URL>
>   $ git checkout -t origin/branch1.x
I'm aware that this is possible, but I want to have a shortcut for this as the users that I
helped with getting into git usually where confused about the point that you have to do it manually
via git init, so take the patch as a proposal to get more consistent interface for git clone.

david
