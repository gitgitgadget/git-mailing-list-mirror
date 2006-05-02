From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 10:44:57 +0200
Organization: At home
Message-ID: <e3764f$ea7$1@sea.gmane.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 02 10:44:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaqUs-0001M2-6k
	for gcvg-git@gmane.org; Tue, 02 May 2006 10:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWEBIo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 04:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWEBIoZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 04:44:25 -0400
Received: from main.gmane.org ([80.91.229.2]:44488 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932136AbWEBIoZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 04:44:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaqUQ-0001IQ-Mz
	for git@vger.kernel.org; Tue, 02 May 2006 10:44:14 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 10:44:14 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 10:44:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19409>

Andreas Ericsson wrote:

> Jakub Narebski wrote:

>> Yes, I understand, but I just don't like using 'grip'. And it would be
>> nice to have some convention for further not-ready-yet built-in
>> replacements for script versions of commands, for example adding letter
>> 'b' as 'built-in' at the beginning of command name: 'bgrep', 'bdiff'. Or
>> use postfix 'n' or '-ng' to denote transitionary not-ready-yet new
>> version of command: 'grepn', 'diffn' or 'grep-ng', 'diff-ng'.
>> 
> 
> Forcing the user to remember what's implemented as built-ins is not a
> good idea. It was for that exact reason the "git-<command>-script" were
> all renamed "git-<command>" once upon a time.
> 
> "git grip" work just fine for me, since it's only intended for testing
> and performance improvements so far. I also think it's clearer for
> end-users looking for a grep command if they're not faced with
> fgrep/egrep/ggrep/bgrep alongside plain "grep".

Well, scratch 'bgrep' idea, even if I had no intend for 'bgrep' to be
persistent name; it was meant as transitionary name. Well, that doesn't
matter much because someone interested in testing new, not-ready-yet
versions of commands (I like 'grepn' idea) usually would follow git
development, and would know (or not) about new version of 'git grep' being
'git grip' (and not 'git grepn').


What about forcing using external grep, and the fact that grep is linked
with libpcre?

-- 
Jakub Narebski
Warsaw, Poland
