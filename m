From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sat, 19 Jan 2008 17:34:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191729490.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGP5A-0002uC-MX
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYATBeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 20:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbYATBeP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:34:15 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53396 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304AbYATBeO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 20:34:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1YBdF013860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 17:34:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K1YACh029917;
	Sat, 19 Jan 2008 17:34:10 -0800
In-Reply-To: <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71148>



On Sat, 19 Jan 2008, Linus Torvalds wrote:
> 
> It passes the test-suite for me, but this is another of one of those 
> really core functions, and certainly pretty subtle, so..

By this I don't mean that I don't think this patch is good, but it does 
mean that while I think it's a great patch (along with all the other index 
cleanups and the lstat-avoidance this one depends on), it's probably not 
appropriate for master without some more people looking at it, and 
probably cooking in a next for a while.

		Linus
