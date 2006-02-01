From: Dave Jones <davej@redhat.com>
Subject: Re: [Announce] gitview-0.1
Date: Tue, 31 Jan 2006 23:29:30 -0500
Message-ID: <20060201042930.GV16557@redhat.com>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Feb 01 05:29:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F49cn-0003rZ-2h
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 05:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWBAE3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 23:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWBAE3m
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 23:29:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964907AbWBAE3m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 23:29:42 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k114TVnU008565;
	Tue, 31 Jan 2006 23:29:31 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k114TV109226;
	Tue, 31 Jan 2006 23:29:31 -0500
Received: from nwo.kernelslacker.org (vpn83-132.boston.redhat.com [172.16.83.132])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k114TVvK023677;
	Tue, 31 Jan 2006 23:29:31 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id k114TULN015678;
	Tue, 31 Jan 2006 23:29:30 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k114TUgt015677;
	Tue, 31 Jan 2006 23:29:30 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15384>

On Wed, Feb 01, 2006 at 09:46:59AM +0530, Aneesh Kumar wrote:

 > I don't have a web location where i can host it so i am attaching it below.
 > It would be great if we can get it added to git repository
 > 
 > sample usage
 > takes same argument as git rev-list
 > 
 > gitview --since=2.week.ago

Nice, here's your first patch against it :-)

The one thing I like about gitk over this though is that with gitk
you don't have to click a button to see the diff.
For casual history browsing, it's much nicer to just scroll the bottom
window. Making it pop up a new window for each diff is just irritating.

		Dave


--- gitview~	2006-01-31 23:24:36.000000000 -0500
+++ gitview	2006-01-31 23:24:49.000000000 -0500
@@ -254,7 +254,7 @@ class DiffWindow:
 	def __init__(self):
 		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
 		self.window.set_border_width(0)
-		self.window.set_title("Git reposotiry browser diff window")
+		self.window.set_title("Git repository browser diff window")
 
 		# Use two thirds of the screen by default
 		screen = self.window.get_screen()
