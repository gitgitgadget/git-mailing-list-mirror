From: bert hubert <ahu@ds9a.nl>
Subject: Re: "True" git merge in git-pasky
Date: Tue, 19 Apr 2005 07:43:07 +0200
Message-ID: <20050419054307.GA1528@outpost.ds9a.nl>
References: <20050419035107.GB5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 07:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNlSI-0006OF-B2
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 07:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVDSFnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 01:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDSFnO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 01:43:14 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:61676 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261329AbVDSFnK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 01:43:10 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id C6F7640BB; Tue, 19 Apr 2005 07:43:07 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050419035107.GB5554@pasky.ji.cz>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 05:51:07AM +0200, Petr Baudis wrote:
> 	http://pasky.or.cz/~pasky/dev/git

I pulled the tar.bz2 and did make:
gcc -g -O3 -Wall -o merge-cache merge-cache.o libgit.a libgit.a -lssl -lz
gcc -g -O3 -Wall   -c -o unpack-file.o unpack-file.c
gcc -g -O3 -Wall -o unpack-file unpack-file.o libgit.a libgit.a -lssl -lz
make: commit-id: Command not found
Generating gitversion.sh...

Is this bad?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
