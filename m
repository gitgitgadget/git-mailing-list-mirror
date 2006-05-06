From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Sat, 06 May 2006 15:37:47 +0200
Organization: At home
Message-ID: <e3i8r1$ve2$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz> <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org> <20060505185445.GD27689@pasky.or.cz> <e3g9m6$8i0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat May 06 15:38:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcMyy-0002Bz-KA
	for gcvg-git@gmane.org; Sat, 06 May 2006 15:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWEFNhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 09:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEFNhu
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 09:37:50 -0400
Received: from main.gmane.org ([80.91.229.2]:10198 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750819AbWEFNht (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 09:37:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcMyi-0002AH-4a
	for git@vger.kernel.org; Sat, 06 May 2006 15:37:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 15:37:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 15:37:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19658>

Jakub Narebski wrote:

> Petr Baudis wrote:

>> If you use persistent file ids, you never miss it _AND_ you DO NOT WALK
>> THE COMMIT CHAIN! You still just match file ids in the two trees.
> 
> Let not jump to the one of the possible solution. The detecting and noting
> renames and content moving (with user interaction) at commit is nice...
> unless does something which cannot allow interactiveness (like applying
> patchbomb), but even then detecting and saving info at commit would be
> good idea.
> 
> What we need is to for two given linked revisions (with a path between
> them) to easily extract information about renames (content moving).
> Perhaps using additional structure... best if we could do this without
> walking the chain. The rest is details... ;-P

Or rather structure, which for given file F in given revision A, for given
other revision B would tell ALL the files in the revision B which are
source of contents (via history/commit tree) of the file F.

-- 
Jakub Narebski
Warsaw, Poland
