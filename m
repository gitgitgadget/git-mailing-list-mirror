From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 14:23:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz>  <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>  <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
  <e06hts$1ne$1@sea.gmane.org>  <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
 <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 00:24:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNden-0002hV-1p
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 00:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCZWYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWCZWYE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 17:24:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbWCZWYB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 17:24:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QMNwDZ006420
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 14:23:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QMNvUc020255;
	Sun, 26 Mar 2006 14:23:58 -0800
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18062>



On Sun, 26 Mar 2006, Marco Costalba wrote:
> 
> FIRST WAY
> 
> After annotating a file history (double click on a file name in
> bottom-right window or directly from tree view), you see the whole
> file annotated. If you have the diff window open you see also the
> corresponding patch (scrolled to selected file name).

The problem is that this step is already _way_ too expensive.

I don't want to work with any tool that makes "Step 1" take a minute or 
two for a project that has a few years of history. Try it on the linux 
historic project with some file that gets lots of modifications.

In other words, starting off with "annotate" is MUCH too expensive. You 
should start off basically with "git-whatchanged".

		Linus
