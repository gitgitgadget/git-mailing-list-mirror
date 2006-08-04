From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] autoconf: Check for working mmap
Date: Fri, 04 Aug 2006 21:02:07 +0200
Organization: At home
Message-ID: <eb05i7$3d6$1@sea.gmane.org>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net> <11547069592652-git-send-email-jnareb@gmail.com> <7vodv0jpo1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 21:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94ve-0004BK-Lb
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWHDTBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWHDTBr
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:01:47 -0400
Received: from main.gmane.org ([80.91.229.2]:43161 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161257AbWHDTBr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 15:01:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G94vQ-00049P-7a
	for git@vger.kernel.org; Fri, 04 Aug 2006 21:01:36 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 21:01:36 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 21:01:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24821>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Use AC_FUNC_MMAP check to check if the `mmap' function exists and
>> works correctly.  (It only checks private fixed mapping of
>> already-mapped memory.)
> 
> This tests something we do not really care about (we do not
> mmap MAP_FIXED, and not over an already allocated space).

Well, I have noticed that there exist AC_FUNC_MMAP, used it, 
then read about its limitations.

Is there any platform that passes this test, but needs NO_MMAP?
If so, then disregard this patch.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
