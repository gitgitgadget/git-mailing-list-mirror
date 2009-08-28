From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [RFC] teamGIT bonjour support
Date: Fri, 28 Aug 2009 12:32:39 +0530
Message-ID: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>, teamgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Aug 28 09:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgvUJ-0006dU-Ry
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 09:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZH1HC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 03:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZH1HC6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 03:02:58 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48172 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZH1HC6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 03:02:58 -0400
Received: by fxm17 with SMTP id 17so1394437fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 00:02:59 -0700 (PDT)
Received: by 10.204.24.130 with SMTP id v2mr615560bkb.33.1251442979317; Fri, 
	28 Aug 2009 00:02:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127273>

Hi,

After a long pause in the development, i am back to drawing boards for =
teamGit.

Ever since i adopted git as my preferred version control system for my
teams, I had this tough time keeping up with every one. Of course this
is a GoodThing(TM) since this means pace of development is rather
good. But it has its usual problems of forcing everyone to religiously
publish _AND_ keep rebasing on main branch every so often. Also my
major problem is that we discover conflicts only _after_ a developer
tries to rebase his work, typically (by design) after he has fully
coded and tested a feature.

The current way to get around this is shouting aloud before you start
working on a new feature/file/section.
However =A0 =A0a. this is not scalable
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b. pron to human errors
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c. pron to inhumane erros and after figh=
ts ;).

So in this regards, I have on my drawing boards a rough design to
1. Publish the current selected topic trees info on local lan.
2. Keep track of interesting topic branches and add alerts when
conflicts bet. selected trees reach alarming levels.
3. Possibly later add authentication mechanism to restrict access.

I plan to do this on LAN using bonjour service discovery, and rest
completely being handled inside teamGIT running as a daemon(may be in
widely abused systray?). (Git will handle actual fetch/conflict
checking etc.)
On a side note i also plan to generate daily reports and configurable
notifications.

So I ask you people, is there a solution already cooking someplace?
may be something i can integrate with teamGIT? (e.g. bonjour plugin
for git dameon)
Any thoughts or comment?
Am i just too stupid to not manage it with documented company wide poli=
cies?

BAIN
