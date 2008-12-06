From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: ETA for release of gjit 0.4?
Date: Sat, 6 Dec 2008 19:47:27 +0100
Message-ID: <200812061947.27905.robin.rosenberg.lists@dewire.com>
References: <49393BFC.6010606@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 19:49:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L92Di-00029E-Si
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 19:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYLFSri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYLFSri
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 13:47:38 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:60236 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbYLFSrh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2008 13:47:37 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02C66C1E; Sat, 6 Dec 2008 19:47:29 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <49393BFC.6010606@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102468>

fredag 05 december 2008 15:34:36 skrev Farrukh Najmi:
> 
> Dear colleagues,
> 
> I am using jgit in my maven project. Since current version is a SNAPSHOT 
> (0.4-SNAPSHOT) I cannot release my project with a SNAPSHOT dependency 
> (maven does not allow it). WHat is the time line for releasing version 
> 0.4 of jgit so I can plan accordingly.
> Thanks for any info.

What? Plan? :)

You could name the version something else like 0.3.1.42b27c 

It was a long time since we labeled anything. Shawn, how about merging
my recent close-file-patches, reverting 3ffa47d9294086fbd1cdeb9b1564f922a23e3c6f
and e7307f14c531d52cf231c39d844841c4adaf5e5a and then just call i 0.4 ?

-- robin

# from my pu branch, the latest Tentative build in the update site. Works quite well for
me. Refactoring and 
$ git log --pretty=oneline origin/master..pu
2aafc054446f9b3aecdc01687a6949e4c54be6eb Revert "Rewrite GitMoveDeleteHook to use DirCacheBuilder"
439277860e1e315b7f0cd339b2435cc8311956c1 Revert "Teach GitMoveDeleteHook how to move a folder recursively"
abc44bc6efa47c4c6e3c23f85fe9de9cd8460224 Improve closing of files in error situations.
22e2808ac2915446ed81115b663c684341ce6bdd Close a forgotten reference to the HEAD ref.
