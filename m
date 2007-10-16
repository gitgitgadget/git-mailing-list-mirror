From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] gitweb: Speed up get_projects_list for large source trees
Date: Tue, 16 Oct 2007 18:55:01 +0200
Message-ID: <4714ECE5.9020502@op5.se>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <vpqlka3sdka.fsf@bauges.imag.fr> <3A2DCEC6-953A-41B0-AB9E-7374EEB625E8@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihphd-0006Qw-EB
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761176AbXJPQzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763184AbXJPQzH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:55:07 -0400
Received: from mail.op5.se ([193.201.96.20]:45312 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763024AbXJPQzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:55:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8BFE517306FB;
	Tue, 16 Oct 2007 18:55:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id niJgo6ZfDi-l; Tue, 16 Oct 2007 18:55:21 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 5979417306C4;
	Tue, 16 Oct 2007 18:55:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <3A2DCEC6-953A-41B0-AB9E-7374EEB625E8@vicaya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61211>

Luke Lu wrote:
> Hi, I've been using git for a month now and loving it.

Hello Luke, and welcome to the community :)

> This is my first ever patch for git using git.

It shows. The patch is whitespace damaged, and the commit message leaves
a little something to desire. I suggest you read through
Documentation/SubmittingPatches and then re-send your patch. Try sending
to yourself and looking at the result with a monospace font. It's what I
always do to make sure patches look okay before sending them to the list.

Not trying to be rude or anything. Oldtime list-members sometimes get to
hear the exact same thing.

Also, Junio, the maintainer, is currently away, so don't worry if your
patches are left in limbo for some time. Someone will pick it up and
carry it forward for Junio to pull, or he'll hack up some script to
get all patces from his mailbox and review them one by one. He's a very
thorough fellow, usually.

> I spent sometime to find out why the 
> project listing is taking 200s, everytime! I guess that gitweb is mostly 
> used to serve bare repositories, which would never encounter such 
> problems. It takes .2s, after the patch on my laptop. That's 1000x 
> improvement for me (on Mac OS X 1.4.10.)
> 

Sweet job :)

I'll have to test this, as we've got a few repos at work with a checked out
working tree connected to the repos. I haven't run into your issues though,
but perhaps that's because we run it under Linux.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
