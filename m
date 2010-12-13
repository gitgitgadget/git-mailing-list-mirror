From: Stephen Bash <bash@genarts.com>
Subject: Re: Splitting a repository but sharing the common parts of the
 object database
Date: Mon, 13 Dec 2010 14:50:50 -0500 (EST)
Message-ID: <31673515.186200.1292269850925.JavaMail.root@mail.hq.genarts.com>
References: <20101213192053.GA30315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Phillip Susi <psusi@cfl.rr.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSEQJ-0002oA-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0LMTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:50:58 -0500
Received: from hq.genarts.com ([173.9.65.1]:64493 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753440Ab0LMTu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:50:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 13E261E2635C;
	Mon, 13 Dec 2010 14:50:57 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-IsDZLc+6IM; Mon, 13 Dec 2010 14:50:51 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id F3A431E2634C;
	Mon, 13 Dec 2010 14:50:50 -0500 (EST)
In-Reply-To: <20101213192053.GA30315@burratino>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163587>

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> To: "Phillip Susi" <psusi@cfl.rr.com>
> Cc: git@vger.kernel.org
> Sent: Monday, December 13, 2010 2:20:53 PM
> Subject: Re: Splitting a repository but sharing the common parts of the object database
> Hi Phillip,
> 
> Phillip Susi wrote:
> 
> > If I run a repack -a, then the new project has everything copied out
> > of the archive and into its new main pack, rather than continuing to
> > use the archive repository for old history, and just pack everything
> > since then. I guess I am looking for is somewhere between a full repack
> > and an incremental; a way to make repack -a discard existing local
> > packs, but to respect the alternate packs and omit objects they contain
> > from the new local pack.
> 
> You might be interested in girocco's fork support. See
> http://repo.or.cz/w/girocco.git/blob/HEAD:/jobd/gc.sh for starters.

You might also be interested in Pro Git's entry on git-replace:

  http://progit.org/2010/03/17/replace.html

It's a completely different approach than what you're suggesting, but might open up new and interesting avenues.

Stephen
