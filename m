From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for
 git-svn-id
Date: Sun, 26 Aug 2012 00:36:58 +0000
Message-ID: <20120826003658.GB32346@dcvr.yhbt.net>
References: <1343856197-6393-1-git-send-email-robert@debian.org>
 <20120801214318.GA10384@dcvr.yhbt.net>
 <5019AD3A.8030609@debian.org>
 <20120801230118.GA15479@dcvr.yhbt.net>
 <50315ED1.6080803@debian.org>
 <20120821214538.GA4879@dcvr.yhbt.net>
 <7vsjbfc1q7.fsf@alter.siamese.dyndns.org>
 <50380AEA.6020000@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 02:37:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5Qqh-0007AH-55
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 02:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab2HZAhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 20:37:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49386 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757339Ab2HZAg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 20:36:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97D21F520;
	Sun, 26 Aug 2012 00:36:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50380AEA.6020000@debian.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204291>

Robert Luberda <robert@debian.org> wrote:
> Junio C Hamano wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> >>
> >> I think having "svn" in "svn.trimsvnlog" twice is redundant and not ideal.
> >> Perhaps just --trim-log and svn.trimlog?
> > 
> > Do we ever want to trim "our" log when relaying the Git commits back
> > to subversion?  Having "svn" in "trimsvnlog" makes it clear that the
> > logs from subversion side is getting trimmed.
> 
> `git commit' already trims the messages (except for removing the leading
> whitespaces from the first non-whitespace-only line) and git svn doesn't
> change that.
> 
> The new option affects the way the messages are imported from svn to
> git, with one exception when the --add-author-from option of dcommit is
> used (in which case it may skip adding an extra new line character
> before the `From: ' line). For that reason --trim-svn-log might be a
> better name.

OK.  I now agree --trim-svn-log is a better name :>
