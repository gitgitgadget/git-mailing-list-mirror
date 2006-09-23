From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 22:18:50 +0200
Organization: At home
Message-ID: <ef44r4$km0$1@sea.gmane.org>
References: <200609212356.31806.jnareb@gmail.com> <20060923032948.GE8259@pasky.or.cz> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <7veju2s6bi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 22:19:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDxt-0000qL-UC
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWIWUTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 16:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWIWUTF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:19:05 -0400
Received: from main.gmane.org ([80.91.229.2]:22186 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751524AbWIWUTD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:19:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRDxe-0000nW-RW
	for git@vger.kernel.org; Sat, 23 Sep 2006 22:18:54 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:18:54 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:18:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27624>

Junio C Hamano wrote:

> True. =A0Without looking at Jakub's code under discussion, off the
> top of my head, I wonder if we can do something like this:

The code was to analyse log message line after line, doing loop
over all committags, building list (well, hash to be more exact)
of _exact_ replacements (e.g. in the case of commit_id/commitsha
committag we use exact hash as the replaced part, not generic
regexp to find a sha1).

The idea of doing committag parsing, and preserving replacements
from matching committag and being subject to HTML escaping by using
reference to string has it's merits.

I'd have to think about it.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
