From: Raymond Auge <raymond.auge@liferay.com>
Subject: sadly requesting help
Date: Tue, 30 Mar 2010 18:43:21 -0400
Message-ID: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:43:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwk9h-0005at-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0C3WnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 18:43:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53361 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0C3WnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 18:43:23 -0400
Received: by wyb39 with SMTP id 39so1939601wyb.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 15:43:21 -0700 (PDT)
Received: by 10.216.1.133 with HTTP; Tue, 30 Mar 2010 15:43:21 -0700 (PDT)
Received: by 10.216.155.145 with SMTP id j17mr509549wek.147.1269989001342; 
	Tue, 30 Mar 2010 15:43:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143614>

Hello,

My name is Raymond Aug=C3=A9. I'm a senior developer on the Liferay Por=
tal project.

We had a colo failure over the last day or so and lost the last 50-60
commits on our subversion repository (apparently, our backup strategy
was not granular enough).

Luckily I use Git locally using the git-svn conduit.

I need to rewind my repository to an earlier revision and I'm hoping
not to have to rebuild my local repo as the project is huge and takes
me at least 16 hours to checkout using git-svn.

I tried using:

git svn reset --revision 49343

where 49343 is the last revision before the failure.

But I'm at git version 1.6.3.3 which doesn't support the "reset" operat=
ion.

I tried various incantations of

git reset --hard <hash>

where <hash> matched the subversion revision obtained

git svn find-rev 49343

But that didn't clear the svn indexes which still think it's at the
much later revision.

Does anyone know if there is an alternate way to rewind the "svn"
portion of my repo to "forget" about the revs since 49343 so that I
can restart the fetch process and catch up with the new stream (the
git side seems to be more than ok with it)?


Sincerely,

Raymond Aug=C3=A9
Liferay Inc.
