From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Tue, 29 Aug 2006 12:15:10 +0200
Organization: At home
Message-ID: <ed142v$fbi$1@sea.gmane.org>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org> <11567998513000-git-send-email-jnareb@gmail.com> <7vveocpfa3.fsf@assigned-by-dhcp.cox.net> <ed0ths$okn$1@sea.gmane.org> <7vu03voqss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 29 12:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI0ct-00080m-8A
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 12:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWH2KPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Aug 2006 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWH2KPT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 06:15:19 -0400
Received: from main.gmane.org ([80.91.229.2]:7843 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964875AbWH2KPR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 06:15:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GI0cg-0007xq-RZ
	for git@vger.kernel.org; Tue, 29 Aug 2006 12:15:10 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 12:15:10 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 12:15:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26199>

Junio C Hamano wrote:

> =A0(3) I'd like to eventually get rid of the abbreviated commit
> =A0 =A0 =A0object name from blame output, so the setting in gitweb.cs=
s
> =A0 =A0 =A0for table.blame td.age[012] (different colors and font
> =A0 =A0 =A0styles) is not appropriate for what I am shooting at.

What do you want to replace it with? Link can be to "commit" or "commit=
diff"
view, but some marker for commit (perhaps 'git-name-rev --tags'?) is
needed.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
