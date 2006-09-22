From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Fri, 22 Sep 2006 19:55:27 +0200
Organization: At home
Message-ID: <ef182j$88e$1@sea.gmane.org>
References: <200609212356.31806.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 22 19:57:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQpGW-0003LM-JV
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 19:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWIVR4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWIVR4l
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 13:56:41 -0400
Received: from main.gmane.org ([80.91.229.2]:4759 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964841AbWIVR4k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 13:56:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQpG9-0003FW-OT
	for git@vger.kernel.org; Fri, 22 Sep 2006 19:56:21 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 19:56:21 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 19:56:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27532>

Jakub Narebski wrote:

> Below there is preliminary (hence RFC) committag support for gitweb,
> based on the idea introduced by Sham Chukoury to gitweb-xmms2.
> 
> The code has all the possible committags I could think of enabled;
> not all are tested, though. This includes existing commitsha tag
> support (full sha links to commit view, is sha is sha of commit),
> mantis bug and feature tags from gitweb-xmms2 (there is no release
> committag of gitweb-xmms2, but it should be fairly easy to add it),
> bugzilla committag for the Linux kernel, plain text URL committag
> (probably doesn't work that well, marking as links examples, and
> sometimes protocol specification), and Message-Id committag via
> GMane git mailing list (and not only) archive -- not tested.
> 
> Comments? Discussion?

For example: is the committags code overengineered, too complex?
Or is it not generic enough? Should all committags code be put into
format_log_line_html, or should we add another subroutine, 
format_committags (or similar)?

What other committags would you like to have?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
