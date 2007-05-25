From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 12:57:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705251256250.26602@woody.linux-foundation.org>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
 <11801165433267-git-send-email-hjemli@gmail.com>
 <Pine.LNX.4.64.0705251924280.4648@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 21:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrfvM-0002Wu-AR
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbXEYT6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbXEYT6E
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:58:04 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:56365 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbXEYT6D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 15:58:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4PJvrDQ010136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2007 12:57:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4PJvnUT026144;
	Fri, 25 May 2007 12:57:49 -0700
In-Reply-To: <Pine.LNX.4.64.0705251924280.4648@racer.site>
X-Spam-Status: No, hits=-4.418 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48404>



On Fri, 25 May 2007, Johannes Schindelin wrote:
>
> I did not realize this earlier, but we seem to have more and more programs 
> where actions are specified without "--", i.e. "git-svn fetch", or 
> "git-bundle create".

Hey, don't forget "git bisect", the granddaddy of them all.

> I actually like that, to separate actions from options. Hmm?

I agree. If something effectively always takes a separate command, it's 
not an option, it's a subcommand.

		Linus
