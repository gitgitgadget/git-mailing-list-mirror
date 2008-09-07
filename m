From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Sat, 6 Sep 2008 21:50:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>  <alpine.LFD.1.10.0808141442150.4352@xanadu.home>  <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141633080.4352@xanadu.home> 
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>  <7vk5dorclv.fsf@gitster.siamese.dyndns.org>  <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org> 
 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>  <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org> <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 06:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcCG1-0008JE-DF
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 06:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbYIGEvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 00:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYIGEvK
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 00:51:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172AbYIGEvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 00:51:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m874oYN6006275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Sep 2008 21:50:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m874oYjK020347;
	Sat, 6 Sep 2008 21:50:34 -0700
In-Reply-To: <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95111>



On Sat, 6 Sep 2008, Jon Smirl wrote:
> 
> When I was playing with those giant Mozilla packs speed of zlib wasn't
> a big problem. Number one problem was the repack process exceeding 3GB
> which forced me to get 64b hardware and 8GB of memory. If you start
> swapping in a repack, kill it, it will probably take a month to
> finish.

.. and you'd make things much much WORSE?

> Size and speed are not unrelated.

Jon, go away.

Go and _look_ at those damn numbers you tried to point me to.

Those "better" compression models you pointed at are not only hundreds of 
times slower than zlib, they take hundreds of times more memory too!

Yes, size and speed are definitely not unrelated. And in this situation, 
when it comes to compression algorithms, the relationship is _very_ clear:

 - better compression takes more memory and is slower

Really. You're trying to argue for something, but you don't seem to 
realize that you argue _against_ the thing you think you are arguing for.

		Linus
