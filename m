From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Sat, 14 Jul 2007 02:44:14 +0200
Organization: At home
Message-ID: <f7968s$j44$1@sea.gmane.org>
References: <vpq8x9k9peu.fsf@bauges.imag.fr> <11843484982037-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 02:44:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9VkL-0004ZH-EG
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387AbXGNAo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Jul 2007 20:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbXGNAo0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:44:26 -0400
Received: from main.gmane.org ([80.91.229.2]:46843 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758381AbXGNAo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 20:44:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I9VkB-0001Ok-HO
	for git@vger.kernel.org; Sat, 14 Jul 2007 02:44:19 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 02:44:19 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 02:44:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52428>

Matthieu Moy wrote:

> In the previous behavior, "git-rm --cached" (without -f) had the same
> restriction as "git-rm". This forced the user to use the -f flag in
> situations which weren't actually dangerous, like:
>=20
> $ git add foo =A0 =A0 =A0 =A0 =A0 # oops, I didn't want this
> $ git rm --cached foo =A0 # back to initial situation
>=20
> Previously, the index had to match the file *and* the HEAD. With
> --cached, the index must now match the file *or* the HEAD. The behavi=
or
> without --cached is unchanged, but provides better error messages.

Sensible.

There might be some discussion if what git-rm without --cached does
is right, but that is besides scope of this patch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
