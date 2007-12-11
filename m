From: Markus Klinik <markus.klinik@gmx.de>
Subject: git-cvsexportcommit fails for huge commits
Date: Tue, 11 Dec 2007 21:04:18 +0100
Message-ID: <20071211200418.GA13815@mkl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 21:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BMP-0004Kf-4Y
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXLKUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbXLKUEW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:04:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:43585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbXLKUEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:04:21 -0500
Received: (qmail invoked by alias); 11 Dec 2007 20:04:19 -0000
Received: from f051090227.adsl.alicedsl.de (EHLO localhost) [78.51.90.227]
  by mail.gmx.net (mp037) with SMTP; 11 Dec 2007 21:04:19 +0100
X-Authenticated: #4146147
X-Provags-ID: V01U2FsdGVkX18WrXtIPhwWLWLsyWJvHZScU8PA/whlvhQ7Fzlf0X
	48+6cJZd0pjsVp
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67928>

Hi,

git-cvsexportcommit fails for huge commits, that is commits with lots of files.
To be exact, the problem arises if the generated 'cvs status' command exceeds
the maximum length for commands.

Here is the error:

Can't exec "cvs": Argument list too long at /home/mkl/bin/git-cvsexportcommit
line 334.  Argument list too long 0 at /home/mkl/bin/git-cvsexportcommit line
334.  cvs status [snip: long, long list of files]  1792 at
/home/mkl/bin/git-cvsexportcommit line 332.

The complete error message was 334523 characters long before I snipped the
files.

Used version is from public git repository, Tue Dec 11 20:59:01 CET 2007
(bf82a15095ed374496c2e98b6b672aa8c8c4d034).
