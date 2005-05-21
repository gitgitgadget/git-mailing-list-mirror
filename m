From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk-1.0 released
Date: Sat, 21 May 2005 09:35:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505210934290.2206@ppc970.osdl.org>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com> 
 <20050519132411.GA29111@elte.hu>  <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
  <d6l9l1$ttd$1@sea.gmane.org>  <Pine.LNX.4.58.0505201150220.2206@ppc970.osdl.org>
 <2cfc40320505202340e5d1aee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kari Hameenaho <khaho@kolumbus.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 18:33:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZWts-0003oW-Hn
	for gcvg-git@gmane.org; Sat, 21 May 2005 18:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEUQdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVEUQdi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 12:33:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:19862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbVEUQdg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 12:33:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LGXUjA002770
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 09:33:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LGXSXd005116;
	Sat, 21 May 2005 09:33:28 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320505202340e5d1aee@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Jon Seymour wrote:
>
> >     - mark everything reachable from OLD_HEAD as being uninteresting (aka
> >       "seen"), and everything that reaches OLD_HEAD as being interesting
> >       and print it out.
> 
> Won't this step end up traversing back to the root anyway?

Sorry, bad wording on my part. Here "reachable" means only withing the 
context of "currently parsed", not "globally reachable".

So no, the reachability tests would not traverse anywhere new.

		Linus
