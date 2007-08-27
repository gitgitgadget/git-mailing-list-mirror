From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Confusion about diffing branches
Date: Tue, 28 Aug 2007 00:20:23 +0200
Organization: At home
Message-ID: <favin5$2sm$1@sea.gmane.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 00:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPmxn-000050-8N
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 00:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbXH0WVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 18:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbXH0WVG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:21:06 -0400
Received: from main.gmane.org ([80.91.229.2]:37380 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301AbXH0WVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 18:21:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPmwx-0004Ef-3F
	for git@vger.kernel.org; Tue, 28 Aug 2007 00:20:47 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 00:20:47 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2007 00:20:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56886>

Shawn Bohrer wrote:

> I must admit that for me, a new git user, it would be much more
> intuitive if all git commands used the same syntax for specifying
> revisions. =A0After all every other git command that I have used so f=
ar
> uses the opposite syntax as git-diff. =A0This includes git-log,
> git-format-patch, gitk, git-rev-list, and git-rev-parse.

git-rev-list, git-log, gitk accepts _range_ of commits. git-diff and
its variants accepts _endpoints_ to compare, with some syntactic sugar
to be able to copy arguments from "git log a..b" to "git diff a..b".=20
The arguments are just simply different type.

As to git-format-patch, there is matter of backward compatibilty
and ease of use (get last commit as a patch).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
