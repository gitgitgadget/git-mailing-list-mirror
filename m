From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with
	Git.pm
Date: Thu, 29 Jun 2006 20:03:00 -0400
Message-ID: <1151625780.10358.13.camel@dv>
References: <20060628183557.GA5713@fiberbit.xs4all.nl>
	 <7vr719159v.fsf@assigned-by-dhcp.cox.net>
	 <7virml14za.fsf@assigned-by-dhcp.cox.net>
	 <20060628192145.GD5713@fiberbit.xs4all.nl> <1151527945.1619.17.camel@dv>
	 <e81jr5$l1c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 02:03:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6Tj-0006vk-6v
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWF3ADH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWF3ADG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:03:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61879 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751328AbWF3ADE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:03:04 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fw6TP-0004nz-NS
	for git@vger.kernel.org; Thu, 29 Jun 2006 20:03:03 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fw6TN-0002iz-C1; Thu, 29 Jun 2006 20:03:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e81jr5$l1c$1@sea.gmane.org>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22929>

Hi, Jakub!

I don't have the newsgroup access, so I'm copying to the mailing list
instead.

On Fri, 2006-06-30 at 00:22 +0200, Jakub Narebski wrote:

> If I remember correctly everybody agreed that autoconf is least evil of the
> whole autotools package.

Sort of.  Some people were less dismissive than others.

>  pasky suggested to write ./configure script by
> hand on #git...

That's probably not a good idea.  Autoconf can do this very well if used
correctly.  And I'm ready to help when it comes to correctness.

> I'm trying to do inobtrusive _optional_ autoconf support in the patch series
> beginning with
>   Message-ID: <200606290301.51657.jnareb@gmail.com>
>   http://permalink.gmane.org/gmane.comp.version-control.git/22832

The problem with optional support is that you suddenly have two
alternative mechanisms to adjust the build to the system, and both
should be kept in a  working condition.  But it's a good first step.

> Please wait for the patch moving ./autoconf output away from config.mak
> (as some people here requested), and do contribute! My autoconf/m4
> experience is nonexistent (I'm learning it as I go). See comments in the
> third [PATCH/RFC] in series.
> 
> BTW. patches are against master.

The link doesn't show the "@" characters correctly.  Maybe somebody
could establish a git repository?  Ideally, the autoconf changes should
go to one of the Git branches.

-- 
Regards,
Pavel Roskin
