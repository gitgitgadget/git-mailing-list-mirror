From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Fri, 26 Jan 2007 12:34:55 +0100
Organization: At home
Message-ID: <epcouq$co3$1@sea.gmane.org>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 12:34:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPLQ-0005h9-TR
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbXAZLeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 06:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXAZLeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:34:09 -0500
Received: from main.gmane.org ([80.91.229.2]:46583 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965017AbXAZLeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:34:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAPLE-0003of-BU
	for git@vger.kernel.org; Fri, 26 Jan 2007 12:34:00 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 12:34:00 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 12:34:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37843>

[Cc: git@vger.kernel.org]

Horst H. von Brand wrote:
> @@ -30,12 +30,12 @@ and executable, it is called with three parameter=
s:
> =A0
> =A0 =A0 =A0 =A0 $GIT_DIR/hooks/update refname sha1-old sha1-new
> =A0
> -The refname parameter is relative to $GIT_DIR; e.g. for the
> -master head this is "refs/heads/master". =A0Two sha1 are the
> -object names for the refname before and after the update. =A0Note
> -that the hook is called before the refname is updated, so either
> -sha1-old is 0{40} (meaning there is no such ref yet), or it
> -should match what is recorded in refname.
> +The refname parameter is relative to $GIT_DIR; e.g. for the master
> +head this is "refs/heads/master". =A0The two sha1 are the object nam=
es
                                              ^^^^
> +for the refname before and after the update. =A0Note that the hook i=
s
> +called before the refname is updated, so either sha1-old is 0{40}
> +(meaning there is no such ref yet), or it should match what is
> +recorded in refname.

=46irst, it does some reformatting instead of making documentation
always use SHA-1.  Second, it does not replace sha1 by SHA-1 (sic!).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
