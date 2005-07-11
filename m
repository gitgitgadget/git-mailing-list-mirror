From: Petr Baudis <pasky@suse.cz>
Subject: Re: arch 2.0 first source available (git related)
Date: Mon, 11 Jul 2005 21:39:44 +0200
Message-ID: <20050711193944.GA5981@pasky.ji.cz>
References: <1120867947.5882.2.camel@dev1.seyza.com> <20050709113942.GB26343@pasky.ji.cz> <1120918813.4901.27.camel@dev1.seyza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 21:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds49P-0007CJ-79
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 21:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVGKTkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 15:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGKTk0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 15:40:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35724 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262497AbVGKTjq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 15:39:46 -0400
Received: (qmail 10322 invoked by uid 2001); 11 Jul 2005 19:39:44 -0000
To: Thomas Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <1120918813.4901.27.camel@dev1.seyza.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 04:20:13PM CEST, I got a letter
where Thomas Lord <lord@emf.net> told me that...
> The prereq graph is, indeed, an improvement.  
..snip..

But object retrieval can be potentially as much as linear to the depth
of the prereq graph, right? I don't think any of the benefits you listed
are worth the complication, and you can still do the reachability
analysis pretty easily. (And I think it takes the same number of
roundtrips when downloading from remote server?)

> Other advantageous (imo) changes from `git' not mentioned in the
> original message:
> 
> * blobs do not have header lines
> 
>   Git blobs all begin with a line of text declaring the "type"
>   and size of the blob.   That doesn't increase database 
>   verifiability significantly and I found no use for the headers.
>   Having the headers makes it needlessly complicated to translate
>   a file to or from a blob.
> 
>   `revc' does not have blob headers.

In git, this is crucial at least for distinguishing commits and tags.
I personally consider the verifiability boost useful.

> * `revc' uses portable file formats
> 
>    In working dirs, `git' stores binary files which are 
>    endian, word-size, and compiler-environment specific.
> 
>    `revc' stores some binary files too (for performance
>    and simplicity reasons) but uses only portable formats.

I think they are only word-size specific, and that should be no big
matter to resolve, shall anyone want to.

> * `revc' is shaping up into much cleaner and more portable code
> 
>    (at least compared to the last version of `git' I saw --
>     which was extremely *lucid* code but not terribly
>     clean and not even attempting to be portable.)

All right, the portability could be better. ;-)

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
