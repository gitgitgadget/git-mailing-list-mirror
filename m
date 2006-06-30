From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFT] upload-pack.c: <sys/poll.h> includes <ctype.h> on OpenBSD 3.8
Date: Fri, 30 Jun 2006 21:00:09 +0200
Organization: At home
Message-ID: <e83sbc$4s0$1@sea.gmane.org>
References: <86wtayy42o.fsf@blue.stonehenge.com> <7vy7veindn.fsf@assigned-by-dhcp.cox.net> <86sllmy3ia.fsf@blue.stonehenge.com> <7vk66yilxd.fsf@assigned-by-dhcp.cox.net> <7vr716h4xm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 21:02:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwOF2-0001LW-Ij
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 21:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWF3TBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 15:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWF3TBT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 15:01:19 -0400
Received: from main.gmane.org ([80.91.229.2]:38318 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964899AbWF3TBR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 15:01:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwODy-000189-1Q
	for git@vger.kernel.org; Fri, 30 Jun 2006 21:00:18 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 21:00:18 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 21:00:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23014>

Junio C Hamano wrote:

> Try to work it around by including the system headers first.

Shouldn't it be always the case?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
