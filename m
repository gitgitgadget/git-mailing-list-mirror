From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-svn problem with v1.6.5
Date: Tue, 10 Nov 2009 17:28:39 -0500
Message-ID: <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com>
References: <4AF9E7FE.3060701@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Nov 10 23:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7zEx-0005zL-Px
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 23:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbZKJW26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758545AbZKJW25
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 17:28:57 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49396 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758494AbZKJW2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 17:28:54 -0500
Received: by gxk26 with SMTP id 26so495717gxk.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 14:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=0VmIOAT4zF5eo/VK58fmLqN80+Ski8dsYnr2esHKlEs=;
        b=pVoDxqAd6avjTBxUAbVJXjy3LbXG2Rzql2rAW3ONtrhl4GWcT0uO9kRqnEJL6CTxHd
         xnXjaFcip+PaQZUtINdiJ2W5ziZYPVeO2G5jP+H6KidO4kzTDon+iHQgJe6wI87nLoc7
         rnxROSGS/jY04pvL12KjKBrh5S51nD7qOiUEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oIh6d+y779pBhy1tc9sAzbHNKLGdbUtXLWBTqTq05DPmpbXEGEmquxOyYBr3d86Y05
         uSpIl2+oKAa9245GQBcVQ9EMMuq4U2uysuCIhE3CRsYsMxzi9Bg2WJqUU4CB0xjaURX7
         89MTlujLuC9Z7tdMNEi28JA9t1Xkk+gLFRt98=
Received: by 10.150.179.12 with SMTP id b12mr1288088ybf.156.1257892139206; 
	Tue, 10 Nov 2009 14:28:59 -0800 (PST)
In-Reply-To: <4AF9E7FE.3060701@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132602>

On Tue, Nov 10, 2009 at 5:23 PM, Pascal Obry <pascal@obry.net> wrote:
> $ git svn rebase
> fatal: Invalid revision range
> d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk
> rev-list --pretty=raw --no-color --reverse
> d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk --: command
> returned error: 128

Is d2cf08bb67e4b7da33a250127aab784f1f2f58d3 a valid revision?  (git
log d2cf08bb67e4b7da33a250127aab784f1f2f58d3).  Is
refs/remotes/svn/trunk valid?  (git log refs/remotes/svn/trunk).  It
seems like a strange problem.

> Using v1.6.4 instead I have no problem. Any idea to track this problem down?

You could try using git bisect to figure out which exact commit to
git.git created the problem.

Avery
