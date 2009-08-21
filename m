From: D Sundstrom <sunds@peapod.net>
Subject: Raw commands to add object to existing tree
Date: Fri, 21 Aug 2009 17:31:19 -0500
Message-ID: <ef72456d0908211531m5e261805p2f67d3a8a16a0b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 00:31:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mecdt-0000FR-S1
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbZHUWbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932951AbZHUWbS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:31:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:63288 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870AbZHUWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:31:18 -0400
Received: by qw-out-2122.google.com with SMTP id 8so640834qwh.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:31:19 -0700 (PDT)
Received: by 10.229.43.211 with SMTP id x19mr467930qce.3.1250893879162; Fri, 
	21 Aug 2009 15:31:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126767>

Both the community git manual:
http://book.git-scm.com/7_raw_git.html

and Pro Git book:
http://progit.org/book/ch9-2.html

walk you though low level details of creating objects and trees in git, and
then committing these new trees.

However, they do not show you how to add and commit into existing trees.

Speaking in terms of files, I have a web application that needs to replace
a file in a known directory in a known branch of a bare repository.  I know the
SHA1s of the directory tree and file.  I want to commit directly into a bare
repository to avoid having to manage working directories for different
branches from the web application.

Thanks!
David
