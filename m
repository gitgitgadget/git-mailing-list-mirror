From: Nathan Gray <n8gray@n8gray.org>
Subject: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 11:40:54 -0700
Message-ID: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 20:41:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTci-0000VZ-W1
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab2DZSk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:40:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60061 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab2DZSkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 14:40:55 -0400
Received: by bkuw12 with SMTP id w12so1264098bku.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 11:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=gyWNn5fWJVZ1bEMo1dMCgTuOg5BCfkpdlZp95NEktRo=;
        b=KcbfHmyXc9aXTGpMVtCGi2LNEP7HuXwIn33Gr61FnHCIj/PvKmHy7qnATpemihodJI
         zmQBbZFS+XnzH2qXL+9MYVdQkHlWGTvU1HfyfbqIT4EpSaxNGYalaVx6NhBUfyaJ9ijp
         /sbFS3X+RZBYO7t1Kbb9SdrOe2wXfTfCZ/T1VihkAXViovBibDtggF6F2tw6oNJ91h5n
         aL7oxpsyW9aA51+ub2k6rdRyZXUY+6IlkaPeXaPgVS5nWDfdKIZWjwQ5aynPhQ2lcQtu
         WED46eQ7YP9fY6uRnrFe2WHkg196C0ypHipMPEvRt1OYF0QYO+TKzOzrGRINj1C0svNH
         SzAA==
Received: by 10.205.129.8 with SMTP id hg8mr2842876bkc.25.1335465654201; Thu,
 26 Apr 2012 11:40:54 -0700 (PDT)
Received: by 10.205.119.8 with HTTP; Thu, 26 Apr 2012 11:40:54 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
X-Gm-Message-State: ALoCoQkB5yueG9FBQjTHY8QV0PEHeSYVFecdRBPVWmjucg0KBW/tVbKUS0GRu/hWkJ0ibRPLw2gZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196390>

Hey guys,

Namespacing works really well for branch refs.  I know that
remotes/origin/master is origin's master branch.  I may or may not
have a master branch, and it may or may not have anything in common
with origin's.  Our repositories are independent, after all, so it
makes sense that our refs would live in different namespaces.

So why is it that tag refs don't follow this model?  Why is my
"best-commit-ever" tag assumed to be the same as origin's?  Given a
ref in refs/tags it's unclear if the ref is public, private, on origin
or not on origin.  Will pushing my tags create anything new or not?
Who knows?  Compare this to branches, where the same questions are
easy to answer thanks to namespacing.

OTOH, am I just not "getting it?"  I've been using git for about 4
years now and I feel like I know it pretty well but it's possible I'm
just misunderstanding things.

BTW, I just read the "On Automatic following" section of the git tag
man page and I found it very confusing.  It seems to be justifying a
behavior without first describing what the behavior is.

Thanks,
-Nathan

-- 
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
