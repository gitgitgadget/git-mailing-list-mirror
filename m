From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-unpack-objects
Date: Wed, 3 May 2006 10:41:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com> 
 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net> <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:42:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLMU-0006re-6w
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWECRmC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWECRmC
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:42:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030265AbWECRmA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:42:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43HfstH009430
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 10:41:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43HfpWt008324;
	Wed, 3 May 2006 10:41:52 -0700
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19506>



On Wed, 3 May 2006, Josh Boyer wrote:
> 
> Hm..  so it seems that git-unpack-objects is more intended to unpack a
> pack one has gotten with git-fetch-pack, right?

Yeah. And for testing. I don't think it ever gets used directly.

> I was looking for something more along the lines of an
> "un-git-repack", where you have existing pack(s) and want to undo
> them.  Maybe you want to repack everything into a single pack or
> something like that.

That's what you just do "git repack -a -d" for.

		Linus
