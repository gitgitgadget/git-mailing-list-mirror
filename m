From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] remote add: disallow --master and --mirror with non-bare
   repositories (review)
Date: Tue, 22 Apr 2008 20:46:44 +0200
Message-ID: <480E3294.4070807@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <7vd4ohzvda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:48:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNX8-0000Ja-Jj
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762827AbYDVSq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762352AbYDVSq5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:46:57 -0400
Received: from main.gmane.org ([80.91.229.2]:46744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbYDVSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:46:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoNVy-0008BH-Ko
	for git@vger.kernel.org; Tue, 22 Apr 2008 18:46:50 +0000
Received: from 213-140-22-65.fastres.net ([213.140.22.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 18:46:50 +0000
Received: from bonzini by 213-140-22-65.fastres.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 18:46:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 213-140-22-65.fastres.net
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80159>

> +	if (mirror && is_bare_repository())
> +		die("--mirror with non-bare repository.");
> +

Missing bang.  I think you need to adjust the testsuite, in fact.

Paolo
