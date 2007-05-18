From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port: some questions
Date: Fri, 18 May 2007 09:58:23 +0200
Organization: eudaptics software gmbh
Message-ID: <464D5C9F.DBA27467@eudaptics.com>
References: <1179341520.31213.38.camel@bruno.nolaviz.org> <7vejlgegb9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alon Ziv <alonz@nolaviz.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 09:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoxLe-0004hO-Oy
	for gcvg-git@gmane.org; Fri, 18 May 2007 09:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbXERH55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 03:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbXERH55
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 03:57:57 -0400
Received: from main.gmane.org ([80.91.229.2]:41431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755478AbXERH54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 03:57:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HoxLX-0004hS-FH
	for git@vger.kernel.org; Fri, 18 May 2007 09:57:55 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 09:57:55 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 09:57:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47577>

Junio C Hamano wrote:
> 
> Alon Ziv <alonz@nolaviz.org> writes:
> 
> > I am referring, for example, to the changes from commit dc380d6, which
> > were reverted in Git mainline (actually in "next", they never reached
> > Git's "master").  Or to the changes from 4493e36, which had the same
> > fate.
> 
> MinGW repository bases its work on my 'next', so it will not be
> pulled wholesale to my 'master'.  The plan is to trickle down
> the platform independent bits of fixes and refactoring to the
> mainline, as well as #ifdef __MINGW32__ and $(findstring MINGW)
> parts, but that will most likely happen as a series of bite
> sized patch series to the list with public reviews.
> 
> I do not know if you mistyped dc380d6 (I do not find it there),
> but reverting 4493e36 (merge of jc/3way) was intentional.  The
> work in that commit that deviates from the mainline is the
> jc/3way topic, which turned out to be incomplete and not very
> usable.  MinGW tree might not have synchronized with the latest
> from the mainline in which case it might not have merged the
> revert from me yet, and that may be why you are seeing the
> differences.

Sometime around 1.5.0 I decided to merge only 'master' into MinGW and I
didn't notice that there were some more or less important reversals in
'next'. (Note to myself: Pull 079f7cb27b into mingw before next update.)

-- Hannes
