From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Fri, 11 Jul 2008 14:25:58 +0200
Message-ID: <g57jkp$ekm$1@ger.gmane.org>
References: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 14:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHHkX-0004Di-BG
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 14:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbYGKM2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2008 08:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYGKM2X
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 08:28:23 -0400
Received: from main.gmane.org ([80.91.229.2]:37149 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbYGKM2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 08:28:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHHjZ-00025z-EB
	for git@vger.kernel.org; Fri, 11 Jul 2008 12:28:21 +0000
Received: from dialin-145-254-068-004.pools.arcor-ip.net ([145.254.68.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 12:28:21 +0000
Received: from mailing_list by dialin-145-254-068-004.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 12:28:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-068-004.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <g5570s$d5m$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88112>

Stephan Hennig schrieb:

> I am observing very large data transfers when pulling from the
> repository at <URL:http://repo.or.cz/w/wortliste.git>.

Here's the output of a recent pull:

> unknown@COMMODORE ~/Themen/trennmuster/repository/wortliste (master)
> $ git pull
> Enter passphrase for key '/x/home/.ssh/id_rsa':
> remote: Counting objects: 15, done.=E2=86=90[K
> remote: Compressing objects: 100% (7/7), done.=E2=86=90[K)   =E2=86=90=
[Kts:   8% (1/12)
> remote: Total 12 (delta 5), reused 12 (delta 5)=E2=86=90[K
> Unpacking objects: 100% (12/12), done.
> From git+ssh://xxx@repo.or.cz/srv/git/wortliste
>    d905095..d0c6a33  master     -> origin/master
>  * [new tag]         dehyph-exptl-v0.13 -> dehyph-exptl-v0.13
> Updating d905095..d0c6a33
> Fast forward
>  wortliste=E2=86=90[m |   19 =E2=86=90[32m+++++++++++=E2=86=90[m=E2=86=
=90[31m--------=E2=86=90[m
>  1 files changed, 11 insertions(+), 8 deletions(-)=E2=86=90[m

After the line containing "remote: Compressing objects:" had been
printed several MB have been transferred.

Does it matter that the original clone has been performed with plain gi=
t
protocol?  I have only later changed the url in .git/config to use git+=
ssh.

Best regards,
Stephan Hennig
