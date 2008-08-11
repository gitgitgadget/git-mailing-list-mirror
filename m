From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: BUG: path issues in git-daemon and git-shell
Date: Mon, 11 Aug 2008 12:48:13 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200808111248.13606.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 12:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUya-000551-HW
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbYHKKtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbYHKKtI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:49:08 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:42767 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbYHKKtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:49:07 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Aug 2008 12:49:05 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 11 Aug 2008 10:49:05.0628 (UTC) FILETIME=[DFFC39C0:01C8FB9F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91931>

Hi,

After upgrading to latest git and applying Thomas patches to get the
forementioned branch filtering to work, both users with git-shell
as login shell and git:// refused to work.

git version 1.6.0.rc2.26.g0413

Git is compiled using make --prefix=/usr/local.  Both worked after

	* adding /usr/local/bin to $PATH in xinetd for git-daemon
	* adding a putenv("PATH=/usr/local/bin:/bin:/usr/bin") at
	the very start of main() in shell.c

This of course is merely a work-around :-(

	Cheers --- Jan
