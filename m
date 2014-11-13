From: Thomas Koch <thomas@koch.ro>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 17:10:11 +0100
Message-ID: <201411131710.12409.thomas@koch.ro>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xox6z-0006j6-GY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbaKMQTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 11:19:04 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:47081 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933262AbaKMQTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 11:19:03 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 9F888424FE;
	Thu, 13 Nov 2014 17:10:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240]) (using TLS with cipher AES256-GCM-SHA384)
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTPS id cD4yGuri044q; Thu, 13 Nov 2014 17:10:15 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.16-0.bpo.3-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If your servers run a Unix and you can install Git on the servers than you 
might want to try the install script we use in our company:

https://github.com/comsolit/comsolit_deploy

There's a bare git repository on the server and a post-receive hook that 
exports the content of the git repository in a predefined folder. After that a 
symlink is switched to the new version.

You can run hook scripts after the export (checkout) and after the switch.

The script lacks documentation... (PRs welcome!) But it is unit tested!

Regards, Thomas Koch
