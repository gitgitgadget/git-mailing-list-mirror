From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Allow setting default diff options via
 diff.defaultOptions
Date: Thu, 2 Apr 2009 17:04:18 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 02:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpWuz-00013s-Jc
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 02:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbZDCAEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 20:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbZDCAEa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 20:04:30 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:55976 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbZDCAE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 20:04:29 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n3304Jxd029339;
	Thu, 2 Apr 2009 17:04:19 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n3304Ik3029335;
	Thu, 2 Apr 2009 17:04:18 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115506>

Johannes,

On Sat, 21 Mar 2009, Johannes Schindelin wrote:

> The idea is from Keith Cascio.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 	I do not particularly like what this patch does, but I like
> 	the non-intrusiveness and conciseness of it.

Your patch does not provide a command line opt_out flag.  Let me describe a 
workflow situation and ask you how to handle it if the user were running your 
patch.  Let diff.defaultOptions = "-b".  The user is getting closer to 
submitting his patch and he wants to see patch output identical to what `git format-patch`
will produce.  What command should he use?

      `git format-patch --stdout master` ?

                                  -- Keith
