From: deepwinter <deepwinter@winterroot.net>
Subject: concerns about git
Date: Mon, 13 Oct 2008 11:12:27 -0700 (PDT)
Message-ID: <19959918.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 20:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRvT-0005VX-Rp
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 20:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbYJMSMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbYJMSMa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 14:12:30 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37460 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbYJMSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 14:12:29 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KpRu7-00012w-CI
	for git@vger.kernel.org; Mon, 13 Oct 2008 11:12:27 -0700
X-Nabble-From: deepwinter@winterroot.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98137>


i've been looking into using git for some version control and it looks
great.. except for 1 thing that really disturbs me.  why is the .git
repository stored within the working copy?  this is seems like a recipe for
accidental deletion.  if you are an individual using version control lets
say for just your own work, there is a lot of security that is gained from
at least having your repository within a different directory, or better on a
different partition.  this ensures that accidental deletions or hard drive
crashes are less likely to result in loosing the ENTIRE project!  of course,
accidentally deleting your working copy is stupid, but it does happen.   git
seems to offer no protection against this kind of mistake for the individual
coder.. or is there some way to have git put the actual repository files in
a different directory?  (can't find info on that)
-- 
View this message in context: http://www.nabble.com/concerns-about-git-tp19959918p19959918.html
Sent from the git mailing list archive at Nabble.com.
