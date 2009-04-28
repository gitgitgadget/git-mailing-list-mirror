From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Cross-Platform Version Control (was: Eric Sink's blog - notes on git, dscms and a "whole product" approach)
Date: Tue, 28 Apr 2009 23:00:56 +0200
Message-ID: <200904282300.57087.robin.rosenberg.lists@dewire.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3r5zdnhqu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:03:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyuRf-0008Hi-1U
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbZD1VBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757352AbZD1VBW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:01:22 -0400
Received: from mail.dewire.com ([83.140.172.130]:14418 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757412AbZD1VBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:01:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DACB110233F9;
	Tue, 28 Apr 2009 23:01:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RadJSVP5lCBF; Tue, 28 Apr 2009 23:01:00 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id E75F31023056;
	Tue, 28 Apr 2009 23:00:59 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <m3r5zdnhqu.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tisdag 28 april 2009 13:24:31 skrev Jakub Narebski <jnareb@gmail.com>:
> Line endings (issue 8.) is in theory and in practice (at least for
> Git) a non-issue.  
> 
> In theory you should use project's convention for end of line
> character in text files, and use smart editor that can deal (or can be
> configured to deal) with this issue correctly.
Windows people will disagree.

> In practice this is a matter of correctly setting up core.autocrlf
> (and in more complicated cases, where more complicated means for git
> very very rare, configuring which files are text and which are not).

Which proves it is an issue or we wouldn't need to tune settings
to make it work right.  A non-issue is something that "just works"
without turning knobs. I had had to think more than once on
what the issue was and the right way to solve these issues. It
can be considered wierd, because Eclipse on Linux generated files
with CRLF which I happily committed and Git on Windows happily
converted to LF and determined that the HEAD and index was out
of sync, but refuesed to commit the CRLF>LF change becuase there
was no "diff"..  You know the fix, but don't tell me it's not an issue.

-- robin
