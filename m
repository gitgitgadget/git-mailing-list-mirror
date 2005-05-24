From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 14:14:42 -0700
Message-ID: <42939942.9080807@zytor.com>
References: <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Mansfield <david@cobite.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dagjk-0007KN-Ie
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVEXVPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVEXVPk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:15:40 -0400
Received: from terminus.zytor.com ([209.128.68.124]:38348 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262194AbVEXVPL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 17:15:11 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4OLEsJl005285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 14:14:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.7 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> I don't like source repositories with dot-files, and I thought it was a
> good idea to disallow them, but on the other hand I'd like it even less if
> some CVS-weenie goes and says "I can't convert my project to git without
> potentially losing information".
> 
> So in the name of furthering humanity through allowing people to migrate
> away from CVS, I'm considering making the git dot-file check be more
> specific to "." ".." and ".git". After all, project-specific rules might
> have their own porcelain-related ignore-files that cause dot-files to
> never appear..
> 

There is another good reason to allow dot files: since git handles 
sparse trees well, and only needs metadata at the top level, it's pretty 
ideal for keeping track of people's account profiles across accounts, 
and that's mostly dot files.

I was considering using CVS for that at one point, but the way CVS 
distributes its metadata and recurses makes that insane.  For git, it 
would be trivial.

	-hpa
