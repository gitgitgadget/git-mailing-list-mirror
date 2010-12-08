From: Kevin Sheedy <kevinsheedy@gmail.com>
Subject: Re: Push to all repositories
Date: Wed, 8 Dec 2010 14:59:16 -0800 (PST)
Message-ID: <1291849156593-5817177.post@n2.nabble.com>
References: <1291829983410-5816069.post@n2.nabble.com> <20101208180049.GC5687@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:59:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSyo-0006gQ-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0LHW7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:59:17 -0500
Received: from kuber.nabble.com ([216.139.236.158]:58202 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab0LHW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:59:17 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <kevinsheedy@gmail.com>)
	id 1PQSyi-0002CM-JK
	for git@vger.kernel.org; Wed, 08 Dec 2010 14:59:16 -0800
In-Reply-To: <20101208180049.GC5687@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163239>


I would like (1), have the code changed under my feet.
Obviously, this would exclude my locally modified files. Also, a user could
lock local files or turn off automatic updates altogether.

Clearcase dynamic views are a lovely way to collaborate with a team (despite
their many technical problems). They remove the need to perform manual
updates. Teams just stay in sync by default. There are fewer code
collisions. Problems get spotted and fixed sooner. It you don't want
something changed under your feet, that's supported too.

I guess the question is: "By default, do you want the latest code or not?"
(This is similar to how the Google Chrome Browser defaults to giving you
updates. When you're not looking, it just updates itself in the background.
You just trust that it will use this power wisely, and it does.)

It could work something like this:
Every time a repository is cloned, the location of the new clone would be
added to the repository. When a user does a push, it gets pushed out to
everyone repository on this list. Each user could retain total control over
these updates.

Do you see any reason why this couldn't be added as an enhancement to git?

Cheers
Kev
-- 
View this message in context: http://git.661346.n2.nabble.com/Push-to-all-repositories-tp5816069p5817177.html
Sent from the git mailing list archive at Nabble.com.
