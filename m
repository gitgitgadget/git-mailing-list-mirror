From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: "raw" links to blobs at HEAD
Date: Tue, 26 Sep 2006 10:58:28 +0200
Organization: At home
Message-ID: <efaq3h$e65$2@sea.gmane.org>
References: <20060926053920.47709.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Sep 26 11:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS8na-0006Wh-DX
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 11:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWIZJAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Sep 2006 05:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIZJAO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 05:00:14 -0400
Received: from main.gmane.org ([80.91.229.2]:58049 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750815AbWIZJAN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 05:00:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GS8nK-0006UG-Eb
	for git@vger.kernel.org; Tue, 26 Sep 2006 11:00:02 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 11:00:02 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 11:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27787>

Luben Tuikov wrote:

> Currently there is no HTML interface which references (or
> can be externally referenced) to yield a _binary_ blob at
> HEAD. =A0There is one for non-binary blobs, but none for
> binary ones.

You can in the same number of steps. First go to _tree_
at head, then click on "raw" link.

It's true that decision that binary files are automatically
redirected to "plain" ("raw") format, so they don't have "html"
output caused that there is no link for binary blob at head.
But I don't think that changing "raw" link to link to HEAD
version, while all other links are to current version is
a good idea...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
