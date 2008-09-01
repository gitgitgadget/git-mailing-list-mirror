From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Improve documentation for --dirstat diff option
Date: Mon, 01 Sep 2008 11:42:54 +0200
Organization: At home
Message-ID: <g9gdev$2un$1@ger.gmane.org>
References: <20080901005028.GA31502@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 11:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5xJ-00007w-Jn
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbYIAJnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 05:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYIAJnK
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:43:10 -0400
Received: from main.gmane.org ([80.91.229.2]:43298 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbYIAJnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:43:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ka5w6-0005cZ-Hc
	for git@vger.kernel.org; Mon, 01 Sep 2008 09:43:02 +0000
Received: from abvq20.neoplus.adsl.tpnet.pl ([83.8.214.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 09:43:02 +0000
Received: from jnareb by abvq20.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 09:43:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq20.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94551>

Heikki Orsila wrote:

> =A0--dirstat[=3Dlimit]::
> -=A0=A0=A0=A0=A0=A0=A0Output only the sub-directories that are impact=
ed by a diff,
> -=A0=A0=A0=A0=A0=A0=A0and to what degree they are impacted. =A0You ca=
n override the
> -=A0=A0=A0=A0=A0=A0=A0default cut-off in percent (3) by "--dirstat=3D=
limit". =A0If you
> -=A0=A0=A0=A0=A0=A0=A0want to enable "cumulative" directory statistic=
s, you can use
> -=A0=A0=A0=A0=A0=A0=A0the "--cumulative" flag, which adds up percenta=
ges recursively
> -=A0=A0=A0=A0=A0=A0=A0even when they have been already reported for a=
 sub-directory.
> +=A0=A0=A0=A0=A0=A0=A0Output the distribution of relative damage (num=
ber of lines added or
> +=A0=A0=A0=A0=A0=A0=A0removed) for each sub-directory. Directories wi=
th damage below
> +=A0=A0=A0=A0=A0=A0=A0a cut-off percent (3% by default) are not shown=
=2E The cut-off percent
> +=A0=A0=A0=A0=A0=A0=A0can be set with "--dirstat=3Dlimit". Damage for=
 a child directory is not
> +=A0=A0=A0=A0=A0=A0=A0counted for the parent directory, unless "--cum=
ulative" is used.

I rather prefer "impact" to "damage". And it should probably be=20
"child directory _shown_".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
