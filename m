From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git merge man page, upstream
Date: Tue, 23 Oct 2012 09:40:25 +0200
Message-ID: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 09:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQZ6O-0006nk-4X
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 09:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab2JWHk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 03:40:26 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61004 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2JWHkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 03:40:25 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2558774pad.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nGK7cWGgyw7EGCov4j8nGni2dFyUj3oyPz8kTAdfUaE=;
        b=zFEEByn2OrjZq3/NYe7iuxD0LtHtpqy9fTuEWc+j3Nc1SggajTyNKIHlOS2ILIZo/m
         k3ee8hliWZT56oKKLeJC9WQUnbHYCxDBMohjxoco2LtK/W/WTVLzEMW1hNp2lu7ameMJ
         +jcShw29hmozWygrZ/ec/jkbypp5kd5e3eiu7uMWgqdd0BwN6ebhgbZbntCmCYMd5ibC
         gSb6lky7VDNvfjjuxA/zdJWXO25QnyZ7q/uuygsTvNUim4OaaO9Z6thfZhm53f7hF6ld
         XmG7ugWpWY8WeA35v9Y2fTFTDZNKiFCMCinsn+VGrKghIiSsnwaEXUxgbJmVbLZ8TiKd
         HdRA==
Received: by 10.68.200.72 with SMTP id jq8mr37450925pbc.38.1350978025167; Tue,
 23 Oct 2012 00:40:25 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Tue, 23 Oct 2012 00:40:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208216>

Hello,

the git merge man page, OPTIONS, <commit> ... states:

   "If no commit is given from the command line, and if
merge.defaultToUpstream configuration variable is set, merge the
remote tracking branches that the current branch is configured to use
as its upstream. See also the configuration section of this manual
page."

Actually, in this case git merge merges the upstream branch, not the
remote tracking branch.

Proposed change:

   "If no commit is given from the command line, and if
merge.defaultToUpstream configuration variable is set, merge the
upstream branches that the current branch has currently configured.
See also the configuration section of this manual page."

-Angelo Borsotti
