From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 18:01:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231759010.2344@ppc970.osdl.org>
References: <1114280570.5068.5.camel@mulgrave>  <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
  <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz>
 <1114298490.5264.10.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:55:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPVOw-0001ny-04
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVDXA74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVDXA74
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:59:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:3551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262212AbVDXA7z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:59:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O0xps4020882
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 17:59:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O0xmqx024048;
	Sat, 23 Apr 2005 17:59:48 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1114298490.5264.10.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, James Bottomley wrote:
> 
> This is the actual diff

This is _still_ corrupted. 

Are you editing your diffs by hand without understanding how the diffs 
work?

The second chunk of the "git-merge-one-file" diff _still_ claims to change 
twelve lines, and that diff _still_ only changes eleven lines. My "patch" 
isn't happy, and I can count the lines in the diff myself and verify that 
it's not patch that is wrong, it's your diff.

Please please _please_ don't edit diffs by hand if you don't know what 
you're doing. Generate the diff from a clean source instead. Or ask me to 
fix it up, I'm so used to editing diffs that I can do it in my sleep.

		Linus
