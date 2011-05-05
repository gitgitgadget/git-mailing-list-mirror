From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 5 May 2011 17:25:30 +0200
Message-ID: <20110505152530.GC31229@camk.edu.pl>
References: <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
 <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net>
 <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
 <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
 <20110505142910.GA31229@camk.edu.pl>
 <4DC2B814.5070507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 17:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0Qu-0002P2-Di
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1EEPZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 11:25:37 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34602 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212Ab1EEPZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 11:25:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 5B5345F004B;
	Thu,  5 May 2011 17:25:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id x63OSqYT8K2P; Thu,  5 May 2011 17:25:30 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 71C475F0046;
	Thu,  5 May 2011 17:25:30 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 5FA5280AF5; Thu,  5 May 2011 17:25:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC2B814.5070507@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172838>

On second thought, I think the point A.1 and A.2 has to be changed and
merged to one:

On Thu, May 05, 2011 at 04:45:40PM +0200, Johannes Sixt wrote:
> A:

> > 1. ./configure --prefix=dir1  and dir1 != /usr

> >     git_etcdir = etc

> > 2. ./configure --prefix=/usr

> >     git_etcdir = /etc

1. ./configure --prefix=dir1

      git_etcdir = /dir1/etc

Otherwise there would be a conflict with:

./configure --help
    --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]

-- 
  Kacper Kornet
