From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Mon, 4 Oct 2010 15:05:58 -0700
Message-ID: <20101004220558.GA29932@dcvr.yhbt.net>
References: <20100924162704.GA4513@dcvr.yhbt.net> <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com> <20100925042457.GA28899@dcvr.yhbt.net> <4CA9889E.1020604@debugon.org> <7vhbh197ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Lafeldt <misfire@debugon.org>, git@vger.kernel.org,
	Steven Walter <stevenrwalter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tAd-0003tb-4r
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0JDWGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:06:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51348 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab0JDWGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:06:00 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079431F488;
	Mon,  4 Oct 2010 22:05:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhbh197ut.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158127>

Junio C Hamano <gitster@pobox.com> wrote:
> I found these four near Eric's 'master':
> 
>   833fde5 git-svn: allow the mergeinfo property to be set
>   8565a56 git-svn: fix processing of decorated commit hashes
>   a3c7505 git-svn: check_cherry_pick should exclude commits already in our history
>   c9be27f Documentation/git-svn: discourage "noMetadata"
> 
> They all (perhaps except the very tip one) look fixes not enhancements, so
> I'll merge it to 'maint', so it can appear in 'master' and also in 1.7.3.2
> in due course.
> 
> If 833fde5 needs to be excluded from 'maint', please advise.

Yes, 833fde5 is an enhancement so it should be left out of 'maint'.

In the future, I suppose I could maintain my own 'maint' branch to make
your life easier.

-- 
Eric Wong
