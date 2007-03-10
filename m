From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-log --full-history renamed-file
Date: Sat, 10 Mar 2007 02:40:07 +0100
Organization: At home
Message-ID: <est24q$p4n$1@sea.gmane.org>
References: <87lki6umts.fsf@rho.meyering.net> <Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org> <7v8xe53ok5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 03:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqzL-0004UX-Qc
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767724AbXCJCHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767722AbXCJCHJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:07:09 -0500
Received: from main.gmane.org ([80.91.229.2]:57419 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767724AbXCJCHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 21:07:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HPqlV-0000O9-G8
	for git@vger.kernel.org; Sat, 10 Mar 2007 02:52:57 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 02:52:57 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 02:52:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
X-UiO-SPF-Received: Received-SPF: pass (mail-mx3.uio.no: domain of sea.gmane.org designates 80.91.229.5 as permitted sender) client-ip=80.91.229.5; envelope-from=news@sea.gmane.org; helo=sea.gmane.org;
X-UiO-Spam-info: not spam, SpamAssassin (score=0.0, required=12.0, autolearn=disabled, none)
X-UiO-Scanned: 660EE0A957FAD864D1A3D0A83D0E2D0447274983
X-UiO-SPAM-Test: remote_host: 80.91.229.5 spam_score: 0 maxlevel 200 minaction 2 bait 0 mail/h: 3 total 30 max/h 8 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41838>

Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> There were patches floating around for an option called "--follow" to "git 
>> log", that would actually follow the renames. 
>>
>> I don't remember what happened to them - I suspect the implementation 
>> wasn't up to snuff. But the *concept* is definitely right.
> 
> Yes, the concept is good.  It was from Fredrik of
> merge-recursive fame.
> 
> The patch was not _bad_, but it looked a bit too intrusive back
> then and scared me away.

If I remember correctly it had somewhat unfortunate timing, as it
was around changes in the same area.

By the way, while it is fairly easy to follow one file, it is hard
to follow directory or glob... and there is a trouble that one file
might come from two files (as concatenation for example; but I don't
think git can detect it with default values of rename detection
heuristics). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
