From: Johan Herland <johan@herland.net>
Subject: Re: [ANNOUNCE] Git 1.7.4-rc1
Date: Mon, 10 Jan 2011 11:51:07 +0100
Message-ID: <201101101151.08181.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 11:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcFLb-0003Uv-7W
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 11:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab1AJKvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 05:51:13 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61759 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab1AJKvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 05:51:10 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LES00HR5ZH9SF30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 10 Jan 2011 11:51:09 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4DF871EEED1A_D2AE49DB	for <git@vger.kernel.org>; Mon,
 10 Jan 2011 10:51:09 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 355A01EEED2E_D2AE49DF	for <git@vger.kernel.org>; Mon,
 10 Jan 2011 10:51:09 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LES00EAAZH98B30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 10 Jan 2011 11:51:09 +0100 (MET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164870>

On Thursday 06 January 2011, Junio C Hamano wrote:
> A release candidate Git 1.7.4-rc1 is available at the usual places
> for testing:

[...]

> Git v1.7.4 Release Notes (draft)
> ================================
> 
> Updates since v1.7.3
> --------------------

I can't find "git merge --abort" and "git notes merge" in this list. 
Suggested paragraphs:

 * "git merge" learned "--abort" option, synonymous to
   "git reset --merge" when a merge is in progress.

 * "git notes" learned the "merge" subcommand to merge notes refs.
   In addition to the default manual conflict resolution, there are
   also several notes merge strategies for automatically resolving
   notes merge conflicts.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
