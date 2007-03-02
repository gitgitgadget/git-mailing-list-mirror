From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 02 Mar 2007 14:56:49 +0100
Organization: At home
Message-ID: <es9aal$5gf$1@sea.gmane.org>
References: <200703011206.47213.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 14:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN8Ds-0007uo-Uf
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 14:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992432AbXCBNy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992436AbXCBNy5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 08:54:57 -0500
Received: from main.gmane.org ([80.91.229.2]:49122 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992432AbXCBNy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 08:54:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HN8Da-0002vd-32
	for git@vger.kernel.org; Fri, 02 Mar 2007 14:54:42 +0100
Received: from host-81-190-24-11.torun.mm.pl ([81.190.24.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 14:54:42 +0100
Received: from jnareb by host-81-190-24-11.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 14:54:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-11.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41206>

Andy Parkins wrote:

> + - prettyfilter
> + =A0 Run by git-cat-file or git-show when content is being pretty-pr=
inted
> + =A0 for display to the user. =A0If no prettyfilter is set, then it =
should
> + =A0 default to outfilter.

I'd rather have plumbing operate without filters (if it is possible),
so git-cat-file would not run prettyfilter, and git-show would run it.

Or at least detect if output is tty, so one can do something like
"git cat-file -p v1.0.0:gitweb/git-logo.png > git-logo.png" and get
expected result, while "git show v1.0.0:gitweb/git-logo.png" would
show the image.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
