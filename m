From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 13:57:53 +0200
Message-ID: <4A363741.9030604@nokia.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dotan Barak <dotanba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:08:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGAys-0002lM-Lf
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849AbZFOMGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 08:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757906AbZFOMGw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:06:52 -0400
Received: from hoat.troll.no ([62.70.27.150]:40579 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063AbZFOMGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 08:06:52 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2009 08:06:51 EDT
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0359B20F7F;
	Mon, 15 Jun 2009 13:57:58 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id E62E120F67;
	Mon, 15 Jun 2009 13:57:57 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n5FBvrN4008373;
	Mon, 15 Jun 2009 13:57:57 +0200
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Mon, 15 Jun 2009 13:57:53 +0200 (CEST)
In-Reply-To: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.21 (X11/20090609)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121600>

ext Dotan Barak wrote:
> Hi.
> 
> Is it possible to find the origin of a branch?
> (the remote repository that this branch was cloned and checked out from)

git config -l

Assuming you're on the master branch, branch.master.remote and
branch.master.merge will tell you which remote and which branch you are
tracking. Assuming that the remote is origin, you can check
remote.origin.url to see the URL of the repo.

--
Kristian
