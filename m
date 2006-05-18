From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 10:22:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181020570.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
 <7v64k3698l.fsf@assigned-by-dhcp.cox.net> <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605180807060.10823@g5.osdl.org> <Pine.LNX.4.64.0605180917060.10823@g5.osdl.org>
 <Pine.LNX.4.64.0605180929450.10823@g5.osdl.org> <7vzmhfnupz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 19:22:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgmCk-0004Sy-QM
	for gcvg-git@gmane.org; Thu, 18 May 2006 19:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWERRWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWERRWK
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 13:22:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751375AbWERRWI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 13:22:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IHM4tH021614
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 10:22:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IHM3GP026682;
	Thu, 18 May 2006 10:22:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmhfnupz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20293>



On Thu, 18 May 2006, Junio C Hamano wrote:
> 
> Perhaps, but unresolve splits an entry that is available from
> the heads being merged, so it would use unverified filename to
> try finding the ents from trees, but get_tree_entry() would not
> find one, so I think we are safe already.

Yes, I agree, that looks safe.

> I doubt this would break people's scripts.  If they were relying
> on the old behaviour, that means they threw real paths and
> garbage at update-index and relied on it to sift them apart,
> which indicates they were buggy to begin with anyway.

Agreed. I don't think the semantic change can really break anything, and 
if anything will probably help expose any really strange/broken stuff.

		Linus
