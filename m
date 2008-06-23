From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline
 functions
Date: Sun, 22 Jun 2008 21:54:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806222150180.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>  <46d6db660806221432m6a6e2f3egf78faa1510f8d643@mail.gmail.com> <46d6db660806221801j7207e6b0sdf91c2243fad5349@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 06:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAe6E-0002UE-Kw
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 06:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYFWEyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 00:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbYFWEyo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 00:54:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56600 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750924AbYFWEyo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 00:54:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5N4s2hK028975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jun 2008 21:54:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5N4s2ab011506;
	Sun, 22 Jun 2008 21:54:02 -0700
In-Reply-To: <46d6db660806221801j7207e6b0sdf91c2243fad5349@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.345 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85833>



On Mon, 23 Jun 2008, Christian MICHON wrote:
> 
> There's more than 80k difference with your figures (I have not even
> applied your patch yet).
> May I ask which version of gcc you're using ? The numbers you provided
> were really with -Os ?

gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) 

Also notice that this is x86-64, maybe you're 32-bit? 

You also have much smaller size difference (616606 -> 591554 is just over 
16kB), but if my version of gcc bloats things up more, then I'm not 
surprised that the difference is bigger too.

			Linus
