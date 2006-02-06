From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's new in git.git
Date: Mon, 6 Feb 2006 08:03:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602060754470.3854@g5.osdl.org>
References: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 17:05:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F68q0-0000Se-Iu
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 17:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBFQDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 11:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBFQDd
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 11:03:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbWBFQDd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 11:03:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k16G3TDZ018963
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Feb 2006 08:03:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k16G3SNo015112;
	Mon, 6 Feb 2006 08:03:29 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15653>



On Sun, 5 Feb 2006, Junio C Hamano wrote:
> 
>  * Add -c and --cc to diff-tree and diff-files.  They give the
>    "combined diff" output that shows merges more human readably.

Btw, the only concern I have left about "-c" and "--cc" is that I don't 
think the old merge-diff behaviour makes any sense at all, and that we 
should drop it entirely in favour of "-c" and "--cc".

The old merge-diff code was so useless that nobody ever used it. It was 
disabled by default (you had to enable it specially with the "-m" flag), 
and I don't think anybody really ever did. The output was just not usable.

The only reason it existed at all was really because I _didn't_ do it 
right, and I wanted some output.

So I would actually much prefer that "-c" would be the default, and that 
"-p" would imply "--cc". With some other option to have the "long format" 
diff.

Has anybody on the git list ever used "-m" with git-diff-tree? Speak up..

		Linus
