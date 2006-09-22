From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: Re: git commands that only work correctly at top directory
Date: Fri, 22 Sep 2006 19:08:59 +0200
Message-ID: <20060922170859.119780@gmx.net>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 22 19:09:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQoWW-0005yA-NH
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 19:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWIVRJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWIVRJD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 13:09:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:61075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932597AbWIVRJB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 13:09:01 -0400
Received: (qmail 23195 invoked by uid 0); 22 Sep 2006 17:08:59 -0000
Received: from 141.130.250.71 by www063.gmx.net with HTTP;
 Fri, 22 Sep 2006 19:08:59 +0200 (CEST)
In-Reply-To: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
To: git@vger.kernel.org
X-Authenticated: #20307258
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27530>


-------- Original-Nachricht --------
Datum: Fri, 22 Sep 2006 16:21:09 +0700
Von: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
An: git@vger.kernel.org
Betreff: git commands that only work correctly at top directory

Did you set $GIT_DIR? ... to an absolute path or "./.git" ?

> Here is the list (checks are done in with 1.4.2.rc4):
> count-objects (always 0 objects, 0 kilobytes)

Works for me in every directory with GIT_DIR abolute or ./.git

> bisect (fatal: Not a git repository: '.git'. Bad HEAD - I need a symbolic
> ref)

with an absolute GIT_DIR works from every directory - at least bisect start

> describe (fatal: Not a valid object name HEAD)

with an absolute GIT_DIR works from every directory.
v1.4.1-gcddb939


> repack (line 42: cd: .git/objects/pack: No such file or directory. And
> it creates a new .git directory in current directory)
> git format-patch in subdir generates files in topdir instead of
> current dir as documented in its man page
> 
> BTW, either git blame or git annotate should be available in git help's
> listing.
> git format-patch with no argument shows nothing. It should show help
> usage instead.
> I might miss some commands because I only tested commands I'm familiar
> with.
> -- 
> Duy


Thomas

-- 
NEU: GMX DSL Sofort-Start-Set - blitzschnell ins Internet!
Echte DSL-Flatrate ab 0,- Euro* http://www.gmx.net/de/go/dsl
