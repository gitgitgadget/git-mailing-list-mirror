From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH 4/4] cg-{diff,mkpatch}: rename/copy optional detection
Date: Tue, 13 Sep 2005 19:41:24 +0200
Message-ID: <200509131941.26001.blaisorblade@yahoo.it>
References: <20050902103125.24918.905.stgit@zion.home.lan> <20050902103135.24918.7990.stgit@zion.home.lan> <20050912004502.GH15630@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 19:54:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFExr-0001cr-Nu
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 19:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVIMRxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 13:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVIMRxA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 13:53:00 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:37471 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964943AbVIMRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 13:52:59 -0400
Received: (qmail 4761 invoked from network); 13 Sep 2005 17:43:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=kDlrLDu6YOnjzVWOMhyTYmlj71fJ202QrHI4YOvigbmiWideYt/YRbggMqJAYohgu/M2reGUAa0a/uxec2fKFQL9Y2weDZlygkgnXivwTJtqMicnZwBCPtWtpVjRrfkY9N/TNgJQ9rFj2FIehz4UxMWQDKUBuA3FKG216JKtIdw=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.73.203 with login)
  by smtp001.mail.ukl.yahoo.com with SMTP; 13 Sep 2005 17:43:47 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.1
In-Reply-To: <20050912004502.GH15630@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8477>

On Monday 12 September 2005 02:45, Petr Baudis wrote:
> Dear diary, on Fri, Sep 02, 2005 at 12:31:38PM CEST, I got a letter
> where Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> told me
> that...
>
> > Add -B, -M and -C options to detect content rewrites, renames and changes
> > to cg-diff and cg-mkpatch, to be passed right down to git-diff-*.
> > I've not added a way to pass down any option, since not everything may
> > make sense, and a shell script colorizing --name-only-z output would not
> > play so nice (and I mean "unreliable behaviour" - not tested obviously).
>
> What about just by default doing full-blown detection, with an optional
> flag to do no detection (to produce patch-compatible diffs)? I don't
> think Cogito users usually need a more fine-tuned settings.
No problem for me, as long git is fast enough in handling that (guess yes).
> Obviously in that case we also have to fix cg-patch to process renames
> and stuff - but we should do that anyway. :-)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
