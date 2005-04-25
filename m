From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 07:52:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 16:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ4qN-00086n-TO
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 16:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVDYOup (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVDYOup
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 10:50:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:4747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262618AbVDYOuj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 10:50:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PEoZs4029943
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 07:50:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PEoW9D016164;
	Mon, 25 Apr 2005 07:50:34 -0700
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: <426CD1F1.2010101@tiscali.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> The "git" didn't try store small variables, which aren't referenced, in 
> the processor registers. It also didn't use the size_t type. I corrected 
> a C++ style comment too.

What kind of ancient C standard are you working against?

// isn't "C++" any more, and "register" variables are sooo 60's, man.

Pass the toke,

		Linus
