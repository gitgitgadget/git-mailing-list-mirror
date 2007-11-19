From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 17:51:07 +0000
Message-ID: <b0943d9e0711190951u412b2c1apf6d7d48abdd59c07@mail.gmail.com>
References: <200711190005.49990.jnareb@gmail.com>
	 <200711191257.09158.jnareb@gmail.com>
	 <b0943d9e0711190515x3f58748bm224366ddb292755d@mail.gmail.com>
	 <200711191843.43247.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:52:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuAmO-0006qU-M4
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbXKSRvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbXKSRvN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:51:13 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:22610 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbXKSRvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:51:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1485137rvb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A1kWsZfypLChvvIE0QtOk99Tq/QlTsNP6sTzG+Ihj2A=;
        b=ZJKmf0P8ykTQ/MwixW5JuYNJktlNyPELeHj67e1BpWn0aHGOZjJwEfwz8TyaCmaQq2XZ5nhJKOYMOjnnD02vjAZ6kM5NXjCNrSGLibMN/i56n/Ct6uFo0ZXoiy2Papg76lL/hgIFuC4+mOiddzX+LPQXB/GDlIxi4FK3P8K3NQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LQavkdyMGEPoMnNffQceJnxBwvzSwKt1yaH/Lrd9lunEWU82zaTaly+4MDmmjgQrtIZvdu2j4OqU7t6HXsVKBTpT1erahBFNmNAnrqI8wNj9cd9Ecr4bD445BtBI9eu2ULPcDOpWQdCiMxy9rOq34ibtl9+F/XI3kjRebvI3lY8=
Received: by 10.140.180.42 with SMTP id c42mr1835842rvf.1195494667254;
        Mon, 19 Nov 2007 09:51:07 -0800 (PST)
Received: by 10.141.170.11 with HTTP; Mon, 19 Nov 2007 09:51:07 -0800 (PST)
In-Reply-To: <200711191843.43247.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65477>

On 19/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, does StGIT write something meaningful by default in reflog
> messages? Because now my reflog looks like this:

No, it leaves it up to GIT to write whatever it finds appropriate.

> It would be really nice if StGIT wrote something meaningfull when
> updating ref, like "stg refresh: <something>", or "stg rebase: <sth>"...

There is the 'stg log [<patch>]' command which shows the changes to a
specific patch. You can run it with -d (for the diff) or -g (to invoke
gitk).

-- 
Catalin
