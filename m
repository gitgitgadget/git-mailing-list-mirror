From: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
Subject: git merge auto-commit doesn't fire pre-commit hook
Date: Thu, 17 Feb 2011 11:49:43 +1300
Message-ID: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 23:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpqLP-0003qo-8m
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab1BPW7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 17:59:30 -0500
Received: from 85.25.69.111.dynamic.snap.net.nz ([111.69.25.85]:60966 "EHLO
	mail.toc.org.nz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005Ab1BPW73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 17:59:29 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Feb 2011 17:59:29 EST
Received: from imac24.toc.org.nz (imac24.toc.org.nz [10.13.11.74])
	by mail.toc.org.nz (Postfix) with ESMTP id DF2E22829688
	for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:49:43 +1300 (NZDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167017>

Hi all, 

How exactly does git merge execute the commit? Does it use --no-verify at all? I've got a pre-commit hook to filter out testing data when merging into master, and if you merge with --no-commit, and then manually commit, the hook fires fine, but when merge autocommits, the hook doesn't get executed at all. Is there any other way to catch this event? I can add --no-commit to the branch.master.mergeoptions I suppose, but I don't want to add too much hassle for our Git users (if they're not checking in test data, of course).

Regards, 

Liam Clarke