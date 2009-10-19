From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Mon, 19 Oct 2009 02:44:47 +0200
Message-ID: <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 02:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzgMq-00086V-G8
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 02:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbZJSAop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 20:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbZJSAoo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 20:44:44 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49139 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZJSAoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 20:44:44 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzgMh-0000ln-V3; Mon, 19 Oct 2009 02:44:47 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzgMh-0003ct-Rn; Mon, 19 Oct 2009 02:44:47 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910181727130.32515@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130631>

Hi all,

thanks everyone for the nice feedback!

On So, 18 Okt 2009, Daniel Barkalow wrote:
> It's possible as long as you don't think of the "version number" as a 
> property of the commit, but rather a property that some commits get by 
> virtue of having been at some time the commit that's what would be found 
> on that particular server at that particular time. Even though the history 

Right! That is a good point. In fact I don't care about (local) commits,
but about the pushes to the central server.

> of the *content* is non-linear, the sequence of values stored in 
> refs/heads/master on your central server is linear, local, and easy to 
> enumerate.

That is exactely what I need.

> Of course, when someone does a bunch of development in parallel with other 
> people, does a final merge, and pushes it back to the server, this only 
> increases the version by one, and only the final merge actually has a 

As it is now with svn, we have to live with that. The point is that we
still would see many different commits pushed to the server, so 
git log would show the single items, but the "versioning sequence number"
is only increased by one. That would be *absolutely*perfect* for me!

> because the intermediate commits don't ever get packages created of them 
> to need to be compared to other packages.

Right!

Now my follow-up questions:
- how would one access this "sequence" number on the server
- is there a way to determine at which of this "sequence" numbers a specific
  file has been changed last?


Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DULEEK (n.)
Sudden realisation, as you lie in bed waiting for the alarm to go off,
that it should have gone off an hour ago.
			--- Douglas Adams, The Meaning of Liff
