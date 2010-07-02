From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Issues with line-endings and autocrlf setting after SVN to Git 
	transition
Date: Fri, 2 Jul 2010 15:59:43 -0400
Message-ID: <AANLkTilsvEbwHhIkvpaZQ4542tH2i6qF4EZR1IjErp46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 22:00:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUmP8-0006q1-9d
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 22:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759976Ab0GBT7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:59:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37518 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759913Ab0GBT7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:59:44 -0400
Received: by qwh6 with SMTP id 6so204106qwh.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:59:43 -0700 (PDT)
Received: by 10.224.37.3 with SMTP id v3mr747808qad.156.1278100783244; Fri, 02 
	Jul 2010 12:59:43 -0700 (PDT)
Received: by 10.229.181.3 with HTTP; Fri, 2 Jul 2010 12:59:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150162>

So I'm running into the infamous issue with line-endings after
migrating an SVN repo to Git.

I'm on OS X and I currently have auto.crlf set to "input" as
recommended on this GitHub page:
http://help.github.com/dealing-with-lineendings/. I'm doing a fresh
clone of our repo and it's showing many files as having changed.

I've gotten conflicting answers to my question on Stack Overflow:
http://stackoverflow.com/questions/3161797/will-the-fix-to-correct-line-endings-in-git-repositories-make-future-diffs-usel.
Should I fix this with a commit or turn off autocrlf? I intend to use
this repo in both OS X and Windows environments. The problem with
fixing it with a commit is that the commit will change every single
line of these affected files. As I understand it from SVN, this means
that any diffs that span that commit will basically show the entire
files as being changed which is definitely frustrating.
