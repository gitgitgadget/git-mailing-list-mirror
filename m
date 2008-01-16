From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 08:18:32 +0100
Message-ID: <20080116071832.GA2896@steel.home>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Umbers <paul.umbers@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 08:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF2YF-0001M4-Up
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 08:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYAPHSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 02:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbYAPHSi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 02:18:38 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:36049 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbYAPHSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 02:18:38 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolErE4=
Received: from tigra.home (Faa76.f.strato-dslnet.de [195.4.170.118])
	by post.webmailer.de (fruni mo35) (RZmta 15.4)
	with ESMTP id a04007k0G1SxHa ; Wed, 16 Jan 2008 08:18:35 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D9590277AE;
	Wed, 16 Jan 2008 08:18:34 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 153C956D22; Wed, 16 Jan 2008 08:18:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200801160002.51048.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70645>

Robin Rosenberg, Wed, Jan 16, 2008 00:02:49 +0100:
> tisdagen den 15 januari 2008 skrev Paul Umbers:
> > git ls (see below) returns nothing - it looks like the object doesn't
> > exist at all. I've attached a .zip of the entire test directory (one
> > text file plus .git). This is after "git init" followed by "git add ."
> > 
> > What do you think?
> 
> Git comes with test suite. Try it using make test or

He has just the precompiled packages from cygwin

> GIT_TEST_OPTS="--debug --verbose" make test
> 
> The extra options are there since we expect it to fail.
> 

But when compiled, it would be useflul indeed to see how the tests run
