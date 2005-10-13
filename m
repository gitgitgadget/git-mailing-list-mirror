From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: openbsd version?
Date: Thu, 13 Oct 2005 10:29:28 +0200
Message-ID: <20051013082928.GE8383MdfPADPa@greensroom.kotnet.org>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
 <7vvf0542fs.fsf@assigned-by-dhcp.cox.net> <864q7pdvcn.fsf@blue.stonehenge.com>
 <7vll113yjs.fsf@assigned-by-dhcp.cox.net>
 <20051010210007.GJ8383MdfPADPa@greensroom.kotnet.org>
 <7vzmph1225.fsf@assigned-by-dhcp.cox.net>
 <7vpsq9504x.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 10:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPyTA-0007q0-Ty
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 10:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbVJMI3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 04:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbVJMI3c
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 04:29:32 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:54781 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S1751511AbVJMI3c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 04:29:32 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IOA002I9I94YM@smtp18.wxs.nl> for git@vger.kernel.org; Thu,
 13 Oct 2005 10:29:28 +0200 (CEST)
Received: (qmail 9183 invoked by uid 500); Thu, 13 Oct 2005 08:29:28 +0000
In-reply-to: <7vpsq9504x.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
 "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10067>

On Thu, Oct 13, 2005 at 12:47:26AM -0700, Junio C Hamano wrote:
> Maybe there should be a safety measure built into git-update-ref
> that says single-level name (i.e. not starting with refs/) gets
> warning unless all uppercase or something silly like that to
> protect idiots like myself.  Hmmm.

How about checking whether the name also exists with a certain
prefix instead ?
Otherwise you'll also disallow updating ORIG_HEAD and stuff.

skimo
