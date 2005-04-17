From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 10:13:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171005220.7211@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504170451030.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:08:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDFM-00052q-BY
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDQRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVDQRLh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:11:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:6093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVDQRLf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:11:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HHBVs4003335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 10:11:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HHBUdb026713;
	Sun, 17 Apr 2005 10:11:31 -0700
To: Brad Roberts <braddr@puremagic.com>
In-Reply-To: <Pine.LNX.4.44.0504170451030.2625-100000@bellevue.puremagic.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Brad Roberts wrote:
>
> (ok, author looks better, but committer doesn't obey the AUTHOR_ vars yet)

They should't, but maybe I should add COMMITTER_xxx overrides. I just do 
_not_ want people to think that they should claim to be somebody else: 
it's not a security issue (you could compile your own "commit-tree.c" 
after all), it's more of a "social rule" thing. I prefer seeing bad email 
addresses that at least match the system setup to seeing good email 
addresses that people made up just to make them look clean.

Mind showing what your /etc/passwd file looks like (just your own entry, 
and please just remove your password entry if you don't use shadow 
passwords).

Maybe I should just remove _all_ strange characters when I do the name 
cleanup in "commit". Right now I just remove the ones that matter to 
parsing it unambiguosly: '\n' '<' and '>'.

(The ',' character really is special: some people have

	Torvalds, Linus

and maybe I should not just remove the commas, I should convert it to 
always be "Linus Torvalds". But your gecos entry is just _strange_. Why 
the extra commas, I wonder?)

		Linus
