From: Warren Turkal <wt@penguintechs.org>
Subject: git-svn
Date: Tue, 28 Sep 2010 21:51:55 -0700
Message-ID: <AANLkTimd3qjiwtHw0K4S6XQnhrABzoa=ySxW=dXmOFD8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 06:52:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0oet-0006BY-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 06:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab0I2Ewm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 00:52:42 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58247 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab0I2Ewl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 00:52:41 -0400
Received: by qyk36 with SMTP id 36so437926qyk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 21:52:16 -0700 (PDT)
Received: by 10.229.223.210 with SMTP id il18mr770432qcb.133.1285735936226;
 Tue, 28 Sep 2010 21:52:16 -0700 (PDT)
Received: by 10.229.24.196 with HTTP; Tue, 28 Sep 2010 21:51:55 -0700 (PDT)
X-Originating-IP: [67.160.195.120]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157528>

Eric,

I see that you are the maintainter of git-svn. I have a couple
questions about git-svn:
* I've come across [1] in an effort to make a --use-log-author and
--add-log-from defaults. I've tested and it works. Would it be
possible to pull in the patch at [2] to document this behavior in the
manpage?
* If it would be easier, should I redo the patch and make it available
on a public git repo so that you can pull it into your repo?

As an aside, I grepped for addAuthorFrom and useLogAuthor in the git
source and didn't find it. Does git svn do something like read svn
section git configs for all options that transform like
--use-log-author to useLogAuthor? Can I specify any other command line
options I want that way, or are --use-log-author and --add-log-from
special some how?

[1]http://kerneltrap.org/mailarchive/git/2008/6/23/2205444
[2]http://kerneltrap.org/mailarchive/git/2008/6/24/2215274

Thanks a bunch,
wt
