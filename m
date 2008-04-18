From: JM Ibanez <jm@orangeandbronze.com>
Subject: Re: git svn should refuse to checkin .svn directories
Date: Sat, 19 Apr 2008 05:09:06 +0800
Organization: Orange & Bronze Software Labs, Ltd. Co.
Message-ID: <873apian0t.fsf@armitage.orangeandbronze.local>
References: <200804181346.50755.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Git Mailing List <git@vger.kernel.org>
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Sat Apr 19 09:21:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmxqz-0002hr-Gs
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 23:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763474AbYDRVJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763466AbYDRVJS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 17:09:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:19965 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763465AbYDRVJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 17:09:14 -0400
Received: by wf-out-1314.google.com with SMTP id 28so586012wff.4
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 14:09:13 -0700 (PDT)
Received: by 10.143.160.1 with SMTP id m1mr791579wfo.9.1208552953614;
        Fri, 18 Apr 2008 14:09:13 -0700 (PDT)
Received: from armitage ( [58.69.81.200])
        by mx.google.com with ESMTPS id 30sm671248wfa.2.2008.04.18.14.09.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Apr 2008 14:09:12 -0700 (PDT)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUBAQEPDw8aGhoiIiIy
 MjJGRkZaWlp0dHScnJy+vr7R0dHb29vn5+fx8fH29vb///+JzcfYAAAAAWJLR0QAiAUdSAAAAAlw
 SFlzAAAewgAAHsIBbtB1PgAAAi5JREFUOMul1E9o01AYAPAvUQ87JV+3gcemrYi32q7oQRC7gtWD
 OLs6jx5svQhDCk0GggeHTaWgt/ZF5gRlkHZePCg0lTE8SWvnUXHU3QRxyYYryrCpr4PlT81OeyE5
 fD/y5b0v73vQP2DA4aBcWvMEQjJvPKAiF66nhSsrw9CNFnOIo3PyMKRj6cmoEJt/sOiGrhBHFpnx
 qdScG64FAODEWCJ9ddoFOyhQGJ3wx6eCj51wOoDAABNmghHfrAP+BC4gD8AzvI8Nn3HAr0xUQJoL
 WIbng+dtmB58AXiajd7MfQu6ftgfNCFrvbENdpwC4j5sWXFm73HMSrVqxfdmMG7Be2BxIpGYDIIw
 mPSYPSuYEUVRKmTjg2ViyIYtpSITeuUEnkdfzFGSWr1aJwoppwLI+C46QFWVOlluatrbCJ5MOqCp
 1bTyrUsfO8bn1MK3NRt8Txsv8Wi+pOumpLUcAMebD7NK651h/LintlZsyEaUQkjStI7595XaWrQg
 BDhyF2Ck1NNN42tz1gIBjswMinGj0zfM9RZn/yiAyzcp3NH7Rr/93YZtZM69pmV6plMxNhzrSLEL
 XxCZtkHjq5wDfkvt9Rd4qm2YfZNzbp/eB13/ebth0Ew9N6ib+uYSrYhufnJv0eTyUvpRodrobHBu
 2CGiRHJniw0YboOKmE1hUnzODcNuRVJIPgP/txohspoPcx49SHfDPOfRnLtyUfZ79nmt+oTzhCKB
 A04GONwh8w9J0EXBeLkUcQAAAABJRU5ErkJggg==
Jabber-ID: jmibanez@gmail.com
In-Reply-To: <200804181346.50755.thomas@koch.ro> (Thomas Koch's message of
	"Fri, 18 Apr 2008 13:46:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79875>

--=-=-=

Thomas Koch <thomas@koch.ro> writes:

> As you might guess I just annoyed my collegues by (temporarily) destroying our 
> svn repo. Nobody could checkout anymore, because I accidently checked in 
> a .svn directory with git svn.
>
> I'm lucky that I'm still allowed to use git svn to work on our svn repo...
>
> Maybe you could add a warning or something else to avoid .svn directories to 
> be ever checked in via git svn.
>
> I'm sure that there is also a config option somewhere to get .svn directories 
> ignored (also subdirs when adding the parent dir?). But this check should 
> really be a default setting to avoid other newcommers to get into trouble 
> because they gave git svn a try.

Well, this isn't a patch to git-svn, but this may help those working
with upstream SVN repositories via git and git-svn. Add this as the
pre-commit hook in .git/hooks (make sure to make it executable).


--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=pre-commit

#!/bin/sh
#
# Used in a git repo interacting with an upstream SVN repo, this
# pre-commit hook will not allow a commit of any directory named .svn


if (git diff-index HEAD | cut -f2 | grep "^\(.*/\)*\.svn/" 2>&1 > /dev/null); then
    echo "Cowardly refusing to commit an .svn directory"
    exit 1
fi

    

--=-=-=



-- 
JM Ibanez
Software Architect
Orange & Bronze Software Labs, Ltd. Co.

jm@orangeandbronze.com
http://software.orangeandbronze.com/

--=-=-=--
