From: Mike Hommey <mh@glandium.org>
Subject: Re: Question on git-filter-branch
Date: Thu, 1 Nov 2007 13:58:45 +0100
Organization: glandium.org
Message-ID: <20071101125845.GA27567@glandium.org>
References: <18217.52425.655322.52338@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 14:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZej-00034o-HV
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbXKAM7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbXKAM7k
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:59:40 -0400
Received: from vawad.err.no ([85.19.200.177]:36630 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615AbXKAM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:59:39 -0400
Received: from aputeaux-153-1-31-123.w82-124.abo.wanadoo.fr ([82.124.1.123] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InZe1-0005jk-8q; Thu, 01 Nov 2007 13:59:35 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InZdF-0007G4-VA; Thu, 01 Nov 2007 13:58:46 +0100
Content-Disposition: inline
In-Reply-To: <18217.52425.655322.52338@lisa.zopyra.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62950>

On Thu, Nov 01, 2007 at 06:55:37AM -0600, Bill Lear wrote:
> In my repo, I have sensitive files A, C, and a directory full of
> sensitive stuff I want to remove forever from the git repository.
> 
> % ls
> A B C D sensitive_stuff
> 
> % git --version
> git version 1.5.3.5
> 
> % git filter-branch --index-filter 'git update-index --remove A' HEAD
> Rewrite 5dd7d5f2d7d3a5f43c242188ac96294628267673 (7/7)
> Ref 'refs/heads/master' was rewritten
> 
> These refs were rewritten:
> % ls
> B  C  D  sensitive_stuff
> 
> % git status
> # On branch master
> nothing to commit (working directory clean)
> 
> Ok, so I guess it has done what I wanted.  So, I try to remove the
> next file that has sensitive information in it:
> 
> % git filter-branch --index-filter 'git update-index --remove C' HEAD
> Namespace refs/original/ not empty

Just remove .git/refs/original/

Mike
