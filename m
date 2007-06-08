From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 08 Jun 2007 09:19:49 +0200
Organization: eudaptics software gmbh
Message-ID: <46690315.8244CAF7@eudaptics.com>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site>
	 <7vzm3bmfeq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706080603520.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 09:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwYkf-0007JI-9X
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 09:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966588AbXFHHTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 03:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966440AbXFHHS7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 03:18:59 -0400
Received: from main.gmane.org ([80.91.229.2]:37299 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965869AbXFHHS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 03:18:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HwYk5-00057J-FP
	for git@vger.kernel.org; Fri, 08 Jun 2007 09:18:41 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 09:18:41 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 09:18:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49445>

Johannes Schindelin wrote:
> It's just a guess, but now that we come really, really close to having a
> concise implementation of git-subproject which will probably soon
> propagate to master, and then maint, I gather that more and more people
> come and want to split their projects (which they maintained as one big
> project) into several subprojects (which they should have been from the
> start, but the tool did not easily allow for that).

I think that --subdirectry-filter needs to become a bit smarter to be
really useful for splitting a big project into sub-projects plus a
super-project. The reason is that once you have extracted the
sub-project(s), you have a hard time to find out which commits to
gitlink into the super-project. I don't have a plan how to make it
smarter, though.

-- Hannes
