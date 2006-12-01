X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 01 Dec 2006 01:06:28 +0100
Organization: At home
Message-ID: <eknrig$n27$1@sea.gmane.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se> <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org> <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home> <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home> <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home> <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.
 64.0611301520370.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 1 Dec 2006 00:04:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32834>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpvtX-0001K5-Tn for gcvg-git@gmane.org; Fri, 01 Dec
 2006 01:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967996AbWLAAEo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967998AbWLAAEn
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 19:04:43 -0500
Received: from main.gmane.org ([80.91.229.2]:46251 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967996AbWLAAEn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 19:04:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpvtO-0001J0-Rz for git@vger.kernel.org; Fri, 01 Dec 2006 01:04:38 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 01:04:38 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01 Dec 2006
 01:04:38 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> At least for me, it turns out that the only mode I _never_ use personally 
> is the "git commit -i" thing, which was actually the original behaviour, 
> and which you'd think that I would encourage for that reason. But no. Of 
> all the modes of "git commit", that's the one I think is the least 
> important, and least interesting.
> 
> Of course, during a merge, you do need "-i" if you list files, but I think 
> "-a" subsumes almost all cases (you _can_ use "-i file-list" or totally 
> manually decide to have some extra edits you did that you don't want to 
> commit together with the merge, but that's such a special case that I 
> doubt anybody does it, so I don't think it's a big deal).
> 
> Anyway, we have "-i", and we don't force anybody to use it, so the fact 
> that it's a bit odd and not that useful doesn't really matter. It 
> certainly "fits" in the git commit family as another case, it's just not 
> one of the important cases.

So, in short, -i is easier to explain, but is also least used. Perhaps
also because one can simply update index with <files> before git commit
instead of doing "git commit -i <files>".
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

