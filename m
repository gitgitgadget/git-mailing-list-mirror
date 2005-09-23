From: Robert Watson <robert.oo.watson@gmail.com>
Subject: [RFC] Do we still need the git command?
Date: Fri, 23 Sep 2005 12:24:42 +0100
Message-ID: <72499e3b050923042466011c4f@mail.gmail.com>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Sep 23 13:25:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIlfw-00078E-KF
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 13:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVIWLYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 07:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVIWLYp
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 07:24:45 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:8576 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750841AbVIWLYp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 07:24:45 -0400
Received: by qproxy.gmail.com with SMTP id v40so154232qbe
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 04:24:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JJcyXDiSb2LLJRhjDI1BIHxfrFysPhH3g4Nbt8Ljdgw2V2k002jnzY8OMWdxu5e4rVUE+Xw4M1DNIxvCZBE4KRKoyPD+x7wiefD36a+CMRK5WJh+ytpJJGiJifrLouJzidHTrc82cB6tA0YQPbWwtblDw39TBTSzGf2sWA1k3mo=
Received: by 10.64.249.16 with SMTP id w16mr216740qbh;
        Fri, 23 Sep 2005 04:24:42 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Fri, 23 Sep 2005 04:24:42 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9177>

Hello,

The function of the git command:

(1) As an alias for git-command.  After the recent big tool rename,
all "git                         command" can be replaced by
"git-command".
(2) Report version number.  This can be solved by a git-version
command.                             (3) List interesting commands. 
This can be taken care by man git(7) or TAB-TAB.  Or, add a git-help
command to list only interesting commands.

How about get rid of the git command all together?

Cons:
(1) Another change of the user interface;
(2) Different style from CVS/SVN.

Pros:
(1) Consistency.  There is only one way to do it.  People won't be
wondering what's the difference between "git-diff" and "git diff".
(2) Performance.  One less shell script to parse and one less exec system call.
(3) TAB completion.  git-whatchanged and other long commands are
easier to type with TAB completion.  TAB-TAB also shows you all
available commands.
(4) Do not conflict with GNU Interactive Tools.  Make the life of
Debian people easier.

What do you think?

Robertoo
