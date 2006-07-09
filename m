From: fork0@t-online.de (Alex Riesen)
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 14:17:07 +0200
Message-ID: <20060709121706.GD5919@steel.home>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net> <20060709094630.GB5919@steel.home> <f36b08ee0607090309l3cc05b19t44781bbe26013a0b@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 14:17:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzYE5-00027f-L3
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 14:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWGIMRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 08:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWGIMRU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 08:17:20 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:14986 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030469AbWGIMRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 08:17:18 -0400
Received: from fwd32.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1FzYDn-0006QP-06; Sun, 09 Jul 2006 14:17:11 +0200
Received: from tigra.home (TFx9CmZEQe3Y4Pf1Cqh7jClTtr-wzhmw-BPaMx3dJDr3wnmsriOOE0@[84.160.119.250]) by fwd32.sul.t-online.de
	with esmtp id 1FzYDl-0ydYf20; Sun, 9 Jul 2006 14:17:09 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BF537277AF;
	Sun,  9 Jul 2006 14:17:08 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FzYDj-00020b-Vu; Sun, 09 Jul 2006 14:17:08 +0200
To: Yakov Lerner <iler.ml@gmail.com>
Content-Disposition: inline
In-Reply-To: <f36b08ee0607090309l3cc05b19t44781bbe26013a0b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-ID: TFx9CmZEQe3Y4Pf1Cqh7jClTtr-wzhmw-BPaMx3dJDr3wnmsriOOE0
X-TOI-MSGID: cfc9f616-d350-4f28-af74-2f44325dda4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23546>

Yakov Lerner, Sun, Jul 09, 2006 12:09:30 +0200:
> >Now imagine a non-posix system where an upgrade was made. Amongst
> >other things perl was moved, i.e. from /opt/perl-5.8.8 to
> >/usr/local/{bin,lib}. Suddenly git breaks.
> 
> Building new perl for sources never removed,
> by itself, older perls on the system. Did it ever for you ?

No. But a strange package management program will remove the old perl.
