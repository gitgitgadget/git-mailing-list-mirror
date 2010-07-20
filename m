From: Dread Quixadhal <quixadhal@yahoo.com>
Subject: Partial clone/pull?
Date: Tue, 20 Jul 2010 15:15:31 -0700 (PDT)
Message-ID: <29220205.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 00:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObL6B-0007hG-Fp
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761845Ab0GTWPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 18:15:33 -0400
Received: from kuber.nabble.com ([216.139.236.158]:42955 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761822Ab0GTWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 18:15:33 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1ObL63-0003y8-Vr
	for git@vger.kernel.org; Tue, 20 Jul 2010 15:15:32 -0700
X-Nabble-From: quixadhal@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151371>


I have a local git repository of a server project that I'd like to
distribute.  However, I don't want to distribute EVERY file in the
repository, but I *would* like to distribute the full set of changes for
those files I do plan to release.

I'm having some trouble figuring out how to do this.  I assumed I'd create a
new repository and then use git pull to merge the directories I want in my
distribution repository.  I can't seem to find a way to specify what files I
want though.

Let's say I had a repository called stuff, with directories a, b, and c.  I
want to make a distribution repository containing just a and b, but with
full histories so a "git pull" will sync from the stuff repository, but
ignore the "c" directory.

Any suggestions?

Thanks!
-- 
View this message in context: http://old.nabble.com/Partial-clone-pull--tp29220205p29220205.html
Sent from the git mailing list archive at Nabble.com.
