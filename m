From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Mon, 2 Aug 2010 11:34:20 -0700
Message-ID: <20100802183420.GN25268@spearce.org>
References: <i372v0$3np$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:34:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfzqP-0006Yk-Ut
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0HBSed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:34:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63701 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0HBSec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:34:32 -0400
Received: by pxi14 with SMTP id 14so1437203pxi.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 11:34:32 -0700 (PDT)
Received: by 10.142.111.4 with SMTP id j4mr5417011wfc.293.1280774072033;
        Mon, 02 Aug 2010 11:34:32 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id y16sm8023638wff.14.2010.08.02.11.34.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 11:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i372v0$3np$1@dough.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152434>

"Joel C. Salomon" <joelcsalomon@gmail.com> wrote:
> I'd figured to play with Git in an unusual way: to create a repository
> for the U.S. Constitution where amendments are presented as patches.
> E.g., instead of the First Amendment being placed at the end (as is
> usual) I'm putting it in Article 1, Section 9 (Limitations of Congress).
>  Proposed amendments get branches, which get merged in later.
> 
> But I'm trying to get the dates right, and I'm missing something.  For
> example, I made the initial commit with the line
> 
> 	$ git commit --author="The Philadelphia Convention <>" \
> 	 --date="Mon, 17 Sep 1787 12:00:00 EST"
> 
> but that's not actually setting the commit date to 1787.
> 
> Am I doing something wrong, or is Git (quite reasonably) unable to
> accept commit dates that far in the past?

Its probably running into problems with time_t on your system being a
32 bit value, and thus having trouble going before some time in 1901.

-- 
Shawn.
