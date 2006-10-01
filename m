From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Decode long title for link tooltips
Date: Sun, 01 Oct 2006 18:45:46 +0200
Organization: At home
Message-ID: <eforb7$fgd$1@sea.gmane.org>
References: <873baet4ka.wl@mail2.atmark-techno.com> <871wpyt3ch.wl@mail2.atmark-techno.com> <87zmcmroqf.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 01 18:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU4W5-0002k5-0F
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 18:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWJAQuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 12:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJAQuI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 12:50:08 -0400
Received: from main.gmane.org ([80.91.229.2]:50102 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751271AbWJAQuG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 12:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GU4Vu-0002hS-GC
	for git@vger.kernel.org; Sun, 01 Oct 2006 18:50:02 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 18:50:02 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 18:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28182>

Yasushi SHOJI wrote:

> This is a simple one liner to decode long title string in perl's
> internal form to utf-8 for link tooltips.
> 
> This is not crucial if the commit message is all in ASCII, however, if
> you decide to use other encoding, such as UTF-8, tooltips ain't
> readable any more.

Perhaps it would be better to abstract it away into esc_attr (as escape
attribute) subroutine, if such situation i.e. output of generated string
into some attribute of some element happens in some other place.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
