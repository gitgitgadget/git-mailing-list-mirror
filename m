From: borsotti <angelo.borsotti@gmail.com>
Subject: git add hangs
Date: Tue, 19 Jun 2012 15:31:56 -0700 (PDT)
Message-ID: <1340145116417-7561787.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 00:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6xt-0005Kd-1N
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 00:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab2FSWb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 18:31:57 -0400
Received: from sam.nabble.com ([216.139.236.26]:44672 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab2FSWb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 18:31:57 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <angelo.borsotti@gmail.com>)
	id 1Sh6xo-0003H5-Dm
	for git@vger.kernel.org; Tue, 19 Jun 2012 15:31:56 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200262>

I have a directory which is the root of a directory tree containing in total
some 200000 files. I have used the latest git on Windows 7:

  git-gui version: 0.16.GITGUI
  git version: 1.7.10.msygit.1

With the git gui I have created an archive in that directory, and then
added all its contents with the aim to perform later a commit.
The adding operation hung after having added some 2000 files.
I had to kill the git gui with the task manager.
I repeated the same operation with another directory containing some
160000 files, with a similar result.
I thought git was meant to manage large projects.

--
View this message in context: http://git.661346.n2.nabble.com/git-add-hangs-tp7561787.html
Sent from the git mailing list archive at Nabble.com.
