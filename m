From: Andrew Morton <akpm@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 01:18:32 -0800
Message-ID: <20060227011832.78359f0a.akpm@osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com>
	<1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: efault@gmx.de, davej@redhat.com, torvalds@osdl.org, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 10:19:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDeXn-0004Fz-SE
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 10:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWB0JTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 04:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWB0JTt
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 04:19:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751710AbWB0JTs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 04:19:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1R9JSDZ009172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 01:19:28 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1R9JRun016029;
	Mon, 27 Feb 2006 01:19:27 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16833>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
> 
> there is a good reason not to enable the no-whitespace-at-eol checking in 
> pre-commit by default (at least for *all* files) for git development:
> 
> 	Python.

That's not a good reason.  People will discover that git has started
shouting at them and they'll work out how to make it stop.

The probem is getting C users to turn the check on, not in getting python
users to turn it off.
