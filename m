From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 11:33:06 +0100
Message-ID: <07FDB6ED-EBE0-4F66-9167-6A0F8AD58E2B@zib.de>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801200142170.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGXWe-0007xj-QP
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 11:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYATKfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYATKfK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 05:35:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:62072 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbYATKfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 05:35:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0KAW38F017762;
	Sun, 20 Jan 2008 11:34:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91f4c.pool.einsundeins.de [77.185.31.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0KAW2Aa010360
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 Jan 2008 11:32:03 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801200142170.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71171>


On Jan 20, 2008, at 2:48 AM, Johannes Schindelin wrote:

>> I bet you'll see a much bigger performance improvement from this on
>> Windows in particular.
>
> I bet so, too.  Traditionally, filesystem calls are painfully slow on
> Windows.
>
> But I cannot test before Monday, so I would not be mad if somebody  
> else
> could perform some tests on Windows.

Has someone collected the whole series on a topic branch?  I did
not follow the discussion closely and apparently more than Linus'
patch is needed.  I couldn't immediately figure out which of the
patches from the thread should be applied in what order.

	Steffen
