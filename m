From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: Commit a series of patches to SVN without rebase
Date: Sun, 23 Dec 2007 23:59:13 +0000 (UTC)
Message-ID: <slrnfmttoo.28m.joerg@alea.gnuu.de>
References: <20071220164044.GA22683@alea.gnuu.de>
 <20071222045340.GA21524@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 01:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6bIQ-0003bH-V0
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 01:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXLXAf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Dec 2007 19:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbXLXAf2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 19:35:28 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:1735 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbXLXAf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 19:35:27 -0500
X-Greylist: delayed 1613 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Dec 2007 19:35:27 EST
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id D191B488073; Mon, 24 Dec 2007 01:08:32 +0100 (CET)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1J6aiw-0001VP-0F
	for git@vger.kernel.org; Mon, 24 Dec 2007 00:59:14 +0100
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1198454353 3290 192.168.0.5 (23 Dec 2007 23:59:13 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-69 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69199>

Hi Eric,

Eric Wong <normalperson@yhbt.net> wrote:
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> wrote:
>> I've a number of patches in git I want to send to a SVN repository. =
git
>> svn dcommit does a rebase after each commit which makes the whole co=
mmit
>> takes very long. Is it possible to skip the rebase? All patches are =
in
>> one branch without merges, a simple chain. Is it save to use --no-re=
base
>> in this case?
>
> Right now, only if the changes don't depend on each other (they all
> modify different files).

May I ask you what the rational behind doing a rebase every time is? Is
it needed? Why is it not possible to send all commits and do one rebase
after the last one?

Bye, J=C3=B6rg.
--=20
Wer A sagt, mu=C3=9F nicht B sagen. Er kann auch erkennen, da=C3=9F A f=
alsch war.
      	    	      	       	       	    	(Erich K=C3=A4stner)
