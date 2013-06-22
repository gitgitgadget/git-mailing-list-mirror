From: =?iso-8859-1?Q?Andr=E9_H=E4nsel?= <andre@webkr.de>
Subject: Is there a hook that runs on git reset?
Date: Sat, 22 Jun 2013 20:52:57 +0200
Message-ID: <0b6a01ce6f79$b62de4b0$2289ae10$@webkr.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 20:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqT2L-0007du-5s
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 20:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab3FVS7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 14:59:45 -0400
Received: from webkr.de ([78.47.151.182]:56917 "HELO mail.webkr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751090Ab3FVS7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 14:59:44 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jun 2013 14:59:44 EDT
Received: (qmail 19506 invoked from network); 22 Jun 2013 18:53:01 -0000
Received: from business-213-023-138-046.static.arcor-ip.net (HELO andrePC) (andre@webkr.de@213.23.138.46)
  by mail.webkr.de with SMTP; 22 Jun 2013 18:53:01 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac5vea8Ctue5i9oqSny/PUdWVa1aFg==
Content-Language: de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228717>

I am using a script that runs as post-checkout and post-merge hook to ensure
some permissions on the working copy files.

Neither of these hooks is run on git reset, so after a git reset --hard the
permissions are lost because apparently the files were created freshly. I
guess I would have expected post-checkout to run.

Is there a hook that runs on git reset that I can use to run my permissions
script?
