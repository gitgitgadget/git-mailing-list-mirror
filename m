From: Xavier Maillard <zedek@gnu.org>
Subject: Publishing on a simple HTTP server
Date: Mon, 12 Feb 2007 21:10:25 +0100
Message-ID: <14870.1171311025@localhost>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 21:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhYy-0001nj-DF
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbXBLUOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbXBLUOI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:14:08 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:57364 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965268AbXBLUOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:14:07 -0500
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix1-g20.free.fr (Postfix) with ESMTP id F1756969950
	for <git@vger.kernel.org>; Mon, 12 Feb 2007 21:14:04 +0100 (CET)
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp4-g19.free.fr (Postfix) with ESMTP id DAC7F90C8
	for <git@vger.kernel.org>; Mon, 12 Feb 2007 21:13:01 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1CKAPCo014871
	for <git@vger.kernel.org>; Mon, 12 Feb 2007 21:10:25 +0100
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39432>

Hi,

I am trying to understand how to publish/export my repository to
put it onto a HTTP server from which, I hope, someone could clone
or pull from it.

Sadly, I think I do not have the right recipe to achieve this.

I hope you will be able to comment how I do things and tell
what's wrong:

1. Repack current repository (just in case)

git repack -d

2. Clone current repository

git clone --bare -l . /tmp/my-cloned.git

3. Update cloned repository informations

git --bare --git-dir=/tmp/my-cloned.git update-server-info


Then I upload this to my HTTP server.

When I want to clone the result from my HTTP server, here is what
I get:

Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?


Note that I do not have git installed onto my HTTP server (since
I can't do that) neither is gitweb.

What is wrong this ?

Regards,

Xavier
