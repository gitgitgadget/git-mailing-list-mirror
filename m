From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Tue, 17 Apr 2007 04:30:47 +0200
Organization: At home
Message-ID: <f01b9g$qqc$1@sea.gmane.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org> <20070417022154.GC30340@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 04:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HddPc-00082q-LX
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 04:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbXDQC1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Apr 2007 22:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXDQC1R
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 22:27:17 -0400
Received: from main.gmane.org ([80.91.229.2]:51769 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbXDQC1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 22:27:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HddPO-0001w9-Ml
	for git@vger.kernel.org; Tue, 17 Apr 2007 04:27:07 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:27:06 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:27:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44709>

Theodore Tso wrote:

> The one thing that's a bit unfortunate is that with the commit ID
> taking up 40 characters, very often there's not enough space on the
> screen to display all of the tags and references (and with the defaul=
t
> less options being hardcoded as "-FRSX", the ones that go beyond the
> width of the screen get lost. =A0
>=20
> So I tried to use --abbrev, and it didn't shrink the size of the id,
> like I thought it would. =A0It didn't object to the option, but
> apparently it ignored it. =A0Funny, I thought it worked before, but i=
t
> wasn't before I applied the patch, so it wasn't your patches that wer=
e
> at fault.

You have to use --abbrev-commit (--abbrev is opassed to log machinery, =
and
covers object ids), which is undocumented option (mentioned only in pas=
sing
in git-reflog(1)).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
