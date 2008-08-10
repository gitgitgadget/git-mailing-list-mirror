From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git vs Monotone
Date: Mon, 11 Aug 2008 00:15:40 +0200
Message-ID: <200808110015.41258.robin.rosenberg.lists@dewire.com>
References: <8778C923356C6541B263428246AE9C2A4FE2966B09@NA-MAIL-2-2.rws.ad.ea.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Blum, Robert" <rblum@pandemicstudios.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:17:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJEM-0006PS-IZ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYHJWQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbYHJWQk
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:16:40 -0400
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:56742 "EHLO
	av10-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYHJWQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:16:40 -0400
Received: by av10-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 294AA37F6C; Mon, 11 Aug 2008 00:16:38 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 01E2137E8F; Mon, 11 Aug 2008 00:16:38 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 7DE2137E46;
	Mon, 11 Aug 2008 00:16:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <8778C923356C6541B263428246AE9C2A4FE2966B09@NA-MAIL-2-2.rws.ad.ea.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91890>

torsdagen den 31 juli 2008 22.42.08 skrev Blum, Robert:
> 
> >The fact is, even without "-s", a local clone will do hardlinks for the
> >database. And since the original pack-file is marked as a 'keep' file,
> >that original pack-file won't even be broken apart.
> 
> Then again, Pidgin is, among other things, a Windows project. I.e. hardlinks are not exactly trivial. There's a good chance nobody jumped through the hoops of junction points for git on win32... (Somebody correct me if I'm wrong)

Windows does hardlinks for files since NT 3.51 on NTFS. Cygwin supports it too.  Symbolic links are another story. 

-- robin
