From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 07 Feb 2007 23:29:56 +0100
Organization: At home
Message-ID: <eqdjt3$jo5$1@sea.gmane.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 23:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvJ8-0006YF-Jp
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464AbXBGWaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 17:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbXBGWaQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:30:16 -0500
Received: from main.gmane.org ([80.91.229.2]:36022 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161464AbXBGWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:30:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEvIf-0005kO-JN
	for git@vger.kernel.org; Wed, 07 Feb 2007 23:30:01 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 23:30:01 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 23:30:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38982>

[Cc: git@vger.kernel.org]

Bill Lear wrote:

> I thought that it would be very useful to have a history of git
> commands that have been run against a repo, in order to hopefully
> debug this sort of thing --- perhaps only those that modify the repo.
>=20
[...]
> Would this sort of thing be easy to do? =A0I presume git does not
> currently have support for this, but thought I would ask.

If all commands were run via git wrapper (and all scripts would
use git-command version, perhaps with exception of gitweb), it
would be fairly easy to do (although this should probably be
repository config variable).

Is history of shell commands too short? Reflogs doesn't help
(concatenate all reflogs, perhaps preceding them with file name,
and sort by date) either?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
