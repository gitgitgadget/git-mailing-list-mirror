From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 11:20:05 +0000
Message-ID: <2736C1E3-6294-49B0-96A2-8BCCFA27EDCD@steelskies.com>
References: <47440912.8010800@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>
To: Toby White <tow21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 12:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IundA-0004LF-ED
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbXKULUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 06:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbXKULUM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:20:12 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:56236 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbXKULUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 06:20:10 -0500
Received: from [89.105.122.147] (port=55245 helo=gir.office.bestbefore.tv)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1Iuncn-0006Jo-A4; Wed, 21 Nov 2007 06:20:10 -0500
In-Reply-To: <47440912.8010800@cam.ac.uk>
X-Mailer: Apple Mail (2.912)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65629>

On 21 Nov 2007, at 10:31, Toby White wrote:

> Mac OS X bundles a rather nice graphical diff viewer (Filemerge.app)
> with its developer tools.
>
> While git-merge knows how to use this as a merge tool, I couldn't
> find any way to easily use Filemerge as a viewer for the output
> of git-diff.
>
> (http://thread.gmane.org/gmane.comp.version-control.git/58702
> discusses the problem, and recommends piping git-diff into kompare.
> Filemerge unfortunately won't accept diff output on stdin)
>
> So I wrote a quick script (below) which does what I need. Of all
> the available git-diff flags, it only understands "--cached", and
> up to two commit objects, and no paths, but that's enough for me.
> Within those constraints, it has the same semantics as git-diff.

> ...

Handy, thanks.
Just as a note to anyone who runs into the same problems as me - I  
couldn't persuade this script to work at first.  On my Leopard  
install, mktemp needs a template argument to run.  After replacing  
both `mktemp -d`s in this script with `mktemp -d /tmp/diff.XXXXX`, it  
works nicely.

Jon
