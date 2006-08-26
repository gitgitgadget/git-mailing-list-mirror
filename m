From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16/19] gitweb: Use git-diff-tree or git-diff patch output for blobdiff
Date: Sat, 26 Aug 2006 12:17:10 +0200
Organization: At home
Message-ID: <ecp737$qqg$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252113.34731.jnareb@gmail.com> <ecp3uq$k1f$1@sea.gmane.org> <7vpsen3itw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 26 12:17:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGvEG-0000k0-Mk
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 12:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWHZKR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZKR0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 06:17:26 -0400
Received: from main.gmane.org ([80.91.229.2]:46720 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751357AbWHZKRZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 06:17:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGvE4-0000iE-PQ
	for git@vger.kernel.org; Sat, 26 Aug 2006 12:17:17 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 12:17:16 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 12:17:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26044>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Jakub Narebski wrote:
>>
>>> ATTENTION: The order of arguments (operands) to git-diff is reversed
>>> (sic!) to have correct diff in the legacy (no hash_parent_base) case.
>>> $hash_parent, $hash ordering is commented out, as it gives reversed
>>> patch (at least for git version 1.4.1.1) as compared to output in new
>>> scheme and output of older gitweb version.
>>
>> By the way, wa it corrected later? git version 1.4.1.1
> 
> I think you were involved in the thread that resulted in the 
> fix...
> 
> 53dd8a9 Show both blob names from "git diff blob1 blob2"
> f82cd3c Fix "git diff blob1 blob2" showing the diff in reverse.

Gaah. So I'd have to fix the gitweb, i.e. remove workaround
(and update git to 1.4.2). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
