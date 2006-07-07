From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri, 07 Jul 2006 21:03:02 +0200
Organization: At home
Message-ID: <e8mb4l$t1u$1@sea.gmane.org>
References: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net> <1152298675925-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jul 07 21:03:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvbZ-00051j-1A
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 21:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWGGTDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGGTDF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 15:03:05 -0400
Received: from main.gmane.org ([80.91.229.2]:37543 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750785AbWGGTDE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 15:03:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FyvbP-0004zj-Jd
	for git@vger.kernel.org; Fri, 07 Jul 2006 21:02:59 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 21:02:59 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 21:02:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23456>

It looks like it is _almost_ correct. It should be
  Date: Fri, 07 Jul 2006 20:57:55 +0200
instead of
  Date: Fri,  7 Jul 2006 20:57:55 +0200

It is "day = ([FWS] 1*2DIGIT) / obs-day" in RFC2822.

-- 
Jakub Narebski
