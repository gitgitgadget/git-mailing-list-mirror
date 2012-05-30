From: Thomas Wichern <nordertom@gmx.de>
Subject: git 1.7.10.msysgit.1: different behaviour in ".gitignore" and ".git/info/exclude"
Date: Wed, 30 May 2012 10:43:56 +0200
Message-ID: <96434119.20120530104356@gmx.de>
Reply-To: Thomas Wichern <nordertom@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git-mailing <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 30 10:44:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZeVg-0001My-A7
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 10:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab2E3In7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 04:43:59 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:54381 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932272Ab2E3In6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 04:43:58 -0400
Received: (qmail invoked by alias); 30 May 2012 08:43:56 -0000
Received: from unknown (EHLO w7-wic.gdsdom.inet) [80.150.227.58]
  by mail.gmx.net (mp020) with SMTP; 30 May 2012 10:43:56 +0200
X-Authenticated: #35162558
X-Provags-ID: V01U2FsdGVkX19nIboJG8lnqUWA3XxSstudtlZgLVYYbumnGX87ur
	8mS4kni/PJEs3o
X-Priority: 3 (Normal)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198784>

Hi,

I noticed the following difference when using the pattern "/(*)/"
(ignore all directories where the name is enclosed in parenthesis)

If you have a ".gitignore" - file that contains the pattern "/(*)/", a
directory that matches the pattern is ignored completely.

If you put the same pattern into the ".git/info/exclude" - file, the
pattern does not work - these directories still show up.

I expected that all directories anywhere the repository that match the
pattern to be ignored.

Am I doing something wrong? Is the pattern not correct?

Horrido,
Thomas

---
git version 1.7.10.msysgit.1
Windows 7 Pro
