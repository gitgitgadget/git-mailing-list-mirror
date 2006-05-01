From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Mon, 01 May 2006 09:12:25 +0200
Organization: At home
Message-ID: <e34cb4$is1$1@sea.gmane.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 01 09:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaSbR-0002Yw-Jk
	for gcvg-git@gmane.org; Mon, 01 May 2006 09:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWEAHNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 03:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWEAHNA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 03:13:00 -0400
Received: from main.gmane.org ([80.91.229.2]:27528 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751311AbWEAHLr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 03:11:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaSZG-0002Bs-CD
	for git@vger.kernel.org; Mon, 01 May 2006 09:11:39 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 09:11:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 09:11:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19375>

Junio C Hamano wrote:

Jakub Narebski <jnareb@gmail.com> writes:

> Wouldn't "git ggrep" (from git-aware grep) or "git bgrep" (from built-in
> grep), similar to the egrep and fgrep from the grep package?

Yes, I understand, but I just don't like using 'grip'. And it would be nice
to have some convention for further not-ready-yet built-in replacements for
script versions of commands, for example adding letter 'b' as 'built-in' at
the beginning of command name: 'bgrep', 'bdiff'. Or use postfix 'n' or
'-ng' to denote transitionary not-ready-yet new version of command:
'grepn', 'diffn' or 'grep-ng', 'diff-ng'.


By the way, [my] grep is linked against libpcre - would it mean that git
would also need to use pcre library, or at least have an option to use it?

I also wonder if anyone would be interested to _force_ using external grep
(probably enhanced)... just a thought.

-- 
Jakub Narebski
Warsaw, Poland
