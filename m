From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 09:57:57 +0200
Message-ID: <4816D505.1000208@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:58:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqkjf-0002vg-Fu
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbYD2H6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbYD2H57
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:57:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:52931 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbYD2H57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:57:59 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2148214nfb.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=2U0IF5quQaSkRW5SUBJUZjih/24PQzDQYlUl6AKz68A=;
        b=IJ5RCs5zKHt0Se/az3uxs2kWpLCLOqGhT+GVMHkaCILi1n/pDY2aZhhYSu/jVdleMPu5EzdfA6ZE/3XQplWjzbRIvy+Im4HNDzxupmJiBdGEwipIIXWcR7IYL7fpkxvU+htrzqWVWubzbi+SyFEavIow1LceVirOGxc/Qno1phU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=MAJ4JLSGM6dLyqk0IgnK9FYztKi8X8akpMNdAwTLGc5yZmwin7HaOIUkOcI7yL1IzCPOEYk8P0iNFRWN62NZRvKaBPTJ6WcX7yGgRTr9AZNJqlo5CN/ydfR5HM26eaHJhlIIQMcVGlO3gxl2NGu8oVEANMoPt63pavImgM7/2X0=
Received: by 10.210.29.11 with SMTP id c11mr6989726ebc.16.1209455877088;
        Tue, 29 Apr 2008 00:57:57 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id s10sm10948169muh.11.2008.04.29.00.57.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 00:57:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <4816CB46.1050100@op5.se>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80667>


>> Man, that's what release notes are for.  You are expected to read those.
> 
> So you actually read the release-notes for every application you have
> installed?

Not for every one, but I do for some applications.  Right now only git 
and autoconf come to mind.  Especially searching for the magic words 
"backwards incompatible" -- the more "power user" you are of an 
application, the more you should read the release notes.  And in the 
case of git I don't consider myself a power user but I learnt quite a 
few tricks from the release notes.

> Remind me to never employ you. I doubt you'd ever get any
> work done.

Well, the same should apply to reading mailing lists...

> Failing that, would you get slightly annoyed, or perhaps even quite
> vexed if you find out that insert-program-used-to-do-some-work-with-here
> did omething stupid that made you lose some of your work?

Sorry, how does the patch make you lose some of your work (as opposed to 
some of your time, which is possible as is the case for every backwards 
incompatible change)?

1) what about the reflog?

2) the patch does not touch refs/heads/* unless you are tweaking your 
configuration (and quite heavily so).  IMHO that's using enough rope 
that you really ought to know about the reflog and... look for backwards 
incompatible changes in the release notes!

3) your complaint was that it gave errors.  Alex did talk about losing 
his work, but questions 1 and 2 would apply to him too.

4) one man's stupidity is another man's... [fill in]  In particular, did 
you understand the rationale for this change?  Do you have any 
alternative ideas?

Paolo
