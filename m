From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A simpler approach to tracking directories (was: The philosophy behind my directory proposal in a nutshell)
Date: Sun, 22 Jul 2007 20:13:23 +0200
Organization: At home
Message-ID: <f806bb$ib1$1@sea.gmane.org>
References: <85fy3hqtwl.fsf@lola.goethe.zz> <85abtola79.fsf@lola.goethe.zz> <20070722175731.GA16658@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 20:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfpa-0002ma-I7
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbXGVSGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757551AbXGVSGz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:06:55 -0400
Received: from main.gmane.org ([80.91.229.2]:37040 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbXGVSGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:06:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICfpQ-0001PN-6C
	for git@vger.kernel.org; Sun, 22 Jul 2007 20:06:48 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 20:06:48 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 20:06:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53283>

Theodore Tso wrote:

> Another way of putting is this single bit of information meaning "kee=
p
> this directory around when empty" is something that ***must*** be
> representable in three different places: in a git tree object, in the
> index, *AND* in the working tree. =A0The problem with "." is that sin=
ce
> all directories contain the "." entry, you can't represent the bit of
> information you want to record in the working tree in that way.

I don't think the "do not delete when empty" bit must be somehow repres=
ented
in the working directory. It is enough to have this bit in index to dea=
l
with working directory, and in the repository to have it persistent.

Compare with submodules, and with unmerged entries (which sometimes do =
not
have worktree representation).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
