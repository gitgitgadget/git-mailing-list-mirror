From: Andreas Ericsson <ae@op5.se>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Fri, 26 Jun 2009 07:15:05 +0200
Message-ID: <4A445959.6090403@op5.se>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 07:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3mQ-00015X-S1
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 07:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZFZFPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 01:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZFZFPI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 01:15:08 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55128 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751269AbZFZFPI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 01:15:08 -0400
Received: from source ([72.14.220.158]) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkRZXCHe8NDTRe6K4dGAjNU4N1qqpB1o@postini.com; Thu, 25 Jun 2009 22:15:11 PDT
Received: by fg-out-1718.google.com with SMTP id l27so1471179fgb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 22:15:08 -0700 (PDT)
Received: by 10.86.51.2 with SMTP id y2mr3371346fgy.3.1245993308375;
        Thu, 25 Jun 2009 22:15:08 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm438379fga.18.2009.06.25.22.15.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 22:15:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122278>

Hin-Tak Leung wrote:
> (I'm not on list so please CC) - I am trying to git svn clone mono's
> repository, and for some strange reason it is doing a complete check
> out from revision 1 all the way to each branch/tag . Is this normal or
> am I doing anything wrong? I have git svn clone a few other things
> recently (R, ghostscript) and I don't remember git doing this, but R
> is quite a normal svn layout and I think I only have ghostcript trunk
> (no branch/tag).
> 
> What I did was this: I started out with just git-svn clone trunk
> (which generated the first two [now-commented out] lines), then I
> thought I also want 2.4 branch so I added the next commented-out
> section, and ran 'git svn fetch --all'. Then I thought I like the
> whole thing - so I commented out most of it and added the 4 lines as
> blow - which is also my current git config.
> 
> The problem is that it seems to treat every tag as a branch,

This is normal. SVN makes no real distinction between tags and branches,
so git-svn has no way of detecting which is which. SVN also allows
committing to "tags", so it doesn't make sense for git to store what
SVN calls tags as git tags.

As for your other questions, I don't know.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
