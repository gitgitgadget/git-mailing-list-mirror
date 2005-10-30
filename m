From: Wolfgang Denk <wd@denx.de>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 18:20:18 +0100
Message-ID: <20051030172018.520BD353416@atlas.denx.de>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 18:22:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWGrS-0005uv-Jv
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 18:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVJ3RUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 12:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJ3RUs
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 12:20:48 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14017 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751061AbVJ3RUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 12:20:47 -0500
Received: from fwd32.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1EWGrD-0005ma-04; Sun, 30 Oct 2005 18:20:35 +0100
Received: from denx.de (SmgrNZZlZer3jBmjRFwDth8aMYVvI+NqoTk3krxg0ZpDtYSD3ulQYy@[84.150.71.90]) by fwd32.sul.t-online.de
	with esmtp id 1EWGqx-1WRCNs0; Sun, 30 Oct 2005 18:20:19 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 9ADBA42970; Sun, 30 Oct 2005 18:20:18 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 520BD353416;
	Sun, 30 Oct 2005 18:20:18 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sat, 29 Oct 2005 18:29:12 MST."
             <7vd5lnztav.fsf@assigned-by-dhcp.cox.net> 
X-ID: SmgrNZZlZer3jBmjRFwDth8aMYVvI+NqoTk3krxg0ZpDtYSD3ulQYy@t-dialin.net
X-TOI-MSGID: c5cf39f9-357c-49ae-b3c6-19b4ff4cd582
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10824>

In message <7vd5lnztav.fsf@assigned-by-dhcp.cox.net> you wrote:
> GIT 0.99.9 is found at usual places.

"make rpm" does not work for me:

...
make -C templates install
make[2]: Entering directory `/usr/local/BUILD/git-core-0.99.9/templates'
: no custom templates yet
find blt
blt
blt/branches
blt/hooks
blt/hooks/post-commit
blt/hooks/applypatch-msg
blt/hooks/commit-msg
blt/hooks/post-update
blt/hooks/update
blt/hooks/pre-applypatch
blt/hooks/pre-commit
blt/info
blt/info/exclude
blt/description
blt/remotes
install -d -m755 '/var/tmp/git-core-0.99.9-1-root-wd/usr/share/git-core/templates/'
(cd blt && tar cf - .) | \
(cd '/var/tmp/git-core-0.99.9-1-root-wd/usr/share/git-core/templates/' && tar xf -)
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Error exit delayed from previous errors
make[2]: *** [install] Error 2
make[2]: Leaving directory `/usr/local/BUILD/git-core-0.99.9/templates'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/usr/local/BUILD/git-core-0.99.9'
error: Bad exit status from /var/tmp/rpm-tmp.96513 (%install)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.96513 (%install)
make: *** [rpm] Error 1


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The computer programmer is a creator of universes for which he alone
is responsible. Universes of virtually unlimited  complexity  can  be
created  in  the  form  of  computer  programs." - Joseph Weizenbaum,
_Computer Power and Human Reason_
