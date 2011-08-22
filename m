From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Mon, 22 Aug 2011 00:32:54 +0000 (UTC)
Message-ID: <j2s83l$eqg$1@dough.gmane.org>
References: <j2ru2h$cd$1@dough.gmane.org>
	<CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
	<CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 02:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvIS2-0005Ik-4S
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 02:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1HVAdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 20:33:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:60500 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1HVAdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 20:33:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QvIRu-0005HO-Jb
	for git@vger.kernel.org; Mon, 22 Aug 2011 02:33:06 +0200
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 02:33:06 +0200
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 02:33:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.134 (Wait for Me; Unknown)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179829>

On Sun, 21 Aug 2011 23:53:34 +0000, Michael Witten wrote:
> Importantly, note that I used only file names in my example,
> specifically:
> 
>   5. [master]  rename dir1/file3 to dir3/file3
> 
> rather than mirroring your example by writing:
> 
>   5. [master]  rename dir1 to dir3
> 
> This is because git fundamentally tracks content, and paths are just one
> kind of content associated with another blob of content. Consequently,

I know it tracks content, yet it puts effort to detect file renames.
I want it to also detect directory renames, detecting it should be quite 
easy.

> git really knows next to nothing about directories, so it's not too
> surprising that git doesn't bother finding such a DIRECTORY rename
> anyway (at most, git would detect a FILE rename, and your FILE
> `dir1/file2' has nothing to do with, say, the FILE `dir1/file1' being
> renamed `dir2/file1').
> 
> Still, some command line switches could be useful to help the user
> express to git what should be going on in a case such as yours.

I would prefer it to be fully automatic :)
Or at least detect/warn about tree conflict.
Directory renames can happen quite frequently when working with Java/C# 
and it is unreasonable to expect that lazy user will have to keep track of 
it manually (with huge number of files it's impossible).
