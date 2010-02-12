From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 13:25:32 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-519083.13253112022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 22:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng31T-0006g7-Op
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab0BLVZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 16:25:54 -0500
Received: from lo.gmane.org ([80.91.229.12]:38099 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab0BLVZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:25:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng31M-0006bo-HS
	for git@vger.kernel.org; Fri, 12 Feb 2010 22:25:52 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 22:25:52 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 22:25:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139748>

In article <4B75BD06.1010802@lsrfire.ath.cx>,
 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> Am 12.02.2010 13:03, schrieb Ron Garret:
> > Before I reinvent the wheel...
> >=20
> > I would like to be able to store snapshots of individual files with=
out=20
> > making a commit on the main branch.  The scenario is that I've writ=
ten=20
> > some experimental code that I have decided not to keep as part of t=
he=20
> > main project, but which I might want to refer back to some day.  Is=
=20
> > there any easy way of doing that in git?
>=20
> You could keep the experimental files (or changes) in a separate,
> private branch on your local repository.
>=20
> Ren=C3=A9

Yeah, I considered that.  The problem with that is that the actual=20
process turns out to be pretty obtrusive.  The scenario is that I've=20
done a bunch of hacking on the main branch and I realize that it's goin=
g=20
nowhere.  Nothing is working, everything is a horrible mess that's=20
spinning wildly out of control.  I want to get rid of everything I've=20
done and start over from an earlier snapshot that I knew was working. =20
But I also want to keep a copy of this current messy state around for=20
reference just in case there's a snippet here and there that might be=20
salvageable later on.  I don't know of any easy way to save the messed=20
up file onto another branch.  I'd have to save the file somewhere (in=20
the stash maybe?), check out the snapshot branch, retrieve the saved=20
file, do the commit, and then switch back to the main branch.

But maybe the right answer is to just write a script that does all that=
=20
automatically?

rg
