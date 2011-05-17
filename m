From: =?utf-8?b?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #08; Mon, 16)
Date: Tue, 17 May 2011 19:39:10 +0000 (UTC)
Message-ID: <loom.20110517T213130-515@post.gmane.org>
References: <7vwrhphllf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMQCk-0004bQ-T2
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 21:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204Ab1EQTpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 15:45:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:34649 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab1EQTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 15:45:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QMQCY-0004Qp-JY
	for git@vger.kernel.org; Tue, 17 May 2011 21:45:06 +0200
Received: from 85-177-78-94.net.stream.pl ([94.78.177.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2011 21:45:06 +0200
Received: from michal.kiedrowicz by 85-177-78-94.net.stream.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2011 21:45:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.78.177.85 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110511 Gentoo Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173821>

(Sending from gmane "followup" interface, don't blame me if CC list is not OK.)

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> * mk/grep-pcre (2011-05-16) 12 commits
>   (merged to 'next' on 2011-05-16 at 0c6c25e)
>  + Makefile: Pass USE_LIBPCRE down in GIT-BUILD-OPTIONS
>  + git-grep: update tests now regexp type is "last one wins"
>   (merged to 'next' on 2011-05-15 at d110135)
>  + git-grep: do not die upon -F/-P when grep.extendedRegexp is set.
>  + git-grep: Bail out when -P is used with -F or -E
>  + grep: Add basic tests
>  + configure: Check for libpcre
>  + git-grep: Learn PCRE
>  + grep: Extract compile_regexp_failed() from compile_regexp()
>  + grep: Fix a typo in a comment
>   (merged to 'next' on 2011-05-08 at 5d3bede)
>  + grep: Put calls to fixmatch() and regmatch() into patmatch()
>  + contrib/completion: --line-number to git grep
>  + Documentation: Add --line-number to git-grep synopsis
> 
> Fixed up the build procedure that did not update GIT-BUILD-OPTIONS.
> Will merge to "master" by the middle of week #5.

Thanks for your help with last few patches, Junio. Unfortunately, I didn't have
to time to work on testcases you wrote in comments to my last posting, but I'll
try to prepare some during this week. 
